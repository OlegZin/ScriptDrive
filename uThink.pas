unit uThink;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Ani, FMX.Controls.Presentation, FMX.StdCtrls,
  superobject, FMX.WebBrowser, Generics.Collections;

type
  TfThink = class(TForm)
    layThink: TLayout;
    rBook: TRectangle;
    iBook: TImage;
    Rectangle12: TRectangle;
    iAuto: TImage;
    Image65: TImage;
    lPool: TLabel;
    laySticks: TLayout;
    Timer: TTimer;
    WebBrowser: TWebBrowser;
    layTopStick: TLayout;
    Layout1: TLayout;
    bookmarkTower: TImage;
    bookmarkJurnal: TImage;
    bookmarkPersone: TImage;
    procedure Rectangle12Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure bookmarkTowerClick(Sender: TObject);
    procedure bookmarkPersoneClick(Sender: TObject);
    procedure bookmarkJurnalClick(Sender: TObject);
    procedure WebBrowserDidStartLoad(ASender: TObject);
  private
    { Private declarations }
    data: ISuperobject;

    lastHTML : string;
    LinkData: TDictionary<TComponent,ISuperObject>;
    breakLoad : boolean;

//    Selected: TControl;

    procedure onStickClick(Sender: TObject);
  public
    { Public declarations }
    procedure Update(_data: ISuperObject);
  end;

var
  fThink: TfThink;

implementation

{$R *.fmx}

uses uAtlas, uGameDrive, uDocCreater;

const
    EMPTY_HTML =
        '<html>'+
          '<head>'+
            '<meta http-equiv=Content-Type content="text/html; charset=windows-1251">'+
            '<style>'+
              'body{margin:0;padding:10px;border:0;}'+
              'body{ scrollbar-base-color: #fff; scrollbar-track-color: #fff; scrollbar-width: thin;}'+
              'body{background:url("data:image/jpeg;base64,#BOOK_BG#");}'+
              'a:visited, a, h2{'+
                  'font-weight:bold;'+
                  'color: #2d4a69;'+
                  'text-decoration:none;'+
              '}'+
            '</style>'+
          '</head>'+
        '<body>'+
          '#CONTENT#'+
        '</body>'+
        '</html>';

var
   Doc: TDocCreater;

   BOOK_BG
    : string;

{ TfThink }

procedure TfThink.bookmarkJurnalClick(Sender: TObject);
begin
    GameDrive.SelectKind('Jurnal');
end;

procedure TfThink.bookmarkPersoneClick(Sender: TObject);
begin
    GameDrive.SelectKind('Persone');
end;

procedure TfThink.bookmarkTowerClick(Sender: TObject);
begin
    GameDrive.SelectKind('Tower');
end;

procedure TfThink.onStickClick(Sender: TObject);
var
    i: integer;
begin
    /// вызываем метод прокачки раздумья
    GameDrive.PlayerThink( LinkData[sender as TControl].S['name'] );
end;

procedure TfThink.Rectangle12Click(Sender: TObject);
begin
    if data.B['auto']
    then GameDrive.BreakAuto('Think')
    else GameDrive.RunAuto('Think');
end;

procedure TfThink.TimerTimer(Sender: TObject);
begin
    iAuto.RotationAngle := iAuto.RotationAngle + 1;
end;

procedure TfThink.Update(_data: ISuperObject);
var
    item:ISuperObject;
    i : integer;
    obj : TControl;
    bg_width : real;
    elem: TSuperAvlEntry;
