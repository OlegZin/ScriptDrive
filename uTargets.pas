unit uTargets;

interface

type
    TTarget = record
        level: integer;
        script: string;
    end;

var
    /// массив изменения состояний игры при достижения опредлеленных уровней.
    /// сердце игры, ради которого мутилась фишка со скриптами
    targets: array [0..6] of TTarget = (
        (level: 2;
         script:
             'SetBreak(Tower);'+
             'SetVar(count, 10);'+
             'AddEvent(..................);'+

             'IF({GetLang() = RU}, 2);'+
             'AddEvent(Игрок получил GetVar(count) зелий AutoAction);'+
             'AddEvent(В ржавом сундуке между этажами нашлось немного зелий.);'+

             'IF({GetLang() = ENG}, 2);'+
             'AddEvent(Player got GetVar(count) AutoAction items);'+
             'AddEvent(Some potions were found in a rusty chest between floors.);'+

             'AddEvent(..................);'+

             'ChangePlayerItemCount(AutoAction, GetVar(count));'+
             'SetNextTarget();'
        ),

        (level: 3;
         script:
             'SetBreak(Tower);'+
             'AddEvent(..................);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If({GetLang() = RU}, 1);'+
             'AddEvent(Игрок получил GetVar(iName)!);'+
             'If({GetLang() = ENG}, 1);'+
             'AddEvent(Player get GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If({GetLang() = RU}, 1);'+
             'AddEvent(Игрок получил GetVar(iName)!);'+
             'If({GetLang() = ENG}, 1);'+
             'AddEvent(Player get GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If({GetLang() = RU}, 1);'+
             'AddEvent(Игрок получил GetVar(iName)!);'+
             'If({GetLang() = ENG}, 1);'+
             'AddEvent(Player get GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If({GetLang() = RU}, 1);'+
             'AddEvent(Игрок получил GetVar(iName)!);'+
             'If({GetLang() = ENG}, 1);'+
             'AddEvent(Player get GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If({GetLang() = RU}, 1);'+
             'AddEvent(Игрок получил GetVar(iName)!);'+
             'If({GetLang() = ENG}, 1);'+
             'AddEvent(Player get GetVar(iName)!);'+

             'AddEvent( );'+

             'If({GetLang() = RU}, 1);'+
             'AddEvent(Вы нашли огромный сундк! Замок поддается не с первого раза...);'+
             'If({GetLang() = ENG}, 1);'+
             'AddEvent(You have found a huge chest! The lock does not give in the first time ...);'+

             'AddEvent(..................);'+
             'SetNextTarget();'
        ),

        (level: 4;
         script:
             'SetBreak(Tower);'+
             'SetVar(gold, Rand(100000));'+
             'AddEvent(..................);'+

             'IF({GetLang() = RU}, 9);'+
             'AddEvent(Игрок получил GetVar(gold) золота);'+
             'AddEvent(    Доступен режим Раздумий!);'+
             'AddEvent( );'+
             'AddEvent("Следует как следует подумать об этом!");'+
             'AddEvent("Подождите. Какая башня, какой Темный мастер? Что я здесь делаю?");'+
             'AddEvent( );'+
             'AddEvent(" - Темный Мастер охраняет свою башню днем и ночью, бродя по бесконечным этажам. Ни одна живая душа не избегнет его гнева и ярости его чудовищ.");'+
             'AddEvent("Так же, в сундуке лежит смятая записка:");'+
             'AddEvent(В ржавом сундуке между этажами нашлось немного золота.);'+

             'IF({GetLang() = ENG}, 9);'+
             'AddEvent(    Player got GetVar(gold) Gold);'+
             'AddEvent(    Think mode available!);'+
             'AddEvent( );'+
             'AddEvent("Think about it well!");'+
             'AddEvent("Wait. Which tower, which Dark master? What am I doing here?");'+
             'AddEvent( );'+
             'AddEvent(" - The Dark Master guards his tower day and night, roaming the endless floors. No living soul can escape his wrath and the fury of his monsters.");'+
             'AddEvent("Also, there is a crumpled note in the chest:");'+
             'AddEvent(There was some gold in a rusty chest between floors.);'+

             'AddEvent(..................);'+

             'AllowMode(Think, 1);'+
             'ChangePlayerItemCount(Gold, GetVar(gold));'+
             'SetNextTarget();'
        ),

       (level: 5;
         script:
             'SetBreak(Tower);'+
             'AddEvent(..................);'+

             'IF({GetLang() = ENG}, 4);'+
             'SetVar(DarkMaster, DARK MASTER);'+
             'AddEvent(" - YOU WILL NOT PASS!");' +
             'AddEvent(" - What are you doing in my Tower, insignificance!?");' +
             'SetCreatureScript(OnDeath,"AddEvent(..................);AddEvent(- You defeated ME!? Can not be! Who are You?!);AddEvent(..................);");'+

             'IF({GetLang() = RU}, 4);'+
             'SetVar(DarkMaster, ТЕМНЫЙ МАСТЕР);'+
             'AddEvent(" - ТЫ НЕ ПРОЙДЕШЬ!");' +
             'AddEvent(" - Что ты делаешь в моей Башне, ничтожество!?");' +
             'SetCreatureScript(OnDeath,"SetBreak(Tower);AddEvent(..................);AddEvent(- Ты победил МЕНЯ!? Не может быть! Кто ты такой!?);AddEvent(..................);SetNextTarget();");'+

             'SetCreature(GetVar(DarkMaster),HP=9999 ATK=100,SpiritBless=1,);'+

             'AddEvent(..................);'
        )

       ,(level: 7;
         script:
             'SetBreak(Tower);'+

             'AddEvent(..................);'+

             'IF({GetLang() = ENG}, 3);'+
             'SetVar(DarkMaster,ANGRY DARK MASTER);'+
             'AddEvent(" - This is our last meeting, stranger! You will not leave my Tower!");' +
             'SetCreatureScript(OnDeath,"AddEvent(..................);AddEvent(- You defeated ME!? Can not be! Who are You?!);AddEvent(..................);");'+

             'IF({GetLang() = RU}, 3);'+
             'SetVar(DarkMaster,ЗЛОЙ ТЕМНЫЙ МАСТЕР);'+
             'AddEvent(" - Это наша последняя встреча, чужак! Ты не выйдешь из моей Башни!");' +
             'SetCreatureScript(OnDeath,"AddEvent(..................);AddEvent(- Ты победил МЕНЯ!? Не может быть! Кто ты такой!?);AddEvent(..................);");'+

             'SetCreature(GetVar(DarkMaster),HP=99999 ATK=1000,,);'+

             'AddEvent(..................);'+
             'SetNextTarget();'
        )

       ,(level: 10;
         script:
             'SetBreak(Tower);'+

             'AddEvent(..................);'+

             'IF({GetLang() = ENG}, 4);'+
             'SetVar(DarkMaster,FURY DARK MASTER);'+
             'AddEvent(" - You broke into my Tower, scared monsters, looted chests. Who are you after that !?");' +
             'AddEvent(" - Now EXACTLY our last meeting!");' +
             'SetCreatureScript(OnDeath,"AddEvent(..................);AddEvent(- You defeated ME!? Can not be! Who are You?!);AddEvent(..................);");'+

             'IF({GetLang() = RU}, 4);'+
             'SetVar(DarkMaster,ЯРОСТНЫЙ ТЕМНЫЙ МАСТЕР);'+
             'AddEvent(" - Ты вломился в мою Башню, рапугал монстров, разграбил сундуки. Да кто ты такой после этого!?");' +
             'AddEvent(" - Вот теперь ТОЧНО наша последняя встреча!");' +
             'SetCreatureScript(OnDeath,"AddEvent(..................);AddEvent(- Ты победил МЕНЯ!? Не может быть! Кто ты такой!?);AddEvent(..................);");'+

             'SetCreature(GetVar(DarkMaster),HP=999999 ATK=10000,,);'+

             'AddEvent(..................);'+
             'SetNextTarget();'
        )

       ,(level: 11;
         script:
             'SetBreak(Tower);'+
             'AddEvent(..................);'+
             'IF({GetLang() = ENG}, 2);'+
             'AddEvent(!!! INCREDIBLE !!!);' +
             'AddEvent(!!! YOU PASS THE GAME !!!);' +

             'IF({GetLang() = RU}, 2);'+
             'AddEvent(!!! НЕВЕРОЯТНО !!!);' +
             'AddEvent(!!! ТЫ ПРОШЕЛ ИГРУ !!!);' +
             'AddEvent(..................);'+

             'CurrentLevel(1);InitCreatures();'
        )
    );

implementation

end.
