unit uThink;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Ani, FMX.Controls.Presentation, FMX.StdCtrls,
  superobject, FMX.WebBrowser, Generics.Collections, uScriptDrive;

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

    Scr : TScriptDrive;

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
    /// вызываем метод прокачки раздумь€
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

    /// активность и анимаци€ кнопки автодействий
    if _data.B['auto'] then
    begin
        iAuto.Opacity := 1;
        Timer.Enabled := true;
    end else
    begin
        iAuto.Opacity := 0.3;
        Timer.Enabled := false;
    end;

    /// обнул€ем список прив€зок объектов каточек и данных
    if Not Assigned( LinkData )
    then LinkData := TDictionary<TComponent,ISuperObject>.Create;
    LinkData.Clear;

    /// чистим объекты карточек мыслей
    for I := laySticks.ControlsCount-1 downto 0 do
    laySticks.Controls[i].Free;

    /// чистим объекты активных карточек мыслей
    for I := layTopStick.ControlsCount-1 downto 0 do
    layTopStick.Controls[i].Free;

    ///перебираем все активные мысли и создаем карточки дл€ них
    for item in _data.O['thinks'] do
    begin
        /// копируем болванку карточки
        obj := fAtlas.ThinkShablon.Clone( laySticks ) as TControl;

        /// определ€ем слой дл€ отображени€
        if _data.S['CurrThink'] <> item.S['name']
        then obj.Parent := laySticks
        else obj.Parent := layTopStick;

        obj.OnClick := onStickClick;

        /// прив€зываем данные к объекту карточки
        LinkData.Add(obj, item);

        /// если данные по этому объекту приход€т впервые, заполн€ем локальные данные положени€
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

        /// дл€ начала получаем полную ширину прогрессбара
        for I := 0 to obj.ComponentCount-1 do
        if obj.Components[i].Tag = THINK_PROGRESS_BG
        then bg_width := (obj.Components[i] as TRectangle).Width;

        /// теперь перебираем все составл€ющие шаблона и по id меткам в tag заполн€ем соответствующими данными
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

    /// пр€чем все закладки журнала
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
/// фишка в том, что при добавлении в <a hreg="link"></a> простой строки, к ней автоматически
/// приклеиваетс€ префикс 'about:', что будет выгл€деть в переменной WebBrowser.Url как
/// 'about:link'. наличие этого префикса и инициализирует переход по ссылке(обновление окна).
///
/// Ќќ! если сделать текст ссылки со своим префиксом, к примеру <a hreg="my:link"></a>,
/// то мрефикс 'about:' не подставл€етс€. WebBrowser.Urlбудет после клика по ссылке содержать
/// 'my:link', но обновлени€ содержимого не произойдет, посколку префикс не управл€ющий!
///
///  Ёто крайне полезна€ фишка, поскольку позволит дополнительно разделить ссылки по типам и
///  обрабатывать их разными методами!
begin
    if not Assigned(Scr) then
    begin
      Scr := TScriptDrive.Create;
      Scr.SetClass(TGameDrive, GameDrive);
    end;

    if Pos('script:', WebBrowser.Url) > 0 then
      Scr.Exec( Copy(WebBrowser.Url, Length('script:')+1, Length(WebBrowser.Url)) );
end;



end.
