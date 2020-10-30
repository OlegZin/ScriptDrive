unit uLog;

interface

uses
    FMX.WebBrowser, Generics.Collections, SysUtils, StrUtils,
    uDocCreater, uConst, superobject;

const
    LOG_LINE = '<div class=%s>%s</div>';

    MESS_NORMAL = 'normal';
    MESS_DANGER = 'danger';
    MESS_NOTE   = 'note';
    MESS_FIGHT  = 'fight';

    EMPTY_HTML =
        '<html>'+
          '<head>'+
            '<meta http-equiv=Content-Type content="text/html; charset=windows-1251">'+
            '<style>'+
              'body{margin:0;padding:10px;border:0;}'+
              'body{ scrollbar-base-color: #fff; scrollbar-track-color: #fff; }'+
              '.think{font-style: italic;}'+
              '.danger{color:red; font-weight: bold;}'+
              '.fight{color:gray;}'+
              '.note{'+
                'padding:20px;margin:20px;'+
                'font-weight:bold;'+
                'line-height:150%;'+
                'background-image:url("data:image/jpeg;base64,#IMAGE_NOTE_BG#")'+
              '}'+

              '.fight{padding:5px;}'+

              '.change_param,.change_item, .change_loot{'+
                'padding:5px; '+
                'padding-left:20px; '+
                'font-weight:bold;'+
                'line-height:150%;'+
              '}'+
              '.change_param{ background-color: #fff8dc; }'+
              '.change_item{ background-color: #f0f8ff; }'+
              '.change_loot{ background-color: #f5f5dc; }'+
              '.allow{'+
                  'margin:10px;'+
                  'padding:20px;'+
                  'background-color: #88d7aa;}'+

              '.lvl_up{'+
                'padding-left: 70px;'+
                'display: block;'+
                'height: 50px;'+
                'background:url("data:image/jpeg;base64,#IMAGE_LEVEL#") no-repeat;'+
                'text-weight: bold;'+
                'color: red;'+
                'font-size: 150%;'+
                'background-color: #fff8dc;'+
              '}'+
              '.lvl_up .text{'+
                'position: relative;'+
                'top: 50%;'+
                'transform: translateY(-50%);'+
              '}'+

              '.icon{'+
                'display: inline;'+
                'height: 20px;'+
                'width: 20px;}'+
              '.large_icon{'+
                'display: inline;'+
                'height: 50px;'+
                'width: 50px;}'+

              '.gold, .icon_gold{background:url("data:image/jpeg;base64,#ICON_GOLD#");}'+
              '.ATK,.icon_sword{background:url("data:image/jpeg;base64,#ICON_SWORD#");}'+
              '.DEF,.icon_shield{background:url("data:image/jpeg;base64,#ICON_SHIELD#");}'+
              '.MDEF,.icon_blueshield{background:url("data:image/jpeg;base64,#ICON_BLUESHIELD#");}'+
              '.HP,.icon_heart{background:url("data:image/jpeg;base64,#ICON_HEART#");}'+
              '.MP,.icon_mana{background:url("data:image/jpeg;base64,#ICON_MANA#");}'+
              '.AutoAction,.icon_auto{background:url("data:image/jpeg;base64,#ICON_AUTO#");}'+
              '.LVL,.icon_level{background:url("data:image/jpeg;base64,#ICON_LEVEL#");}'+
              '.EXP,.icon_exp{background:url("data:image/jpeg;base64,#ICON_EXP#");}'+
              '.icon_fight{background:url("data:image/jpeg;base64,#ICON_FIGHT#");}'+
              '.icon_unlock{background:url("data:image/jpeg;base64,#ICON_UNLOCK#");}'+
              '.icon_monster{background:url("data:image/jpeg;base64,#ICON_MONSTER#");}'+
              '.icon_knight{background:url("data:image/jpeg;base64,#ICON_KNIGHT#");}'+
              '.icon_book{background:url("data:image/jpeg;base64,#ICON_BOOK#");}'+
              '.icon_think{background:url("data:image/jpeg;base64,#ICON_THINK#");}'+

              '.image_book{background:url("data:image/jpeg;base64,#IMAGE_BOOK#");}'+
              '.image_unlock{background:url("data:image/jpeg;base64,#IMAGE_UNLOCK#");}'+

              '.wood{background:url("data:image/jpeg;base64,#ICON_WOOD#");}'+
              '.stone{background:url("data:image/jpeg;base64,#ICON_STONE#");}'+
              '.herbal{background:url("data:image/jpeg;base64,#ICON_HERBAL#");}'+
              '.wheat{background:url("data:image/jpeg;base64,#ICON_WHEAT#");}'+
              '.meat{background:url("data:image/jpeg;base64,#ICON_MEAT#");}'+
              '.blood{background:url("data:image/jpeg;base64,#ICON_BLOOD#");}'+
              '.bone{background:url("data:image/jpeg;base64,#ICON_BONE#");}'+
              '.skin{background:url("data:image/jpeg;base64,#ICON_SKIN#");}'+
              '.ore{background:url("data:image/jpeg;base64,#ICON_ORE#");}'+
              '.essence{background:url("data:image/jpeg;base64,#ICON_ESSENCE#");}'+

              '.potionAuto{background:url("data:image/jpeg;base64,#ICON_AUTOACTION#");}'+
              '.buffREG{background:url("data:image/jpeg;base64,#ICON_BUFFREG#");}'+
              '.buffEXP{background:url("data:image/jpeg;base64,#ICON_EXPBUFF#");}'+
              '.buffMDEF{background:url("data:image/jpeg;base64,#ICON_MDEFBUFF#");}'+
              '.buffDEF{background:url("data:image/jpeg;base64,#ICON_DEFBUFF#");}'+
              '.buffATK{background:url("data:image/jpeg;base64,#ICON_ATKBUFF#");}'+
              '.regenMP{background:url("data:image/jpeg;base64,#ICON_MPREG#");}'+
              '.regenHP{background:url("data:image/jpeg;base64,#ICON_HPREG#");}'+
              '.potionexp{background:url("data:image/jpeg;base64,#ICON_EXPGET#");}'+
              '.PermanentMDEF{background:url("data:image/jpeg;base64,#ICON_MDEFGET#");}'+
              '.permanentDEF{background:url("data:image/jpeg;base64,#ICON_DEFGET#");}'+
              '.permanentATK{background:url("data:image/jpeg;base64,#ICON_ATKGET#");}'+
              '.restoreHealth{background:url("data:image/jpeg;base64,#ICON_HPGET#");}'+
              '.restoreMana{background:url("data:image/jpeg;base64,#ICON_MPGET#");}'+
              '.buffSPEED{background:url("data:image/jpeg;base64,#ICON_TICKET#");}'+

              '.icon_chest{background:url("data:image/jpeg;base64,#ICON_CHEST#");}'+
            '</style>'+
          '</head>'+
        '<body onload="window.scrollTo(0,10000)">'+
          '#CONTENT#'+
        '</body>'+
        '</html>';

    ///
    ICON_TEMPLATE = '<div class="%s"></div>';

    /// набор стандартных фраз
    PHRASES_LIST =
    '{'+
        'level_up:{'+
            'kind:"lvl_up",'+
            'RU:"<div class=text>НОВЫЙ УРОВЕНЬ!</div>",'+
           'ENG:"<div class=text>LEVEL UP!</div>"},'+
        'killed_by:{'+
            'kind:"danger",'+
            'RU:"Игрок побежден...", '+
            'ENG:"Player defeated..."},'+
        'monster_killed:{'+
            'kind:"normal",'+
            'RU:"Монстр побежден!", '+
           'ENG:"Monster defeated!"},'+
        'next_floor:{'+
            'kind:"normal",'+
            'RU:"Поднимаемся на %s этаж...", '+
           'ENG:"Go up %s floor..."},'+
        'skill_overcost:{'+
            'kind:"danger",'+
            'RU:"Использование %s стоит %d ICON_MANA!", '+
           'ENG:"Using of %s is cost %d ICON_MANA!"},'+
        'skill_up:{'+
            'kind:"normal",'+
            'RU:"Умение %s улучшено до %d уровня!", '+
           'ENG:"Skill %s is up to %d level!"},'+
        'skill_overup:{'+
            'kind:"danger",'+
            'RU:"Улучшение умения %s стоит %d ICON_EXP", '+
           'ENG:"Level up skill %s is cost %d ICON_EXP!"},'+
        'player_strike:{'+
            'kind:"fight",'+
            'RU:"ICON_MONSTER&emsp;-%d", '+
           'ENG:"ICON_MONSTER&emsp;-%d"},'+
        'monster_strike:{'+
            'kind:"fight",'+
            'RU:"-%d&emsp;ICON_KNIGHT", '+
           'ENG:"-%d&emsp;ICON_KNIGHT"},'+
        'player_strike_block:{'+
            'kind:"fight",'+
            'RU:"ICON_MONSTER&emsp;-%d ( %dICON_SHIELD )", '+
           'ENG:"ICON_MONSTER&emsp;-%d ( %dICON_SHIELD )"},'+
        'monster_strike_block:{'+
            'kind:"fight",'+
            'RU:"-%d ( %dICON_SHIELD )&emsp;ICON_KNIGHT", '+
           'ENG:"-%d ( %dICON_SHIELD )&emsp;ICON_KNIGHT"},'+
        'fight_swords:{'+
            'kind:"fight",'+
            'RU:"&emsp;ICON_FIGHT&emsp;", '+
           'ENG:"&emsp;ICON_FIGHT&emsp;"},'+
        'attack_pool_empty:{'+
            'kind:"normal",'+
            'RU:"Стек атак пуст...", '+
           'ENG:"Attack pool is empty..."},'+
        'change_param:{'+
            'kind:"change_param",'+
            'RU:"<div class=\"icon %s\"></div>&emsp;%s&emsp;( =%d )", '+
           'ENG:"<div class=\"icon %s\"></div>&emsp;%s&emsp;( =%d )"},'+
        'change_item:{'+
            'kind:"change_item",'+
            'RU:"<div class=\"icon %s\"></div>&emsp;%s&emsp;%s&emsp;( =%d )", '+
           'ENG:"<div class=\"icon %s\"></div>&emsp;%s&emsp;%s&emsp;( =%d )"},'+
        'change_loot:{'+
            'kind:"change_loot",'+
            'RU:"<div class=\"icon %s\"></div>&emsp;%s&emsp;%s&emsp;( =%d )", '+
           'ENG:"<div class=\"icon %s\"></div>&emsp;%s&emsp;%s&emsp;( =%d )"},'+
        'allow_think:{'+
            'kind:"allow",'+
            'RU:"ICON_UNLOCK&emsp;Доступен режим <b>Раздумий</b>!", '+
           'ENG:"ICON_UNLOCK&emsp;<b>Think</b> mode available!"},'+
        'ready_think:{'+
            'kind:"allow",'+
            'RU:"ICON_BOOK&emsp;Завершено обдумывание:&emsp;<b>%s</b>!", '+
           'ENG:"ICON_BOOK&emsp;Finished thinking:&emsp;<b>%s</b>!"},'+
        'open_think:{'+
            'kind:"allow",'+
            'RU:"ICON_THINK&emsp;Новая мысль: &emsp;<b>%s</b>", '+
           'ENG:"ICON_THINK&emsp;The new think: &emsp;<b>%s</b>"},'+
    '},';

