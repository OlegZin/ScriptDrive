unit uScriptDrive;

interface

uses RTTI,  Classes, SysUtils;

type

    TScriptDrive = class
    private
        function GetMethodName(command: string): string;
        function GetParams(command: string): TStringList;
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

function TScriptDrive.Exec(scrt:string): string;
var
    method: string;
    params: TStringList;
    i : integer;
    prs: TStringList;
begin
    if not Assigned(T) then
    begin
        result := '����� �� �����.';
        exit;
    end;

    prs := TStringList.Create;

    /// ���������� ����� ������ ��������� �� ������ � ��������� �� �����������
    prs.Text := StringReplace(scrt, ';',#13#10,[rfReplaceAll, rfIgnoreCase]);
    for I := 0 to prs.Count-1 do
    begin

        // � ������ ������� ������ ��������� ������� � ����������� ������ ��������
        // ������: functionA (a,b, functionB(b,c),functionC(functionD(a,{d})))
        // ��� �������� � {} - ����� ��� ����������� ���������� ���������� ��������� �������

        // \w+\s*\(((\{\w+\}|\w+)\s*\,*)*\) - ��������� ������� � ������ �������, �������
        // \w+\s*\((\w+\s*\,*)*\)
        // �� �������� ���������, �.�. ��� ������� ������� ���:
        // functionB(b,c) � functionD(a,{d})

        // �������� ������:
        // 1. � ����� ���������� ����� ����������
        // 2. ��� ������� ��������� ���������� �������� ������ ������� ��� ���������
        // 3. ������������ � ��������� ��������� ������ ��� � �������� ������
        // 4. ��� ���������� ��������� ������ - ������ �������

        method := GetMethodName(prs[i]);
        params := GetParams(prs[i]);

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
    end;
    prs.Free;
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

constructor TScriptDrive.Create;
begin
    parser := TStringList.Create;
    parser.StrictDelimiter := true;
end;

end.
