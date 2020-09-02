unit uScriptDrive;

interface

uses RTTI,  Classes, SysUtils, RegularExpressions, Generics.Collections, Math;

type

    TScriptDrive = class
    private
        fVars: TDictionary<String,String>;
        fCash : TDictionary<String,TRttiMethod>;
        function GetMethodName(command: string): string;
        function GetParams(command: string): TStringList;
        function CalcMath(command: string): string;
    public
        constructor Create;
        destructor Destroy;
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
    M, _M : TRttiMethod;
    V : TValue;
    _obj: TObject;
    regFunction: TRegEx;
    regMath: TRegEx;
    regNotExec: TRegEx;

function TScriptDrive.Exec(scrt:string): string;
var
    method, line, varName: string;
    params: TStringList;
    i, j : integer;
    prs: TStringList;

    match : TMatch;
    matches : TMatchCollection;

    found,
    scriptCommand  // признак того, что в данный момент обрабатывается управляющая команда движка
            : boolean;
    passCount      // сколько еще команд скрипта нужно пропустить
            : integer;
begin
    if not Assigned(T) then
    begin
        result := 'Класс не задан.';
        exit;
    end;

    prs := TStringList.Create;


    /// в скриптах могут находиться куски в " кавычках, как неисполняемые параметры для функций
    /// для их маскировки при поиске выполняемых кусков в текущей стрке, будем их вырезать и заменять
    /// переменными, которые будут автоматом подставляться обратно методом CalcMath
    repeat
        match := regNotExec.Match(scrt);
        if match.Value <> '' then
        begin
            /// добавляем невыполняемый скрипт в буффер
            varName := 'Var'+IntToStr(fVars.Count);
            fVars.Add( varName, copy(match.Value, 2, Length(match.Value)-2) );
            /// подменяем строку именем переменной из кэша
            scrt := StringReplace(scrt, match.Value, '['+varName+']', []);
        end;
    until match.Value = '';


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
        if (passCount <= 0)  then
        repeat

            match := regFunction.Match(line);
            matches := regFunction.Matches(line);


            method := GetMethodName(match.Value);
            params := GetParams(match.Value);

            /// в данный момент у нас есть имя метода и все его параметры в виде отдельных строк
            /// предполагается, что любой из параметров уже не является фенкцией, а ее результатом,
            /// но может являться или содержать математическое выражение ( в {} скобках )
            /// фигурные скобки добавлены для возможности математических вычислений в составе строки не являющейся функцией
            /// например: "Добавлено вычисленное значение {5+8}, что иногда удобно."
            for j := 0 to params.Count-1 do params[j] := CalcMath(params[j]);


            /// проверка, не является ли текущая функция сервисной.
            /// например, цикл, логическая проверка и т.п.
            /// данные функции реализуются самим скриптовым движком и отсутствуют в управляемом классе
            scriptCommand := false;


            /// команда проверки условия вида:
            ///    IF(check, lines);
            ///    где
            ///    check - текст 'true'/'false', который можно получить с помощью
            ///            математического выражения с использованием операторов '>' '<' '=',
            ///    lines - количество команд, которые будут пропущены, если check = 'false'
            ///
            ///    пример использования:
            ///
            ///    If({GetPlayerItemCount(Gold) > 9999}, 4);
            ///    SetVar(iName, GetRandItemName());
            ///    ChangePlayerItemCount(GetVar(iName), 1);
            ///    ChangePlayerItemCount(Gold, -9999);
            ///    AddEvent(Player get GetVar(iName)!);
            ///
            ///    здесь все 4 последующие команды будут выполнены, если у игрока
            ///    в наличии больше 9999 золота, иначе 4 команды будут пропущены
            ///    и предмет не будет получен (не хватило денег)

            if AnsiUpperCase(method) = 'IF' then
            begin
                scriptCommand := true;
                if params.Count = 2 then
                begin
                    if params[0] <> 'true'
                    then passCount := StrToIntDef(params[1], 0) + 1; // +1 = учитываем и текущую команду
                    result := '';
                end;
            end;

            if AnsiUpperCase(method) = 'RAND' then
            begin
                scriptCommand := true;
                if params.Count = 1 then
                    result := IntToStr(Random(StrToIntDef(params[0], 0)));
            end;

            if AnsiUpperCase(method) = 'MIN' then
            begin
                scriptCommand := true;
                if params.Count = 2 then
                    result := IntToStr(Min(StrToIntDef(params[0], 0), StrToIntDef(params[1], 0)));
            end;

            if AnsiUpperCase(method) = 'MAX' then
            begin
                scriptCommand := true;
                if params.Count = 2 then
                    result := IntToStr(Max(StrToIntDef(params[0], 0), StrToIntDef(params[1], 0)));
            end;




            if not scriptCommand and (passCount <= 0) then
            begin
                M := nil;
                fCash.TryGetValue(method, M);

                if not Assigned(M) and (method <> '') then
                for _M in t.GetMethods do
                if (_M.Parent = t) and (AnsiUpperCase(_M.Name) = AnsiUpperCase(method))then
                begin
                    M := _M;
                    fCash.Add(method, _M);
                    break;
                end;

                if Assigned(M) then
                begin
                    if   params.Count = 0
                    then V := M.Invoke(_obj,[]);

                    if   params.Count = 1
                    then V := M.Invoke(_obj,[params.CommaText]);

                    if   params.Count = 2
                    then V := M.Invoke(_obj,[params[0], params[1]]);

                    if   params.Count = 3
                    then V := M.Invoke(_obj,[params[0], params[1], params[2]]);

                    if   params.Count = 4
                    then V := M.Invoke(_obj,[params[0], params[1], params[2], params[3]]);

                    if not V.IsEmpty then result := V.AsString;
                end;
            end;

            line := StringReplace(line, match.Value, result, []);



            match := regFunction.Match(line)

        until match.Value = '';

        /// если идет отсчет пропускаемых команд - уменьшаем счетчик
        if passCount > 0
        then Dec(PassCount);

    end;
    prs.Free;

    result := trim(line);

    // чистим кэш переменных
    fVars.Clear;
