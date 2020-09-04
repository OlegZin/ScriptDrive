unit uMenu;

interface

uses
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
    FMX.Controls.Presentation, FMX.Edit, FMX.ComboEdit, FMX.ComboTrackBar,
    FMX.StdCtrls, FMX.WebBrowser, FMX.TabControl, FMX.Objects, FMX.Layouts;

type
    TMenu = class
        bNew, lNew,
        bResume, lResume,
        bLang, lLang,
        bExit, lExit,
        layLogo, iChest
            : TControl;

        procedure Init;

    private
        procedure ButtonMouseEnter(Sender: TObject);
        procedure ButtonMouseLeave(Sender: TObject);
        procedure ChestClick(Sender: TObject);

//        function GetMenuState: string;
//        procedure AddCoin;
    end;

var
    Menu : TMenu;

implementation

uses
    superobject, uMain;

const
    def = '';

var
    data: ISuperObject;

function GetMenuState: string;
begin

end;

procedure AddCoin;
begin

end;




procedure m_tmrMenuTimer(Sender: TObject);
begin
//    fMain.tmrMenu.Enabled := false;
    fMain.iChestActive.Visible := false;
    fMain.iChestDef.Visible := true;
end;



procedure TMenu.ChestClick(Sender: TObject);
begin
    (Sender as TImage).Visible := false;
    fMain.iChestActive.Visible := true;
//    fMain.tmrMenu.Enabled := true;
end;

procedure TMenu.Init;
begin
    bNew.OnMouseEnter    := ButtonMouseEnter;
    bResume.OnMouseEnter := ButtonMouseEnter;
    bLang.OnMouseEnter   := ButtonMouseEnter;
    bExit.OnMouseEnter   := ButtonMouseEnter;

    bNew.OnMouseLeave    := ButtonMouseLeave;
    bResume.OnMouseLeave := ButtonMouseLeave;
    bLang.OnMouseLeave   := ButtonMouseLeave;
    bExit.OnMouseLeave   := ButtonMouseLeave;

    iChest.OnClick       := Menu.ChestClick;
end;

procedure TMenu.ButtonMouseEnter(Sender: TObject);
begin
    (sender as TRoundRect).Fill.Color := $FF2D4A69;
    ((sender as TRoundRect).Children.Items[0] as TLabel).TextSettings.FontColor := TAlphaColorRec.Lightsteelblue;
end;

procedure TMenu.ButtonMouseLeave(Sender: TObject);
begin
    (sender as TRoundRect).Fill.Color := TAlphaColorRec.Lightsteelblue;
    ((sender as TRoundRect).Children.Items[0] as TLabel).TextSettings.FontColor := $FF2D4A69;
end;

initialization

    Menu := TMenu.Create;

finalization

    Menu.Free;
end.
