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
    scriptCommand  // ������� ����, ��� � ������ ������ �������������� ����������� ������� ������
            : boolean;
    passCount      // ������� ��� ������ ������� ����� ����������
            : integer;
begin
    if not Assigned(T) then
    begin
        result := '����� �� �����.';
        exit;
    end;

    prs := TStringList.Create;


    /// � �������� ����� ���������� ����� � " ��������, ��� ������������� ��������� ��� �������
    /// ��� �� ���������� ��� ������ ����������� ������ � ������� �����, ����� �� �������� � ��������
    /// �����������, ������� ����� ��������� ������������� ������� ������� CalcMath
    repeat
        match := regNotExec.Match(scrt);
        if match.Value <> '' then
        begin
            /// ��������� ������������� ������ � ������
            varName := 'Var'+IntToStr(fVars.Count);
            fVars.Add( varName, copy(match.Value, 2, Length(match.Value)-2) );
            /// ��������� ������ ������ ���������� �� ����
            scrt := StringReplace(scrt, match.Value, '['+varName+']', []);
        end;
    until match.Value = '';


    /// ���������� ����� ������ ��������� �� ������ � ��������� �� �����������
    prs.Text := StringReplace(scrt, ';',#13#10,[rfReplaceAll, rfIgnoreCase]);
    for I := 0 to prs.Count-1 do
    begin

        line := prs[i];
        // � ������ ������� ������ ��������� ������� � ����������� ������ ��������
        // ������: functionA (1,2, functionB( 3 ,4 ),functionC(functionD(5, {6 + 54 + 3} ) ), functionE( {jgj+functionF(7)} ))+UseItem(RestoreHeal)
        // ��� �������� � {} -

        // ��������� ������� � ������ �������, �������
        // �� �������� ���������, �.�. ��� ������� ������� ���:
        // functionB( 3 ,4 )
        // functionD(5, {6 + 54 + 3} )
        // functionF(7)
        // UseItem(RestoreHeal)

        // �������� ������:
        // 1. � ����� ���������� ����� ����������
        // 2. ��� ������� ��������� ���������� �������� ������ ������� ��� ���������
        // 3. ������������ � ��������� ��������� ������ ��� � �������� ������
        // 4. ��� ���������� ��������� ������ - ������ �������
        // 5. ����� ������� ���������� ��������� ��� �� ��� ������ ������� ({}) � ��������� ��� �������������

        // ��������� ������ ������� ����� ���������, �������� ������ ������������ ���������
        if (passCount <= 0)  then
        repeat

            match := regFunction.Match(line);
            matches := regFunction.Matches(line);


            method := GetMethodName(match.Value);
            params := GetParams(match.Value);

            /// � ������ ������ � ��� ���� ��� ������ � ��� ��� ��������� � ���� ��������� �����
            /// ��������������, ��� ����� �� ���������� ��� �� �������� ��������, � �� �����������,
            /// �� ����� �������� ��� ��������� �������������� ��������� ( � {} ������� )
            /// �������� ������ ��������� ��� ����������� �������������� ���������� � ������� ������ �� ���������� ��������
            /// ��������: "��������� ����������� �������� {5+8}, ��� ������ ������."
            for j := 0 to params.Count-1 do params[j] := CalcMath(params[j]);


            /// ��������, �� �������� �� ������� ������� ���������.
            /// ��������, ����, ���������� �������� � �.�.
            /// ������ ������� ����������� ����� ���������� ������� � ����������� � ����������� ������
            scriptCommand := false;


            /// ������� �������� ������� ����:
            ///    IF(check, lines);
            ///    ���
            ///    check - ����� 'true'/'false', ������� ����� �������� � �������
            ///            ��������������� ��������� � �������������� ���������� '>' '<' '=',
            ///    lines - ���������� ������, ������� ����� ���������, ���� check = 'false'
            ///
            ///    ������ �������������:
            ///
            ///    If({GetPlayerItemCount(Gold) > 9999}, 4);
            ///    SetVar(iName, GetRandItemName());
            ///    ChangePlayerItemCount(GetVar(iName), 1);
            ///    ChangePlayerItemCount(Gold, -9999);
            ///    AddEvent(Player get GetVar(iName)!);
            ///
            ///    ����� ��� 4 ����������� ������� ����� ���������, ���� � ������
            ///    � ������� ������ 9999 ������, ����� 4 ������� ����� ���������
            ///    � ������� �� ����� ������� (�� ������� �����)

            if AnsiUpperCase(method) = 'IF' then
            begin
                scriptCommand := true;
                if params.Count = 2 then
                begin
                    if params[0] <> 'true'
                    then passCount := StrToIntDef(params[1], 0) + 1; // +1 = ��������� � ������� �������
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

        /// ���� ���� ������ ������������ ������ - ��������� �������
        if passCount > 0
        then Dec(PassCount);

    end;
    prs.Free;

    result := trim(line);

    // ������ ��� ����������
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

    /// �������� ����� � �����������
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
/// ���� � ��������� �������������� ��������� � ���������� �����
/// https://habr.com/ru/post/282379/ - �������� �������� �������
///    1. ����������� ������ � ������ ���������� � ��������� �� �������� �������
///    2. ��������� �� ����������� �������
///
/// ��� �������� ������ ����������� ���������, ��� ��������� ���������� � ������ TStringList.
/// ������������� ��������� ���������� ������� � ���������, �� ����������
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

    /// ���� ������� ����������
    if Pos('[', command) = 0 then exit;



    /// �������� ���������� � ��������� ������ ��� ���������
    beg := pos('[', command) + 1;
    mth := Trim( copy(command, beg, pos(']', command)-beg) );



    /// �������, �� �������� �� ��� ��������� ������ ���������� �� ����
    varValue := '';
    if fVars.TryGetValue(mth, varValue) then
    begin
        /// ���������� �������� �� ����
        result := varValue;
        exit;
    end;



    mth := '('+mth+')';

    // ������� ���������� ������� ��� ���������� ������ ����� ��� ��������� ����� TStringList
    while Pos('  ', mth) > 0 do
        mth := StringReplace(mth, '  ', ' ', [rfReplaceAll]);

    // ������� ������
    parse := TStringList.Create;

    /// � ������ ������ � ��� ���� ������ ��� ������ ��������, ��� �������, � �������, ��������������� ���������� � ��������.
    /// � ������ ������� ��������� ���������� �� ������, �.�. ��������� � ��������� ������ ����� ����������� � ������������ �������,
    /// � ������� ����������� ��������� ������ (������).
    /// ����� �������, ������ �������� � ���������� ����� ��� ������, � ������ � ������ ���� ����������
    /// ���������: \((\s*\d*\s*[\+\-\*\/]?)*\)
    /// ������: (10 + (3 * 6) + (3 * 5 + 3))
    /// �������: (3 * 6) � (3 * 5 + 3)

    // ���� ��������� � ������� � ��� ��������� ������
    repeat
        match := regMath.Match(mth);

        // �������� ��������� ��� ������
        toCalc := copy(match.Value, 2, Length(match.Value)-2);

        repeat

          found := false;
          operation := '';

          // ��������� �� ��������� ��������� � ��������
          parse.CommaText := toCalc;

          // ���� ��� �� ������ ���� ���������� - ���������� ������ ������, ������� ����� ���������
          for I := parse.Count-1 downto 0 do
          if parse[i] = '' then parse.Delete(i);

          // ��������� �� ������ ����� � ���� ������� ��������� � ������ ����������� ( ���������, �������)
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
              /// ���������, �������� ��������� �� ���� ������� ��������
              if operation = '*' then
              operandA := operandA * operandB;

              if operation = '/' then
              operandA := Round(operandA / operandB);

              // �������� � ������ ������� - ������
              parse[i-1] := IntToStr(operandA);
              parse[i] := '';
              parse[i+1] := '';
          end;

          /// �������� ������������ ������� � ������ ��� ��������� ��������
          /// ��� ����, �� ��������� ����� ������ ����� �������� � ������� ��������� �����
          ///  �������������� ��������, ��� �������� ������
          toCalc := parse.CommaText;

        until not found;




        repeat

          found := false;
          operation := '';

        // ��������� �� ��������� ��������� � ��������
          parse.CommaText := toCalc;

          // ���� ��� �� ������ ���� ���������� - ���������� ������ ������, ������� ����� ���������
          for I := parse.Count-1 downto 0 do
          if parse[i] = '' then parse.Delete(i);

          // ��������� �� ������ ����� � ���� ������� ��������� � ������ ����������� ( ���������, �������)
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
              /// ���������, �������� ��������� �� ���� ������� ��������
              if operation = '+' then
              operandA := operandA + operandB;

              if operation = '-' then
              operandA := operandA - operandB;

              // �������� � ������ ������� - ������
              parse[i-1] := IntToStr(operandA);
              parse[i] := '';
              parse[i+1] := '';
          end;

          /// �������� ������������ ������� � ������ ��� ��������� ��������
          /// ��� ����, �� ��������� ����� ������ ����� �������� � ������� ��������� �����
          ///  �������������� ��������, ��� �������� ������
          toCalc := parse.CommaText;

        until not found;




        repeat

          found := false;
          operation := '';
          logicResult := '';

        // ��������� �� ��������� ��������� � ��������
          parse.CommaText := toCalc;

          // ���� ��� �� ������ ���� ���������� - ���������� ������ ������, ������� ����� ���������
          for I := parse.Count-1 downto 0 do
          if parse[i] = '' then parse.Delete(i);

          // ��������� �� ������ ����� � ���� ��������� ���������
          for I := 0 to parse.Count-1 do
          if pos(parse[i], ComparePrior) > 0 then
          begin
              found := true;

              // � ���������� ComparePrior �������� � ��������� ���������
              // ������� ��������� ����� �������� ��������
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
              /// ���������, �������� ��������� �� ���� ������� ��������
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


              // �������� � ������ ������� - ������
              parse[i-1] := logicResult;
              parse[i] := '';
              parse[i+1] := '';
          end;

          /// �������� ������������ ������� � ������ ��� ��������� ��������
          /// ��� ����, �� ��������� ����� ������ ����� �������� � ������� ��������� �����
          ///  �������������� ��������, ��� �������� ������
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
    regFunction:=TRegEx.Create('\w+\(\s*((\{((\d|\w)\s*[\+\-\*\/\>\<\=]*\s*)*\}|(\w|[�-��-�]|[\+\-\*\/\!\?\.\]\[\=\<\>\`])|(\{.*\}))\s*\,*\s*)*\)');
    regMath := TRegEx.Create('\((\s*(\d|\w)*\s*[\+\-\*\/\>\<\=]?)*\)');
    regNotExec := TRegEx.Create('\"[^\"]*\"');  // ��� � ��������, ����� ��������� �������

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
