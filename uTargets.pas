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
    targets: array [0..7] of TTarget = (
        (level: 1;
         script:
             'ChangePlayerItemCount(Gold, 100000);'+
             'AddEvent(..................);'+

//             'IF({GetLang() = RU}, 14);'+
             'AddEvent(    Игрок получил 100 000 золота);'+
             'AddEvent( );'+
             'AddEvent("БОЙ!");'+
             'AddEvent("Рука непроизвольно стиснула рукоять непонятно откуда взявшегося кинжала и выбросила его навстречу летящему на тебя монстру.");'+
             'AddEvent("Неподалеку, за кучами мусора, послышалось шевеление и тихое рычание.");'+
             'AddEvent("Несколько раз перечитав послание, ты так и не понял его смысла. Но долго думать об этом тебе не дали.");'+
             'AddEvent( );'+
             'AddEvent("Это на первое время. Больше ничем помочь не могу. Знаю, что сейчас ты сбит с толку и ничего не помнишь, '+
                 'но это было необходимо сделать. Позднее сам все поймешь. И что бы не происходило в Башне, помни: нужно найти выход! Сейчас ты в самой дальней от него, но и самой безопасной точке входа. Удачи, мой друг!");'+
             'AddEvent( );'+
             'AddEvent("В слабом свете факелов ты с трудом разбираешь текст:");'+
             'AddEvent("Практически под рукой обнаруживается увесистый тряпичный мешочек с пришпиленной к нему запиской.");'+
             'AddEvent("Окна отсутствуют. Только факела коптят по стенам. В дальнем углу смутно виднеется лестница наверх к массивной, оббитой железом двери.");'+
             'AddEvent("Немного оглядевшись, ты понимаешь, что находишься в каком-то большом пустом помещении, заваленном различным хламом.");'+
             'AddEvent("В голове пустота, сердце сжимается от ощущение утраты.");'+
             'AddEvent("Ты открываешь глаза в полумраке на каменном полу.");'+

             'AddEvent( );'+
             'AddEvent( );'+
             'AddEvent( );'+

//             'IF({GetLang() = ENG}, 14);'+
             'AddEvent(    Player got 100 000 Gold);'+
             'AddEvent( );'+
             'AddEvent("FIGHT!");'+
             'AddEvent("The hand involuntarily gripped the handle of the dagger that had come from nowhere and threw it out towards the monster flying at you.");'+
             'AddEvent("Nearby, behind heaps of rubbish, there was a stirring and a low growl.");'+
             'AddEvent("After rereading the message several times, you still do not understand its meaning. But you were not allowed to think about it for a long time.");'+
             'AddEvent( );'+
             'AddEvent("This is for the first time. I can not help you anymore. I know that now you are confused and do not remember anything, '+
                 'but it was necessary to do it. Later you will understand everything yourself. And whatever happens in the Tower, remember: you need to find a way out! Now you are at the farthest from him, but also the safest entry point. Good luck my friend!");'+
             'AddEvent( );'+
             'AddEvent("In the faint light of torches, you can hardly make out the text:");'+
             'AddEvent("Almost at hand, a weighty rag bag with a note pinned to it is found.");'+
             'AddEvent("There are no windows. Only torches are smoked on the walls. In the far corner, a staircase upstairs to a massive iron-clad door is dimly visible.");'+
             'AddEvent("Looking around a little, you realize that you are in some large empty room littered with various rubbish.");'+
             'AddEvent("There is emptiness in my head, my heart squeezes from the feeling of loss.");'+
             'AddEvent("You open your eyes in the twilight on the stone floor.");'+

             'AddEvent(..................);'+

             'SetNextTarget();'
        ),

        (level: 2;
         script:
             'SetBreak(Tower);'+
             'SetVar(gold, Rand(100000));'+
             'AddEvent(..................);'+

             'IF({GetLang() = RU}, 14);'+
             'AddEvent(    Игрок получил GetVar(gold) золота);'+
             'AddEvent(    Доступен режим Раздумий!);'+
             'AddEvent( );'+
             'AddEvent("Следует как следует подумать об этом!");'+
             'AddEvent("Подождите. Какая башня, какой Темный мастер? Что я здесь делаю?");'+
             'AddEvent( );'+
             'AddEvent("О, горе! Я потерял свой дневник в кучах этого хлама! Годы накопленных знаний пропали! Даже не смотря на то, что он зашифрован, страшно представить каких бед он может принести в плохих руках... О, боги!..");'+
             'AddEvent( );'+
             'AddEvent("Только я собрался навести порядок на этажах, проклятые монстры разбили сундук с инструментами и растащили их по этажам! Я знаю, что их науськал этот проклятый Икки, прихвостень Темного Мастера.");'+
             'AddEvent( );'+
             'AddEvent("Темный Мастер охраняет свою башню днем и ночью, бродя по бесконечным этажам. Ни одна живая душа не избегнет его гнева и ярости его чудовищ.");'+
             'AddEvent( );'+
             'AddEvent("Так же, в сундуке лежит несколько смятых листов:");'+
             'AddEvent(В ржавом сундуке между этажами нашлось немного золота.);'+

             'IF({GetLang() = ENG}, 14);'+
             'AddEvent(    Player got GetVar(gold) Gold);'+
             'AddEvent(    Think mode available!);'+
             'AddEvent( );'+
             'AddEvent("Think about it well!");'+
             'AddEvent("Wait. Which tower, which Dark master? What am I doing here?");'+
             'AddEvent( );'+
             'AddEvent("Oh woe! I lost my diary in a lot of this junk! Years of accumulated knowledge are gone! Even in spite of the fact that it is encrypted, it is scary to imagine what troubles it can bring in bad hands ... Oh, gods! ..");'+
             'AddEvent( );'+
             'AddEvent("As soon as I was about to put things in order on the floors, the damn monsters smashed the chest with tools and took them to the floors! I know that this damned Ikki, the Dark Master henchman, brought them up.");'+
             'AddEvent( );'+
             'AddEvent("The Dark Master guards his tower day and night, roaming the endless floors. No living soul can escape his wrath and the fury of his monsters.");'+
             'AddEvent( );'+
             'AddEvent("Also, there are several crumpled sheets in the chest:");'+
             'AddEvent(There was some gold in a rusty chest between floors.);'+

             'AddEvent(..................);'+

             'AllowMode(Think, 1);'+
             'ChangePlayerItemCount(Gold, GetVar(gold));'+
             'SetNextTarget();'
        ),

        (level: 3;
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

        (level: 4;
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


       (level: 5;
         script:
             'SetBreak(Tower);'+
             'AddEvent(..................);'+

             'IF({GetLang() = ENG}, 4);'+
             'SetVar(DarkMaster, DARK MASTER);'+
             'AddEvent(" - YOU WILL NOT PASS!");' +
             'AddEvent(" - What are you doing in my Tower, insignificance!?");' +
             'SetCreatureScript(OnDeath,"AddEvent(..................);AddEvent(- You defeated ME!? Can not be! Who are You?!);AddEvent(..................);AllowTool(Sword);SetNextTarget();");'+

             'IF({GetLang() = RU}, 4);'+
             'SetVar(DarkMaster, ТЕМНЫЙ МАСТЕР);'+
             'AddEvent(" - ТЫ НЕ ПРОЙДЕШЬ!");' +
             'AddEvent(" - Что ты делаешь в моей Башне, ничтожество!?");' +
             'SetCreatureScript(OnDeath,"SetBreak(Tower);AddEvent(..................);AddEvent(- Ты победил МЕНЯ!? Не может быть! Кто ты такой!?);AddEvent(..................);AllowTool(Sword);SetNextTarget();");'+

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
             'SetCreatureScript(OnDeath,"AddEvent(..................);AddEvent(- You defeated ME!? Can not be! Who are You?!);AddEvent(..................);SetNextTarget();");'+

             'IF({GetLang() = RU}, 3);'+
             'SetVar(DarkMaster,ЗЛОЙ ТЕМНЫЙ МАСТЕР);'+
             'AddEvent(" - Это наша последняя встреча, чужак! Ты не выйдешь из моей Башни!");' +
             'SetCreatureScript(OnDeath,"AddEvent(..................);AddEvent(- Ты победил МЕНЯ!? Не может быть! Кто ты такой!?);AddEvent(..................);SetNextTarget();");'+

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
             'SetCreatureScript(OnDeath,"AddEvent(..................);AddEvent(- You defeated ME!? Can not be! Who are You?!);AddEvent(..................);SetNextTarget();");'+

             'IF({GetLang() = RU}, 4);'+
             'SetVar(DarkMaster,ЯРОСТНЫЙ ТЕМНЫЙ МАСТЕР);'+
             'AddEvent(" - Ты вломился в мою Башню, рапугал монстров, разграбил сундуки. Да кто ты такой после этого!?");' +
             'AddEvent(" - Вот теперь ТОЧНО наша последняя встреча!");' +
             'SetCreatureScript(OnDeath,"AddEvent(..................);AddEvent(- Ты победил МЕНЯ!? Не может быть! Кто ты такой!?);AddEvent(..................);SetNextTarget();");'+

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