type
    TLog = class
    private
        lines : TList<string>;
            /// все записи лога, более старые, чем lastText, которая выводится динамически,
            /// но не более linesCount


        lastKind   /// тип последней добавленой записи в лог. влияет на CSS офомление
       ,lastText   /// текст последней добавленой записи в лог. используется для операций замены, склейки и прочего
                : string;

        Doc : TDocCreater;

        phrases: ISuperObject;
        function BuildLine: string;   // по текущим тексту и типу строим запись для лога в HTML формате
        function BuildLog: string;    // формирует полный HTML документ лога
    public
        wbLog : TWebBrowser;
        linesCount: integer;
            /// максимальное количество сообщений в чате, при привышении которого
            /// самые старые из которых будут удалены

        procedure GenerateImages;          // кодирование карионок в Base64 строки для CSS фонов
        procedure Clear;
        procedure Phrase(name, lang: string; params: array of TVarRec);
        procedure PhraseAppend(name, lang: string; params: array of TVarRec);
        procedure Add(kind,text: string);  // добавить новую строку с оформлением указанного типа
        procedure Append(text: string);   // приклеить текст к концу самой свежей строки
        procedure Prepend(text: string);   // приклеить текст к началу самой свежей строки
        procedure Replace(text: string);  // заменить текст к самой свежей строке
        procedure Update;                 // обновление содержимого wbLog
    end;

