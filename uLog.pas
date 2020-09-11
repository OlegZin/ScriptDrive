unit uLog;

interface

uses
    FMX.WebBrowser, Generics.Collections;

type
    TLog = class
        wbLog : TWebBrowser;
        lines : TList<string>;
        linesCount: integer;
            /// максимальное количество сообщений в чате, при привышении которого
            /// самые старые из которых будут удалены
        procedure Clear;
        procedure Add(text: string);  // добавить новую строку
        procedure Append(text: string);   // приклеить текст к самой свежей строке
        procedure Replace(text: string);  // заменить текст к самой свежей строке
        procedure Get(text: string);  // получить текст самой свежей строки
        procedure Update;                 // обновление содержимого wbLog
    end;

var
    Log : TLog;

implementation

{ TLog }

procedure TLog.Add(text: string);
begin

end;

procedure TLog.Append(text: string);
begin

end;

procedure TLog.Clear;
begin
    wbLog.LoadFromStrings('', '');
end;

procedure TLog.Get(text: string);
begin

end;

procedure TLog.Replace(text: string);
begin

end;

procedure TLog.Update;
begin

end;

initialization
    Log := TLog.Create;
    Log.lines := TList<string>.Create;

finalization
    Log.lines.Free;
    Log.Free;

end.
