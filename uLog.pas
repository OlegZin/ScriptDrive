unit uLog;

interface

uses
    FMX.WebBrowser;

type
    TLog = class
        wbLog : TWebBrowser;
    end;

var
    Log : TLog;

implementation

initialization
    Log := TLog.Create;

finalization
    Log.Free;

end.