var
    Log : TLog;

implementation

{ TLog }

uses
    uAtlas, uGameDrive;

var
    IMAGE_NOTE_BG
   ,IMAGE_LEVEL
   ,IMAGE_BOOK
   ,IMAGE_UNLOCK

   ,ICON_GOLD
   ,ICON_SWORD
   ,ICON_SHIELD
   ,ICON_BLUESHIELD
   ,ICON_HEART
   ,ICON_MANA
   ,ICON_AUTO
   ,ICON_LEVEL
   ,ICON_EXP
   ,ICON_FIGHT
   ,ICON_CHEST
   ,ICON_UNLOCK
   ,ICON_MONSTER
   ,ICON_KNIGHT
   ,ICON_BRAIN
   ,ICON_BOOK
   ,ICON_THINK

   ,ICON_WOOD
   ,ICON_STONE
   ,ICON_HERBAL
   ,ICON_WHEAT
   ,ICON_MEAT
   ,ICON_BLOOD
   ,ICON_BONE
   ,ICON_SKIN
   ,ICON_ORE
   ,ICON_ESSENCE

   ,ICON_AUTOACTION
   ,ICON_BUFFREG
   ,ICON_EXPBUFF
   ,ICON_MDEFBUFF
   ,ICON_DEFBUFF
   ,ICON_ATKBUFF
   ,ICON_MPREG
   ,ICON_HPREG
   ,ICON_EXPGET
   ,ICON_MDEFGET
   ,ICON_DEFGET
   ,ICON_ATKGET
   ,ICON_HPGET
   ,ICON_MPGET
   ,ICON_TICKET
    : string;

