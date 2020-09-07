unit uConst;

interface

uses SysUtils;

const
    FILE_MENU_DATA = '\menu.dat';

const
    /// состояние меню при первом запуске
    MENU_DATA_DEF =
    '{Gold:0, '+
     'NewLevel:1, '+
     'Skills: {'+
         'Research:     {Enabled:0, Level:0, NeedGold:10,  NeedResearch:1 },'+
         'MoneyEaring:  {Enabled:0, Level:1, NeedGold:20,  NeedResearch:5 },'+
         'BuildSpeed:   {Enabled:0, Level:1, NeedGold:100, NeedResearch:10},'+
         'BuildEconomy: {Enabled:0, Level:0, NeedGold:500, NeedResearch:15}'+
    '},'+
     'Objects: {'+
         'Logo:   {NeedResearch:3,  BuildCost:5,  Attempts:0, FullAttempts:10 },'+
         'Exit:   {NeedResearch:6,  BuildCost:10, Attempts:0, FullAttempts:20 },'+
         'Lang:   {NeedResearch:9,  BuildCost:20, Attempts:0, FullAttempts:50 },'+
         'Resume: {NeedResearch:13, BuildCost:30, Attempts:0, FullAttempts:100 },'+
         'New:    {NeedResearch:17, BuildCost:50, Attempts:0, FullAttempts:150 },'+
         'Tower1: {NeedResearch:20, BuildCost:100, Attempts:0, FullAttempts:100 },'+
         'Tower2: {NeedResearch:25, BuildCost:200, Attempts:0, FullAttempts:200 },'+
         'Tower3: {NeedResearch:30, BuildCost:300, Attempts:0, FullAttempts:300 },'+
         'Tower4: {NeedResearch:35, BuildCost:400, Attempts:0, FullAttempts:400 },'+
         'Tower5: {NeedResearch:40, BuildCost:500, Attempts:0, FullAttempts:500 }'+
    '}}';

var
    DIR_DATA :string;


implementation

initialization
    DIR_DATA := ExtractFilePath( paramstr(0) ) + 'DATA';

end.
