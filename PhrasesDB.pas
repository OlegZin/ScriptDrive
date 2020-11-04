unit PhrasesDB;

interface

uses superobject;

function GetPhrase(name, lang: string): string;

implementation

const
    PHRASES = '{'+
        'dog_is_dead:{'+
            'ENG:"Hell Dog is defeated! You are free!",'+
            'RU:"Адский Пес повержен! Ты свободен!",'+
        '},'+
    '}';

var
    data: ISuperObject;

function GetPhrase(name, lang: string): string;
begin
    if not Assigned(data) then data :=SO(PHRASES);

    result := '';

    if assigned(data.O[name+'.'+lang])
    then result := data.S[name+'.'+lang];
end;

end.
