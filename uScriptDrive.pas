unit uScriptDrive;

interface

uses RTTI;

type

    TScriptDrive = class
    private
        function GetMethodName(command: string): string;
        function GetParams(command: string): string;
    public
        constructor Create;
        procedure SetClass( cls: TClass );
        function Exec(scrt:string): string;
    end;

var
    Script: TScriptDrive;

implementation

uses
   Classes, SysUtils, uData;

var
   parser: TStringList;
   R : TRttiContext;
   T : TRttiType;
   M : TRttiMethod;
   V : TValue;

function TScriptDrive.Exec(scrt:string): string;
var
    method: string;
    params: string;
    i : integer;
    prs: TStringList;
begin
    if not Assigned(T) then
    begin
        result := ' ласс не задан.';
        exit;
    end;

    prs := TStringList.Create;

    /// полученный набор команд разбиваем на строки и выполн€ем по отдельности
    prs.Text := StringReplace(scrt, ';',#13#10,[rfReplaceAll, rfIgnoreCase]);
    for I := 0 to prs.Count-1 do
    begin

        // в строке команды ищутс€ вложенные функции и исполн€ютс€ раньше основной
        // пример: functionA (a,b, functionB(b,c),functionC(functionD(a,{d})))
        // где значение с {} - место дл€ подстановки результата выполнени€ вложенной функции

        // \w+\s*\(((\{\w+\}|\w+)\s*\,*)*\) - регул€рка находит в строке функцию, котора€
        // \w+\s*\((\w+\s*\,*)*\)
        // не содержит вложенных, т.е. дл€ данного примера это:
        // functionB(b,c) и functionD(a,{d})

        // алгоритм работы:
        // 1. в цикле производим поиск регул€ркой
        // 2. при наличии непустого результата получаем чистую функцию дл€ обработки
        // 3. обрабатываем и вставл€ем результат вместо нее в основную строку
        // 4. при отсутствии резултата поиска - расчет окончен

        method := GetMethodName(prs[i]);
        params := GetParams(prs[i]);

        for M in t.GetMethods do
            if (m.Parent = t) and (AnsiUpperCase(m.Name) = AnsiUpperCase(method))then
            begin
                V := M.Invoke(Data,[params]);

                if not V.IsEmpty then result := V.AsString;

            end;
    end;
    prs.Free;
end;

function TScriptDrive.GetMethodName(command: string): string;
begin
    result := Trim(Copy(command, 0, Pos('(', command)-1));
end;

function TScriptDrive.GetParams(command: string): string;
var spos : integer;
begin
    spos := Pos('(', command);
    result := Copy(command, spos+1, Pos(')', command)-1 - spos);
end;

procedure TScriptDrive.SetClass(cls: TClass);
begin
    T := R.GetType(cls);
end;

constructor TScriptDrive.Create;
begin
    parser := TStringList.Create;
    parser.StrictDelimiter := true;
end;

end.
