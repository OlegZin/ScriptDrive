unit uAtlas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Memo,
  System.NetEncoding, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TfAtlas = class(TForm)
    NOTE_BG: TImage;
    Image15: TImage;
    Image30: TImage;
    Image29: TImage;
    Image28: TImage;
    Image27: TImage;
    Image26: TImage;
    Image25: TImage;
    Image24: TImage;
    Image23: TImage;
    Image22: TImage;
    Image21: TImage;
    Image20: TImage;
    Image19: TImage;
    Image18: TImage;
    Image17: TImage;
    Image16: TImage;
    Image14: TImage;
    Image13: TImage;
    Image12: TImage;
    Image11: TImage;
    Image10: TImage;
    Image9: TImage;
    Image8: TImage;
    Image7: TImage;
    Image6: TImage;
    Image5: TImage;
    Image4: TImage;
    Image3: TImage;
    Image2: TImage;
    Image1: TImage;
    Image32: TImage;
    Image31: TImage;
    Image33: TImage;
    Image34: TImage;
    Image35: TImage;
    Image36: TImage;
    Image37: TImage;
    Image38: TImage;
    Image39: TImage;
    Image40: TImage;
    Image41: TImage;
    Image42: TImage;
    Layout5: TLayout;
    Label24: TLabel;
    Image43: TImage;
    Layout9: TLayout;
    Image44: TImage;
    Label27: TLabel;
    Image45: TImage;
    Rectangle12: TRectangle;
    Rectangle7: TRectangle;
    Layout3: TLayout;
    Image46: TImage;
    Image47: TImage;
    Image48: TImage;
    Image49: TImage;
    Image50: TImage;
    Image51: TImage;
    Layout1: TLayout;
    Label5: TLabel;
    Label11: TLabel;
    Image52: TImage;
    Rectangle6: TRectangle;
    Label4: TLabel;
    Layout2: TLayout;
    Image53: TImage;
    Image54: TImage;
    Image55: TImage;
    Image56: TImage;
    Image57: TImage;
    Image58: TImage;
    ICON_GOLD: TImage;
    ICON_SWORD: TImage;
    ICON_SHIELD: TImage;
    Image59: TImage;
    ITEM_GOLD: TImage;
    Image61: TImage;
    Image62: TImage;
    ICON_BLUESHIELD: TImage;
    Image64: TImage;
    ICON_HEART: TImage;
    Image66: TImage;
    ICON_MANA: TImage;
    Image68: TImage;
    ICON_AUTO: TImage;
    IMAGE_LEVEL: TImage;
    ICON_LEVEL: TImage;
    Image63: TImage;
    ICON_EXP: TImage;
    Image65: TImage;
    Image67: TImage;
    Image69: TImage;
    ICON_FIGHT: TImage;
    ICON_CHEST: TImage;
    ICON_UNLOCK: TImage;
    Image71: TImage;
    ICON_MONSTER: TImage;
    Image73: TImage;
    ICON_KNIGHT: TImage;
    ITEM_POTIONAUTO: TImage;
    ICON_AUTOACTION: TImage;
    ITEM_BUFFREG: TImage;
    ICON_BUFFREG: TImage;
    ITEM_BUFFEXP: TImage;
    ICON_EXPBUFF: TImage;
    ITEM_BUFFMDEF: TImage;
    ICON_MDEFBUFF: TImage;
    ITEM_BUFFDEF: TImage;
    ICON_DEFBUFF: TImage;
    ITEM_BUFFATK: TImage;
    ICON_ATKBUFF: TImage;
    ITEM_REGENMP: TImage;
    ICON_MPREG: TImage;
    ITEM_REGENHP: TImage;
    ICON_HPREG: TImage;
    ITEM_POTIONEXP: TImage;
    ICON_EXPGET: TImage;
    ITEM_PERMANENTMDEF: TImage;
    ICON_MDEFGET: TImage;
    ITEM_PERMANENTDEF: TImage;
    ICON_DEFGET: TImage;
    ITEM_PERMANENTATK: TImage;
    ITEM_RESTOREHEALTH: TImage;
    ITEM_RESTOREMANA: TImage;
    ICON_ATKGET: TImage;
    ICON_HPGET: TImage;
    ICON_MPGET: TImage;
    IMAGE_TICKET: TImage;
    ICON_TICKET: TImage;
    IMAGE_BOX: TImage;
    ICON_BOX: TImage;
    IMAGE_WOOD: TImage;
    ICON_WOOD: TImage;
    IMAGE_STONE: TImage;
    ICON_STONE: TImage;
    IMAGE_HERBAL: TImage;
    IMAGE_WHEAT: TImage;
    IMAGE_MEAT: TImage;
    IMAGE_BLOOD: TImage;
    IMAGE_BONE: TImage;
    IMAGE_SKIN: TImage;
    IMAGE_ORE: TImage;
    IMAGE_ESSENCE: TImage;
    ICON_HERBAL: TImage;
    ICON_WHEAT: TImage;
    ICON_MEAT: TImage;
    ICON_BLOOD: TImage;
    ICON_BONE: TImage;
    ICON_SKIN: TImage;
    ICON_ORE: TImage;
    ICON_ESSENCE: TImage;
    ItemSlotShablon: TRectangle;
    Image60: TImage;
    Layout6: TLayout;
    Label1: TLabel;
    Rectangle13: TRectangle;
    Label25: TLabel;
    ICON_POWER: TImage;
    EFFECT_PlayerEXPBuff: TImage;
    EFFECT_RegenPlayerHP: TImage;
    EFFECT_RegenPlayerMP: TImage;
    EFFECT_PlayerDEFBuff: TImage;
    EFFECT_PlayerMDEFBuff: TImage;
    EFFECT_PlayerATKBuff: TImage;
    EFFECT_PlayerREGBuff: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
    function EncodeToBase64(name: string): string;
    function GetBitmap(index: integer): TBitmap;
    function GetBitmapByName(name: string): TBitmap;
  end;

var
  fAtlas: TfAtlas;

implementation

{$R *.fmx}

{ TfAtlas }

function TfAtlas.EncodeToBase64(name: string): string;
var
    memo : TMemo;
    LInput: TMemoryStream;
    LOutput: TMemoryStream;
    image: TImage;
    i: integer;
begin
    for I := 0 to self.ComponentCount-1 do
    if Components[i].Name = name then
      image := Components[i] as TImage;

    Memo := TMemo.Create(nil);

    LInput := TMemoryStream.Create;
    LOutput := TMemoryStream.Create;

    try
      image.MultiResBitmap[0].Bitmap.SaveToStream(LInput);
      LInput.Position := 0;
      TNetEncoding.Base64.Encode( LInput, LOutput );
      LOutput.Position := 0;
      Memo.Lines.LoadFromStream( LOutput );
    finally
      LInput.Free;
      LOutput.Free;
    end;

    result := Memo.Text;

    Memo.Free;
end;

function TfAtlas.GetBitmap(index: integer): TBitmap;
var
    i: integer;
begin
    for I := 0 to ComponentCount-1 do
    if Components[i].Tag = index then
    result := (Components[i] as TImage).Bitmap;
end;

function TfAtlas.GetBitmapByName(name: string): TBitmap;
var
    i: integer;
begin
    for I := 0 to ComponentCount-1 do
    if UpperCase(Components[i].Name) = UpperCase(name) then
    result := (Components[i] as TImage).Bitmap;
end;

end.