procedure TLog.Add(kind, text: string);
begin
    /// пишем последнее сообщение в "архив"
    if  (lastKind <> '')
    then lines.Add( BuildLine );

    /// обрезаем самое старое сообщение, если вылазит за маскимум
    if lines.Count > linesCount
    then lines.Delete(0);

    /// обновляем инфу активной строки
    lastKind := kind;
    lastText := text;

    GameDrive.SetModeToUpdate(INT_LOG);
end;

procedure TLog.Append(text: string);
begin
    lastText := lastText + text;
end;

function TLog.BuildLine: string;
begin
    result := Format(LOG_LINE, [lastKind, lastText]);
end;

function TLog.BuildLog: string;
var
    i : integer;
begin
    Doc.Template.html := EMPTY_HTML;
    for i := 0 to lines.Count -1 do
       Doc.AddHTML(lines[i]);

    Doc.AddHTML( BuildLine );

    Doc.SetValue('IMAGE_NOTE_BG', IMAGE_NOTE_BG);
    Doc.SetValue('IMAGE_LEVEL', IMAGE_LEVEL);
    Doc.SetValue('IMAGE_BOOK', IMAGE_BOOK);
    Doc.SetValue('IMAGE_UNLOCK', IMAGE_UNLOCK);

    Doc.SetValue('ICON_GOLD', ICON_GOLD);
    Doc.SetValue('ICON_SWORD', ICON_SWORD);
    Doc.SetValue('ICON_SHIELD', ICON_SHIELD);
    Doc.SetValue('ICON_BLUESHIELD', ICON_BLUESHIELD);
    Doc.SetValue('ICON_HEART', ICON_HEART);
    Doc.SetValue('ICON_MANA', ICON_MANA);
    Doc.SetValue('ICON_AUTO', ICON_AUTO);
    Doc.SetValue('ICON_LEVEL', ICON_LEVEL);
    Doc.SetValue('ICON_EXP', ICON_EXP);
    Doc.SetValue('ICON_FIGHT', ICON_FIGHT);
    Doc.SetValue('ICON_CHEST', ICON_CHEST);
    Doc.SetValue('ICON_UNLOCK', ICON_UNLOCK);
    Doc.SetValue('ICON_MONSTER', ICON_MONSTER);
    Doc.SetValue('ICON_KNIGHT', ICON_KNIGHT);
    Doc.SetValue('ICON_BRAIN', ICON_BRAIN);
    Doc.SetValue('ICON_WOOD', ICON_WOOD);
    Doc.SetValue('ICON_STONE', ICON_STONE);
    Doc.SetValue('ICON_HERBAL', ICON_HERBAL);
    Doc.SetValue('ICON_WHEAT', ICON_WHEAT);
    Doc.SetValue('ICON_MEAT', ICON_MEAT);
    Doc.SetValue('ICON_BLOOD', ICON_BLOOD);
    Doc.SetValue('ICON_BONE', ICON_BONE);
    Doc.SetValue('ICON_SKIN', ICON_SKIN);
    Doc.SetValue('ICON_ORE', ICON_ORE);
    Doc.SetValue('ICON_ESSENCE', ICON_ESSENCE);
    Doc.SetValue('ICON_BOOK', ICON_BOOK);
    Doc.SetValue('ICON_THINK', ICON_THINK);
    Doc.SetValue('ICON_TICKET', ICON_TICKET);

    Doc.SetValue('ICON_AUTOACTION', ICON_AUTOACTION);
    Doc.SetValue('ICON_BUFFREG', ICON_BUFFREG);
    Doc.SetValue('ICON_EXPBUFF', ICON_EXPBUFF);
    Doc.SetValue('ICON_MDEFBUFF', ICON_MDEFBUFF);
    Doc.SetValue('ICON_DEFBUFF', ICON_DEFBUFF);
    Doc.SetValue('ICON_ATKBUFF', ICON_ATKBUFF);
    Doc.SetValue('ICON_MPREG', ICON_MPREG);
    Doc.SetValue('ICON_HPREG', ICON_HPREG);
    Doc.SetValue('ICON_EXPGET', ICON_EXPGET);
    Doc.SetValue('ICON_MDEFGET', ICON_MDEFGET);
    Doc.SetValue('ICON_DEFGET', ICON_DEFGET);
    Doc.SetValue('ICON_ATKGET', ICON_ATKGET);
    Doc.SetValue('ICON_HPGET', ICON_HPGET);
    Doc.SetValue('ICON_MPGET', ICON_MPGET);


    Doc.SetValue('ICON_GOLD', Format(ICON_TEMPLATE, ['icon icon_gold']), false);
    Doc.SetValue('ICON_SWORD', Format(ICON_TEMPLATE, ['icon icon_sword']), false);
    Doc.SetValue('ICON_SHIELD', Format(ICON_TEMPLATE, ['icon icon_shield']), false);
    Doc.SetValue('ICON_BLUESHIELD', Format(ICON_TEMPLATE, ['icon icon_blueshield']), false);
    Doc.SetValue('ICON_HEART', Format(ICON_TEMPLATE, ['icon icon_heart']), false);
    Doc.SetValue('ICON_MANA', Format(ICON_TEMPLATE, ['icon icon_mana']), false);
    Doc.SetValue('ICON_AUTO', Format(ICON_TEMPLATE, ['icon icon_auto']), false);
    Doc.SetValue('ICON_LEVEL', Format(ICON_TEMPLATE, ['icon icon_level']), false);
    Doc.SetValue('ICON_EXP', Format(ICON_TEMPLATE, ['icon icon_exp']), false);
    Doc.SetValue('ICON_FIGHT', Format(ICON_TEMPLATE, ['icon icon_fight']), false);
    Doc.SetValue('ICON_CHEST', Format(ICON_TEMPLATE, ['icon icon_chest']), false);
    Doc.SetValue('ICON_UNLOCK', Format(ICON_TEMPLATE, ['icon icon_unlock']), false);
    Doc.SetValue('ICON_MONSTER', Format(ICON_TEMPLATE, ['icon icon_monster']), false);
    Doc.SetValue('ICON_KNIGHT', Format(ICON_TEMPLATE, ['icon icon_knight']), false);
    Doc.SetValue('ICON_BRAIN', Format(ICON_TEMPLATE, ['icon icon_brain']), false);
    Doc.SetValue('ICON_BOOK', Format(ICON_TEMPLATE, ['icon icon_book']), false);
    Doc.SetValue('ICON_THINK', Format(ICON_TEMPLATE, ['icon icon_think']), false);

    Doc.SetValue('ICON_WOOD', Format(ICON_TEMPLATE, ['icon wood']), false);
    Doc.SetValue('ICON_STONE', Format(ICON_TEMPLATE, ['icon stone']), false);
    Doc.SetValue('ICON_HERBAL', Format(ICON_TEMPLATE, ['icon herbal']), false);
    Doc.SetValue('ICON_WHEAT', Format(ICON_TEMPLATE, ['icon wheat']), false);
    Doc.SetValue('ICON_MEAT', Format(ICON_TEMPLATE, ['icon meat']), false);
    Doc.SetValue('ICON_BLOOD', Format(ICON_TEMPLATE, ['icon blood']), false);
    Doc.SetValue('ICON_BONE', Format(ICON_TEMPLATE, ['icon bone']), false);
    Doc.SetValue('ICON_SKIN', Format(ICON_TEMPLATE, ['icon skin']), false);
    Doc.SetValue('ICON_ORE', Format(ICON_TEMPLATE, ['icon ore']), false);
    Doc.SetValue('ICON_ESSENCE', Format(ICON_TEMPLATE, ['icon essence']), false);

    Doc.SetValue('ICON_AUTOACTION', Format(ICON_TEMPLATE, ['icon potionAuto']), false);
    Doc.SetValue('ICON_BUFFREG', Format(ICON_TEMPLATE, ['icon buffREG']), false);
    Doc.SetValue('ICON_EXPBUFF', Format(ICON_TEMPLATE, ['icon buffEXP']), false);
    Doc.SetValue('ICON_MDEFBUFF', Format(ICON_TEMPLATE, ['icon buffMDEF']), false);
    Doc.SetValue('ICON_DEFBUFF', Format(ICON_TEMPLATE, ['icon buffDEF']), false);
    Doc.SetValue('ICON_ATKBUFF', Format(ICON_TEMPLATE, ['icon buffATK']), false);
    Doc.SetValue('ICON_MPREG', Format(ICON_TEMPLATE, ['icon regenMP']), false);
    Doc.SetValue('ICON_HPREG', Format(ICON_TEMPLATE, ['icon regenHP']), false);
    Doc.SetValue('ICON_EXPGET', Format(ICON_TEMPLATE, ['icon potionexp']), false);
    Doc.SetValue('ICON_MDEFGET', Format(ICON_TEMPLATE, ['icon PermanentMDEF']), false);
    Doc.SetValue('ICON_DEFGET', Format(ICON_TEMPLATE, ['icon permanentDEF']), false);
    Doc.SetValue('ICON_ATKGET', Format(ICON_TEMPLATE, ['icon permanentATK']), false);
    Doc.SetValue('ICON_HPGET', Format(ICON_TEMPLATE, ['icon restoreMana']), false);
    Doc.SetValue('ICON_MPGET', Format(ICON_TEMPLATE, ['icon restoreHealth']), false);
    Doc.SetValue('ICON_TICKET', Format(ICON_TEMPLATE, ['icon buffSPEED']), false);

    Doc.ClearMarks;

    result := Doc.Template.html;
