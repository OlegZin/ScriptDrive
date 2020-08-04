unit uScriptDrive;

interface

uses RTTI,  Classes, SysUtils, RegularExpressions;

type

    TScriptDrive = class
    private
        function GetMethodName(command: string): string;
        function GetParams(command: string): TStringList;
        function CalcMath(command: string): string;
    public
        constructor Create;
        procedure SetClass( cls: TClass; obj: TObject );
        function Exec(scrt:string): string;
    end;

var
    Script: TScriptDrive;

implementation


var
    parser: TStringList;
    R : TRttiContext;
    T : TRttiType;
    M : TRttiMethod;
    V : TValue;
    _obj: TObject;
    regFunction: TRegEx;
    regMath: TRegEx;

function TScriptDrive.Exec(scrt:string): string;
var
    method, line: string;
    params: TStringList;
    i, j : integer;
    prs: TStringList;

    match : TMatch;
begin
    if not Assigned(T) then
    begin
        result := 'Класс не задан.';
        exit;
    end;

    prs := TStringList.Create;

    /// полученный набор команд разбиваем на строки и выполняем по отдельности
    prs.Text := StringReplace(scrt, ';',#13#10,[rfReplaceAll, rfIgnoreCase]);
    for I := 0 to prs.Count-1 do
    begin

        line := prs[i];
        // в строке команды ищутся вложенные функции и исполняются раньше основной
        // пример: functionA (1,2, functionB( 3 ,4 ),functionC(functionD(5, {6 + 54 + 3} ) ), functionE( {jgj+functionF(7)} ))+UseItem(RestoreHeal)
        // где значение с {} -

        // регулярка находит в строке функцию, которая
        // не содержит вложенных, т.е. для данного примера это:
        // functionB( 3 ,4 )
        // functionD(5, {6 + 54 + 3} )
        // functionF(7)
        // UseItem(RestoreHeal)

        // алгоритм работы:
        // 1. в цикле производим поиск регуляркой
        // 2. при наличии непустого результата получаем чистую функцию для обработки
        // 3. обрабатываем и вставляем результат вместо нее в основную строку
        // 4. при отсутствии резултата поиска - расчет окончен
        // 5. перед выдачей результата проверяем нет ли там кусков алгебры ({}) и вычисляем при необходимости

        // прогоняем строку скрипта через регулярку, получаем массив распознанных элементов
        repeat

            match := regFunction.Match(line);

            method := GetMethodName(match.Value);
            params := GetParams(match.Value);

            /// в данный момент у нас есть имя метода и все его параметры в виде отдельных строк
            /// предполагается, что любой из параметров уже не является фенкцией, а ее результатом,
            /// но может являться или содержать математическое выражение ( в {} скобках )
            /// фигурные скобки добавлены для возможности математических вычислений в составе строки не являющейся функцией
            /// например: "Добавлено вычисленное значение {5+8}, что иногда удобно."
            for j := 0 to params.Count-1 do params[j] := CalcMath(params[j]);



            for M in t.GetMethods do
                if (m.Parent = t) and (AnsiUpperCase(m.Name) = AnsiUpperCase(method))then
                begin
                    if   params.Count = 0
                    then V := M.Invoke(_obj,[]);

                    if   params.Count = 1
                    then V := M.Invoke(_obj,[params.CommaText]);

                    if   params.Count = 2
                    then V := M.Invoke(_obj,[params[0], params[1]]);

                    if   params.Count = 3
                    then V := M.Invoke(_obj,[params[0], params[1], params[2]]);

                    if not V.IsEmpty then result := V.AsString;


                end;

            line := StringReplace(line, match.Value, result, []);

        until match.Value = '';
    end;
    prs.Free;

    result := trim(line);
end;

function TScriptDrive.GetMethodName(command: string): string;
begin
    result := Trim(Copy(command, 0, Pos('(', command)-1));
end;

function TScriptDrive.GetParams(command: string): TStringList;
var spos : integer;
begin
    result := TStringList.Create;
    result.StrictDelimiter := true;
    spos := Pos('(', command);
    result.CommaText := Copy(command, spos+1, Pos(')', command)-1 - spos);

end;

procedure TScriptDrive.SetClass(cls: TClass; obj: TObject);
begin
    T := R.GetType(cls);
    _obj := obj;
end;

function TScriptDrive.CalcMath(command: string): string;
/// ищем и вычисляем математическое выражение в полученной стоке
/// https://habr.com/ru/post/282379/ - обратная польская нотация
///    1. преобразуем строку в массив операторов и операндов по польской нотации
///    2. вычисляем по полученному массиву
///
/// все элементы строки разделяются пробелами, что облегчает разложение с помощю TStringList.
/// использование различных скриптовых движков и компонент, не желательно
var
    mth, toCalc,
    operation : string;
    operandA, operandB: integer;
    i : integer;
    beg: integer;
    parse: TStringList;
    notation: TStringList;
    digit, oper: TStringList;
    found: boolean;

    HiPrior : string;
    LowPrior : string;

    match : TMatch;
begin
    result := command;

    HiPrior := '()*/';
    LowPrior := '+-';

    /// ищем наличие математики
    if Pos('{', command) = 0 then exit;

    /// вырезаем арифметику в отдельную строку для обработки
    beg := pos('{', command) + 1;
    mth := copy(command, beg, pos('}', command)-beg);

    mth := '('+mth+')';

    // убираем избыточные пробелы для исключения пустых строк при разбиении через TStringList
    while Pos('  ', mth) > 0 do
        mth := StringReplace(mth, '  ', ' ', [rfReplaceAll]);

    // создаем парсер
    parse := TStringList.Create;
{    notation := TStringList.Create;  // нотация для дальнейшего вычисления
    digit := TStringList.Create;     // стек чисел при разборе parse
    oper := TStringList.Create;      // стек операндов при разборе parse

    // запихиваем формулу в парсер. она автоматом разбивается на отдельные строки по запятым и пробелам
    parse.CommaText := mth;

    // перебираем элементы формулы и формируем массив польской нотации
    for I := 0 to Length(parse) do
    begin
        if Trim(parse[i]) = '' then continue;

    end;
}

    /// в данный момент у нас есть строка без лишних пробелов, без функций, с числами, арифметическими операндами и скобками.
    /// в первую очередь требуется избавиться от скобок, т.е. вычленять и вычислять группы между открывающей и закрывыающей скобкой,
    /// в которой отсутствуют вложенные группы (скобки).
    /// таким образом, задача сводится к вычислению групп без скобок, а просто с учетом веса операторов
    /// регулярка: \((\s*\d*\s*[\+\-\*\/]?)*\)
    /// пример: (10 + (3 * 6) + (3 * 5 + 3))
    /// находит: (3 * 6) и (3 * 5 + 3)

    // ищем подстроку в скобках и без вложенных скобок
    repeat
        match := regMath.Match(mth);

        // получаем выражение без скобок
        toCalc := copy(match.Value, 2, Length(match.Value)-2);

        repeat

          found := false;
          operation := '';

          // разбиваем на отдельные операторы и операнды
          parse.CommaText := toCalc;

          // если это не первый цикл вычислений - образуются пустые строки, которые нужно вычистить
          for I := parse.Count-1 downto 0 do
          if parse[i] = '' then parse.Delete(i);

          // чистим каждый из них от лишних пробелов
//          for I := 0 to parse.Count-1 do parse[i] := Trim(parse[i]);

          // пробегаем по набору строк и ищем сначала операторы с высшим приоритетом ( умножение, деление)
          for I := 0 to parse.Count-1 do
          if pos(parse[i], HiPrior) > 0 then
          begin
              found := true;
              operandA := StrToInt(parse[i-1]);
              operation := parse[i];
              operandB := StrToInt(parse[i+1]);
              break;
          end;

          if operation <> '' then
          begin
              /// вычисляем, сохраняя результат на мете первого операнда
              if operation = '*' then
              operandA := operandA * operandB;

              if operation = '/' then
              operandA := Round(operandA / operandB);

              // оператор и второй операнд - чистим
              parse[i-1] := IntToStr(operandA);
              parse[i] := '';
              parse[i+1] := '';
          end;

          /// собираем получившееся обратно в строку для повторной проверки
          /// при этом, на следующем цикле пустые места операнда и второго оператора будут
          ///  предвирительно вычищены, что сократит список
          toCalc := parse.CommaText;

        until not found;

        repeat

          found := false;
          operation := '';

        // разбиваем на отдельные операторы и операнды
          parse.CommaText := toCalc;

          // если это не первый цикл вычислений - образуются пустые строки, которые нужно вычистить
          for I := parse.Count-1 downto 0 do
          if parse[i] = '' then parse.Delete(i);

          // чистим каждый из них от лишних пробелов
//          for I := 0 to parse.Count-1 do parse[i] := Trim(parse[i]);

          // пробегаем по набору строк и ищем сначала операторы с высшим приоритетом ( умножение, деление)
          for I := 0 to parse.Count-1 do
          if pos(parse[i], LowPrior) > 0 then
          begin
              found := true;
              operandA := StrToInt(parse[i-1]);
              operation := parse[i];
              operandB := StrToInt(parse[i+1]);
              break;
          end;

          if operation <> '' then
          begin
              /// вычисляем, сохраняя результат на мете первого операнда
              if operation = '+' then
              operandA := operandA + operandB;

              if operation = '-' then
              operandA := operandA - operandB;

              // оператор и второй операнд - чистим
              parse[i-1] := IntToStr(operandA);
              parse[i] := '';
              parse[i+1] := '';
          end;

          /// собираем получившееся обратно в строку для повторной проверки
          /// при этом, на следующем цикле пустые места операнда и второго оператора будут
          ///  предвирительно вычищены, что сократит список
          toCalc := parse.CommaText;

        until not found;

    until regMath.Match(mth).Value <> '';

    result := toCalc;
end;

constructor TScriptDrive.Create;
begin
    parser := TStringList.Create;
    parser.StrictDelimiter := true;

    regFunction:=TRegEx.Create('\w+\s*\(\s*((\{((\d+|\w+)\s*[\+\-\*\/]?\s*)*\}|(\w+|[\+\-\*\/\!\?\.]))\s*\,*\s*)*\)');
    regMath := TRegEx.Create('\((\s*\d*\s*[\+\-\*\/]?)*\)');

end;

end.