begin

    breakLoad := false;

    /// количество локальныхочков автодействий
    lPool.Text := _data.S['pool'];

    /// активность и анимация кнопки автодействий
    if _data.B['auto'] then
    begin
        iAuto.Opacity := 1;
        Timer.Enabled := true;
    end else
    begin
        iAuto.Opacity := 0.3;
        Timer.Enabled := false;
    end;

    /// обнуляем список привязок объектов каточек и данных
    if Not Assigned( LinkData )
    then LinkData := TDictionary<TComponent,ISuperObject>.Create;
    LinkData.Clear;

    /// чистим объекты карточек мыслей
    for I := laySticks.ControlsCount-1 downto 0 do
    laySticks.Controls[i].Free;

    /// чистим объекты активных карточек мыслей
    for I := layTopStick.ControlsCount-1 downto 0 do
    layTopStick.Controls[i].Free;

    ///перебираем все активные мысли и создаем карточки для них
    for item in _data.O['thinks'] do
    begin
        /// копируем болванку карточки
        obj := fAtlas.ThinkShablon.Clone( laySticks ) as TControl;

        /// определяем слой для отображения
        if _data.S['CurrThink'] <> item.S['name']
        then obj.Parent := laySticks
        else obj.Parent := layTopStick;

        obj.OnClick := onStickClick;

        /// привязываем данные к объекту карточки
        LinkData.Add(obj, item);

        /// если данные по этому объекту приходят впервые, заполняем локальные данные положения
        if not assigned(data) or not assigned(data.O['thinks.'+item.S['name']]) then
        begin
          item.I['x'] := Random( Round(laySticks.Width - obj.Width) );
          item.I['y'] := Random( Round(laySticks.Height - obj.Height) );
          item.I['rotation'] := Random( 30 ) - 15;
        end else
        /// иначе берем из предыдущий итерации
        begin
          item.I['x'] := data.I['thinks.'+item.S['name']+'.x'];
          item.I['y'] := data.I['thinks.'+item.S['name']+'.y'];
          item.I['rotation'] := data.I['thinks.'+item.S['name']+'.rotation'];
        end;

        /// позиционируем карточку
        obj.Position.X := item.I['x'];
        obj.Position.Y := item.I['y'];
        (obj as TRectangle).RotationAngle := item.I['rotation'];

        /// для начала получаем полную ширину прогрессбара
        for I := 0 to obj.ComponentCount-1 do
        if obj.Components[i].Tag = THINK_PROGRESS_BG
        then bg_width := (obj.Components[i] as TRectangle).Width;

        /// теперь перебираем все составляющие шаблона и по id меткам в tag заполняем соответствующими данными
        for I := 0 to obj.ComponentCount-1 do
        begin
            if obj.Components[i].Tag = THINK_CAPTION
            then (obj.Components[i] as TLabel).Text := item.S['caption'];

            if obj.Components[i].Tag = THINK_VALUE
            then (obj.Components[i] as TLabel).Text := item.S['compact_value'];

            if obj.Components[i].Tag = THINK_PROGRESS
            then (obj.Components[i] as TRectangle).Width := bg_width * ( item.I['value'] / item.I['max'] );

            if obj.Components[i].Tag = THINK_HILIGHTER then
            (obj.Components[i] as TControl).Visible := _data.S['CurrThink'] = item.S['name'];

            if obj.Components[i].Tag = THINK_KIND_BG then
            (obj.Components[i] as TImage).MultiResBitmap[0].Bitmap.Assign(  fAtlas.GetBitmapByName('kind_' + item.S['kind']) );

        end;
    end;

    /// прячем все закладки журнала
    for I := iBook.ControlsCount-1 downto 0 do
    if not (iBook.Controls[i] is TWebBrowser) then
    iBook.Controls[i].Visible := false;

    /// показываем закладки
    for elem in _data.O['kinds'].AsObject do
    begin
        if LowerCase(elem.Name) = 'tower' then bookmarkTower.Visible:=true;
        if LowerCase(elem.Name) = 'persone' then bookmarkPersone.Visible:=true;
        if LowerCase(elem.Name) = 'jurnal' then bookmarkJurnal.Visible:=true;
    end;


    if Not Assigned( Doc )
    then Doc := TDocCreater.Create;

    if BOOK_BG = '' then BOOK_BG := fAtlas.EncodeToBase64('BOOK_BG');

    /// если текущее содержимое дневника изменилось, перестраиваем страницу
    if not assigned(data) or (_data.S['body'] <> data.S['body']) then
    begin

        Doc.Template.html := EMPTY_HTML;

        Doc.SetValue('BOOK_BG', BOOK_BG);
        Doc.SetValue('CONTENT', _data.S['body']);

        lastHTML := Doc.Template.html;

        WebBrowser.LoadFromStrings(lastHTML, '');

    end;


    data := _data;
end;


procedure TfThink.WebBrowserDidStartLoad(ASender: TObject);
begin
//    if breakLoad then exit;

    if Pos('link:', WebBrowser.Url) > 0 then
//    begin
//      WebBrowser.LoadFromStrings(lastHTML, '');
      GameDrive.OpenThink( Copy(WebBrowser.Url, Length('link:')+1, Length(WebBrowser.Url)) );
//      breakLoad := true;
//    end;
end;

end.