end;

function TScriptDrive.GetMethodName(command: string): string;
begin
    result := Trim(Copy(command, 0, Pos('(', command)-1));
end;

function TScriptDrive.GetParams(command: string): TStringList;
var spos : integer;
    res,symbol: string;
    i, braces: integer;

begin
    result := TStringList.Create;

    /// вырезаем часть с параметрами
    spos := Pos('(', command);
    command := Copy(command, spos+1, Pos(')', command)-1 - spos);

    braces := 0;
    res := '';

    for I := 1 to Length(command) do
    begin
        symbol := command[i];

        if (symbol = '{') then Inc(braces);
        if (symbol = '}') then Dec(braces);

        if (symbol = ',') and (braces = 0)
        then symbol := sLineBreak;

        if (symbol = #0) then symbol := '';

        res := res + symbol;
    end;

    result.Text := res;

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
    operandAs, operandBs, varValue: string;
    i : integer;
    beg: integer;
    parse: TStringList;
    notation: TStringList;
    digit, oper: TStringList;
    found, mathCompare, stringCompare: boolean;

    HiPrior : string;
    LowPrior : string;
    ComparePrior : string;
    logicResult : string;

    match : TMatch;
begin
    result := command;

    HiPrior := '()*/';
    LowPrior := '+-';
    ComparePrior := '<>=<=';

    /// ищем наличие математики
    if Pos('[', command) = 0 then exit;



    /// вырезаем арифметику в отдельную строку для обработки
    beg := pos('[', command) + 1;
    mth := Trim( copy(command, beg, pos(']', command)-beg) );



    /// смотрим, не является ли это выражение именем переменной из кэша
    varValue := '';
    if fVars.TryGetValue(mth, varValue) then
    begin
        /// возвращаем значение из кэша
        result := varValue;
        exit;
    end;



    mth := '('+mth+')';

    // убираем избыточные пробелы для исключения пустых строк при разбиении через TStringList
    while Pos('  ', mth) > 0 do
        mth := StringReplace(mth, '  ', ' ', [rfReplaceAll]);

    // создаем парсер
    parse := TStringList.Create;

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




        repeat

          found := false;
          operation := '';
          logicResult := '';

        // разбиваем на отдельные операторы и операнды
          parse.CommaText := toCalc;

          // если это не первый цикл вычислений - образуются пустые строки, которые нужно вычистить
          for I := parse.Count-1 downto 0 do
          if parse[i] = '' then parse.Delete(i);

          // пробегаем по набору строк и ищем операторы сравнения
          for I := 0 to parse.Count-1 do
          if pos(parse[i], ComparePrior) > 0 then
          begin
              found := true;

              // с операндами ComparePrior возможно и текстовое сравнение
              // поэтому проверяем какие операнды переданы
              mathCompare :=
                  (StrToIntDef(parse[i-1], MaxInt) <> MaxInt) and
                  (StrToIntDef(parse[i+1], MaxInt) <> MaxInt);

              if not mathCompare then
              begin
                  operandAs := parse[i-1];
                  operation := parse[i];
                  operandBs := parse[i+1];
              end else
              begin
                  operandA := StrToInt(parse[i-1]);
                  operation := parse[i];
                  operandB := StrToInt(parse[i+1]);
              end;

              break;
          end;

          if operation <> '' then
          begin
              /// вычисляем, сохраняя результат на мете первого операнда
              if (operation = '<') and not mathCompare then
                  if operandAs < operandBs
                  then logicResult := 'true'
                  else logicResult := 'false';

              if (operation = '>') and not mathCompare then
                  if operandAs > operandBs
                  then logicResult := 'true'
                  else logicResult := 'false';

              if (operation = '=') and not mathCompare then
                  if operandAs = operandBs
                  then logicResult := 'true'
                  else logicResult := 'false';

              if (operation = '>=') and not mathCompare then
                  if operandAs >= operandBs
                  then logicResult := 'true'
                  else logicResult := 'false';

              if (operation = '<=') and not mathCompare then
                  if operandAs <= operandBs
                  then logicResult := 'true'
                  else logicResult := 'false';

              if (operation = '<>') and not mathCompare then
                  if operandAs <> operandBs
                  then logicResult := 'true'
                  else logicResult := 'false';



              if (operation = '<') and mathCompare then
                  if operandA < operandB
                  then logicResult := 'true'
                  else logicResult := 'false';

              if (operation = '>') and mathCompare then
                  if operandA > operandB
                  then logicResult := 'true'
                  else logicResult := 'false';

              if (operation = '=') and mathCompare then
                  if operandA = operandB
                  then logicResult := 'true'
                  else logicResult := 'false';

              if (operation = '>=') and mathCompare then
                  if operandA >= operandB
                  then logicResult := 'true'
                  else logicResult := 'false';

              if (operation = '<=') and mathCompare then
                  if operandA <= operandB
                  then logicResult := 'true'
                  else logicResult := 'false';

              if (operation = '<>') and mathCompare then
                  if operandA <> operandB
                  then logicResult := 'true'
                  else logicResult := 'false';


              // оператор и второй операнд - чистим
              parse[i-1] := logicResult;
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

    // functionA (1,2, functionB( 3 ,4 ),functionC(functionD(5, {6 + 54 + 3} ) ), functionE( {jgj+functionF(7)} ))+UseItem(RestoreHeal)
    regFunction:=TRegEx.Create('\w+\(\s*((\{((\d|\w)\s*[\+\-\*\/\>\<\=]*\s*)*\}|(\w|[а-яА-Я]|[\+\-\*\/\!\?\.\]\[\=\<\>\`])|(\{.*\}))\s*\,*\s*)*\)');
    regMath := TRegEx.Create('\((\s*(\d|\w)*\s*[\+\-\*\/\>\<\=]?)*\)');
    regNotExec := TRegEx.Create('\"[^\"]*\"');  // все в кавычках, кроме вложенных кавычек

    fCash := TDictionary<String,TRttiMethod>.Create();
    fVars := TDictionary<String,String>.Create();
end;

destructor TScriptDrive.Destroy;
begin
    fVars.Free;
    fCash.Free;
    parser.Free;
end;

end.