end;

procedure TLog.Clear;
begin
    lastKind := '';
    lastText := '';
    wbLog.LoadFromStrings('', '');
end;

procedure TLog.GenerateImages;
begin
    if IMAGE_NOTE_BG = '' then IMAGE_NOTE_BG :=  fAtlas.EncodeToBase64('NOTE_BG');
    if IMAGE_LEVEL = '' then IMAGE_LEVEL :=  fAtlas.EncodeToBase64('IMAGE_LEVEL');
    if IMAGE_BOOK = '' then IMAGE_BOOK :=  fAtlas.EncodeToBase64('IMAGE_BOOK');
    if IMAGE_UNLOCK = '' then IMAGE_UNLOCK :=  fAtlas.EncodeToBase64('IMAGE_UNLOCK');

    if ICON_GOLD = '' then ICON_GOLD :=  fAtlas.EncodeToBase64('ICON_GOLD');
    if ICON_SWORD = '' then ICON_SWORD :=  fAtlas.EncodeToBase64('ICON_SWORD');
    if ICON_SHIELD = '' then ICON_SHIELD :=  fAtlas.EncodeToBase64('ICON_SHIELD');
    if ICON_BLUESHIELD = '' then ICON_BLUESHIELD :=  fAtlas.EncodeToBase64('ICON_BLUESHIELD');
    if ICON_HEART = '' then ICON_HEART :=  fAtlas.EncodeToBase64('ICON_HEART');
    if ICON_MANA = '' then ICON_MANA :=  fAtlas.EncodeToBase64('ICON_POWER');
    if ICON_AUTO = '' then ICON_AUTO :=  fAtlas.EncodeToBase64('ICON_AUTO');
    if ICON_LEVEL = '' then ICON_LEVEL :=  fAtlas.EncodeToBase64('ICON_LEVEL');
    if ICON_EXP = '' then ICON_EXP :=  fAtlas.EncodeToBase64('ICON_EXP');
    if ICON_FIGHT = '' then ICON_FIGHT :=  fAtlas.EncodeToBase64('ICON_FIGHT');
    if ICON_CHEST = '' then ICON_CHEST :=  fAtlas.EncodeToBase64('ICON_CHEST');
    if ICON_UNLOCK = '' then ICON_UNLOCK :=  fAtlas.EncodeToBase64('ICON_UNLOCK');
    if ICON_MONSTER = '' then ICON_MONSTER :=  fAtlas.EncodeToBase64('ICON_MONSTER');
    if ICON_KNIGHT = '' then ICON_KNIGHT :=  fAtlas.EncodeToBase64('ICON_KNIGHT');
    if ICON_BRAIN = '' then ICON_BRAIN :=  fAtlas.EncodeToBase64('ICON_BRAIN');
    if ICON_BOOK = '' then ICON_BOOK :=  fAtlas.EncodeToBase64('ICON_BOOK');
    if ICON_THINK = '' then ICON_THINK :=  fAtlas.EncodeToBase64('ICON_THINK');

    if ICON_WOOD = '' then ICON_WOOD :=  fAtlas.EncodeToBase64('ICON_WOOD');
    if ICON_STONE = '' then ICON_STONE :=  fAtlas.EncodeToBase64('ICON_STONE');
    if ICON_HERBAL = '' then ICON_HERBAL :=  fAtlas.EncodeToBase64('ICON_HERBAL');
    if ICON_WHEAT = '' then ICON_WHEAT :=  fAtlas.EncodeToBase64('ICON_WHEAT');
    if ICON_MEAT = '' then ICON_MEAT :=  fAtlas.EncodeToBase64('ICON_MEAT');
    if ICON_BLOOD = '' then ICON_BLOOD :=  fAtlas.EncodeToBase64('ICON_BLOOD');
    if ICON_BONE = '' then ICON_BONE :=  fAtlas.EncodeToBase64('ICON_BONE');
    if ICON_SKIN = '' then ICON_SKIN :=  fAtlas.EncodeToBase64('ICON_SKIN');
    if ICON_ORE = '' then ICON_ORE :=  fAtlas.EncodeToBase64('ICON_ORE');
    if ICON_ESSENCE = '' then ICON_ESSENCE :=  fAtlas.EncodeToBase64('ICON_ESSENCE');

    if ICON_AUTOACTION = '' then ICON_AUTOACTION :=  fAtlas.EncodeToBase64('ICON_AUTOACTION');
    if ICON_BUFFREG = '' then ICON_BUFFREG :=  fAtlas.EncodeToBase64('ICON_BUFFREG');
    if ICON_EXPBUFF = '' then ICON_EXPBUFF :=  fAtlas.EncodeToBase64('ICON_EXPBUFF');
    if ICON_MDEFBUFF = '' then ICON_MDEFBUFF :=  fAtlas.EncodeToBase64('ICON_MDEFBUFF');
    if ICON_DEFBUFF = '' then ICON_DEFBUFF :=  fAtlas.EncodeToBase64('ICON_DEFBUFF');
    if ICON_ATKBUFF = '' then ICON_ATKBUFF :=  fAtlas.EncodeToBase64('ICON_ATKBUFF');
    if ICON_MPREG = '' then ICON_MPREG :=  fAtlas.EncodeToBase64('ICON_MPREG');
    if ICON_HPREG = '' then ICON_HPREG :=  fAtlas.EncodeToBase64('ICON_HPREG');
    if ICON_EXPGET = '' then ICON_EXPGET :=  fAtlas.EncodeToBase64('ICON_EXPGET');
    if ICON_MDEFGET = '' then ICON_MDEFGET :=  fAtlas.EncodeToBase64('ICON_MDEFGET');
    if ICON_DEFGET = '' then ICON_DEFGET :=  fAtlas.EncodeToBase64('ICON_DEFGET');
    if ICON_ATKGET = '' then ICON_ATKGET :=  fAtlas.EncodeToBase64('ICON_ATKGET');
    if ICON_HPGET = '' then ICON_HPGET :=  fAtlas.EncodeToBase64('ICON_HPGET');
    if ICON_MPGET = '' then ICON_MPGET :=  fAtlas.EncodeToBase64('ICON_MPGET');
    if ICON_TICKET = '' then ICON_TICKET :=  fAtlas.EncodeToBase64('ICON_TICKET');

end;

procedure TLog.Phrase(name, lang: string; params: array of TVarRec);
var
    text : string;
begin
    if not Assigned( phrases.O[name]) then exit;
    text := Format(phrases.S[name+'.'+lang], params);
    Add(phrases.S[name+'.kind'], text);
end;

procedure TLog.PhraseAppend(name, lang: string; params: array of TVarRec);
var
    text : string;
begin
    if not Assigned( phrases.O[name]) then exit;
    text := Format(phrases.S[name+'.'+lang], params);
    Append(text);
end;

procedure TLog.Prepend(text: string);
begin
    lastText := text + lastText;
end;

procedure TLog.Replace(text: string);
begin
    lastText := text;
end;

procedure TLog.Update;
begin
    wbLog.LoadFromStrings( BuildLog, '');
end;

initialization
    Log := TLog.Create;
    Log.lines := TList<string>.Create;
    Log.Doc := TDocCreater.Create;
    Log.phrases := SO(PHRASES_LIST);

finalization
    Log.Doc.Free;
    Log.lines.Free;
    Log.Free;

end.

