unit uFloorTargetsDB;

interface

uses superobject;

function FloorTargets: ISuperObject;

implementation

const
data_str =
    /// список целей по уровням
    '{'+
        '1:"'+
             'If(GetLang() = RU, 6);'+
             'Log(normal,\"Ты открываешь глаза в полумраке на каменном полу. В голове пустота, сердце сжимается от ощущение утраты.\");'+
             'Log(normal,\"Немного оглядевшись, ты понимаешь, что находишься в каком-то большом пустом помещении, заваленном различным хламом. Окна отсутствуют. Только факела коптят по стенам. '+
                 'В дальнем углу смутно виднеется лестница наверх к массивной, оббитой железом двери.\");'+
             'Log(normal,\"Практически под рукой обнаруживается увесистый тряпичный мешочек с пришпиленной к нему запиской. В слабом свете факелов ты с трудом разбираешь текст:\");'+
             'Log(note,\"Тут золото и кое-какие вещи. Это на первое время. Больше ничем помочь не могу. Знаю, что сейчас ты сбит с толку и ничего не помнишь, '+
                 'но это было необходимо сделать. Позднее сам все поймешь. И что бы не происходило в Башне, помни: нужно найти выход! Сейчас ты в самой дальней от него, но и самой безопасной точке входа. Удачи, мой друг!\");'+
             'Log(normal,\"Несколько раз перечитав послание, ты так и не понял его смысла. Но долго думать об этом тебе не дали. Неподалеку, за кучами мусора, послышалось шевеление и тихое рычание. '+
                 'Рука непроизвольно стиснула рукоять непонятно откуда взявшегося кинжала и выбросила его навстречу летящему на тебя монстру.\");'+
             'Log(danger,\"БОЙ!\");'+

             'If(GetLang() = ENG, 6);'+
             'Log(normal,\"You open your eyes in the twilight on the stone floor. There is emptiness in my head, my heart squeezes from the feeling of loss.\");'+
             'Log(normal,\"Looking around a little, you realize that you are in some large empty room littered with various rubbish. '+
                 'There are no windows. Only torches are smoked on the walls. In the far corner, a staircase upstairs to a massive iron-clad door is dimly visible.\");'+
             'Log(normal,\"Almost at hand, a weighty rag bag with a note pinned to it is found. In the faint light of torches, you can hardly make out the text:\");'+
             'Log(note,\"There is gold and some things. This is for the first time. I can not help you anymore. I know that now you are confused and do not remember anything, '+
                 'but it was necessary to do it. Later you will understand everything yourself. And whatever happens in the Tower, remember: you need to find a way out! Now you are at the farthest from him, but also the safest entry point. Good luck my friend!\");'+
             'Log(normal,\"After rereading the message several times, you still do not understand its meaning. But you were not allowed to think about it for a long time. Nearby, behind heaps of rubbish, there was a stirring and a low growl. '+
                 'The hand involuntarily gripped the handle of the dagger that had come from nowhere and threw it out towards the monster flying at you.\");'+
             'Log(danger,\"FIGHT!\");'+
             'SetCurrTarget(2);'+
             'SetVar(FirstOnFloor, 2);'+

//                 'AllowMode(Think);'+
//                 'AllowThink(wakeup);'+

                 'AllowMode(Floor);'+

             'ChangePlayerItemCount(buffSPEED, 100000);'+
             'ChangePlayerItemCount(potionAuto, 100000);'+


{
             'ChangePlayerItemCount(gold, 1000000);'+
             'ChangePlayerItemCount(restoreMana, Rand(100000));'+
             'ChangePlayerItemCount(permanentATK, Rand(100000));'+
             'ChangePlayerItemCount(permanentDEF, Rand(100000));'+
             'ChangePlayerItemCount(permanentMDEF, Rand(100000));'+
             'ChangePlayerItemCount(potionexp, Rand(100000));'+
             'ChangePlayerItemCount(regenHP, Rand(100000));'+
             'ChangePlayerItemCount(regenMP, Rand(100000));'+
             'ChangePlayerItemCount(buffATK, Rand(100000));'+
             'ChangePlayerItemCount(buffDEF, Rand(100000));'+
             'ChangePlayerItemCount(buffMDEF, Rand(100000));'+
             'ChangePlayerItemCount(buffEXP, Rand(100000));'+
             'ChangePlayerItemCount(buffREG, Rand(100000));'+
             'ChangePlayerItemCount(buffSpeed, Rand(100000));'+
             'ChangePlayerItemCount(potionAuto, Rand(100000));'+
}        '",'+
        '2:"'+
             'BreakAuto(Tower);'+

             /// мастер оставил стража
             'IF(GetVar(first_meet) = 6, 9);'+
                 'SetMonsterAsTarget();'+
                 'SetImage(32);'+
                 'SetParam(HP, 5000);'+
                 'SetParam(ATK, 50);'+
                 'SetParam(DEF, 30);'+
                 'SetName(RU,\"Адский Пес\");'+
                 'SetName(ENG,\"Hell Dog\");'+
                 'ChangeLootCount(essence,20);'+
                 'SetEvent(OnDeath,\"ChangeVar(first_meet, 1);ChangeVar(ikki, 1);SetCurrTarget(3);Log(good,Phrase(dog_is_dead));\");'+

             /// пятая встреча с темным мастером
             'IF(GetVar(first_meet) = 5, 14);'+
                 'ChangeVar(first_meet, 1);'+
                 'SetMonsterAsTarget();'+
                 'SetImage(31);'+
                 'SetParam(HP, 9999);'+
                 'SetParam(ATK, 100);'+
                 'SetParam(DEF, 0);'+
                 'SetName(RU,\"\");'+
                 'SetName(ENG,\"\");'+
                 'ChangeLootCount(essence,100);'+
                 'IF(GetLang() = ENG, 1);'+
                     'Log(danger,\"It''s fun, but I don''t have time to mess with you. But don''t be upset! My dog will sit with you. HA-HA-HA!\");' +
                 'IF(GetLang() = RU, 1);'+
                     'Log(danger,\"Это весело, но на возню с тобой у меня нет времени. Но ты не расстраивайся! С тобой поседит мой песик. ХА-ХА-ХА!\");' +
                 'AllowThink(other_path);'+

             /// четвертая встреча с темным мастером
             'IF(GetVar(first_meet) = 4, 13);'+
                 'ChangeVar(first_meet, 1);'+
                 'SetMonsterAsTarget();'+
                 'SetImage(31);'+
                 'SetParam(HP, 9999);'+
                 'SetParam(ATK, 100);'+
                 'SetParam(DEF, 0);'+
                 'SetName(RU,\"\");'+
                 'SetName(ENG,\"\");'+
                 'ChangeLootCount(essence,100);'+
                 'IF(GetLang() = ENG, 1);'+
                     'Log(danger,\"Sit where you are told, rat! Now you are my eternal prisoner! HA HA!\");' +
                 'IF(GetLang() = RU, 1);'+
                     'Log(danger,\"Сиди там, где тебе сказано, крыса! Теперь ты мой вечный пленник! ХА-ХА!\");' +


             // если первый раз пришли на этаж
             'IF(GetVar(FirstOnFloor) = 2, 17);'+

                 'IF(GetLang() = RU, 5);'+
                 'Log(normal,\"В ржавом сундуке между этажами нашлось немного золота. Так же, в сундуке лежит несколько смятых листов:\");'+
                 'Log(note,\"Темный Мастер охраняет свою башню днем и ночью, бродя по бесконечным этажам. Ни одна живая душа не избегнет его гнева и ярости его чудовищ.\");'+
                 'Log(note,\"Только я собрался навести порядок на этажах, проклятые монстры разбили сундук с инструментами и растащили их по этажам! Я знаю, что их науськал этот проклятый Икки.\");'+
                 'Log(note,\"О, горе! Я потерял свой дневник в кучах этого хлама! Годы накопленных знаний пропали! Даже не смотря на то, что он зашифрован, страшно представить каких бед он может принести в плохих руках... О, боги!..\");'+
                 'Log(normal,\" - Подождите. Какая башня, какой Темный мастер? Что я здесь делаю? Нужно как следует подумать об этом...\");'+

                 'IF(GetLang() = ENG, 5);'+
                 'Log(normal,\"There was some gold in a rusty chest between floors. Also, there are several crumpled sheets in the chest:\");'+
                 'Log(note,\"The Dark Master guards his tower day and night, roaming the endless floors. No living soul can escape his wrath and the fury of his monsters.\");'+
                 'Log(note,\"As soon as I was about to put things in order on the floors, the damn monsters smashed the chest with tools and took them to the floors! I know that damn Ikki got them going.\");'+
                 'Log(note,\"Oh woe! I lost my diary in a lot of this junk! Years of accumulated knowledge are gone! Even in spite of the fact that it is encrypted, it is scary to imagine what troubles it can bring in bad hands ... Oh, gods! ..\");'+
                 'Log(normal,\" - Wait. Which tower, which Dark master? What am I doing here? Think about it well...\");'+

                 'AllowMode(Think);'+
                 'AllowThink(wakeup);'+
                 'ChangePlayerItemCount(gold, Rand(100000));'+
                 'SetCurrTarget(3);'+
                 'SetVar(FirstOnFloor, 3);'+
        '",'+
        '3:"'+
             'BreakAuto(Tower);'+

             /// третья встреча с темным мастером
             'IF(GetVar(first_meet) = 3, 18);'+
                 'ChangeVar(first_meet, 1);'+
                 'SetMonsterAsTarget();'+
                 'SetImage(31);'+
                 'SetParam(HP, 9999);'+
                 'SetParam(ATK, 100);'+
                 'SetParam(DEF, 0);'+
                 'SetName(RU,\"\");'+
                 'SetName(ENG,\"\");'+
                 'ChangeLootCount(essence,100);'+
                 'IF(GetLang() = ENG, 3);'+
                     'Log(danger,\"Well then. I was finally convinced that you are here for a reason, since death has departed from you.\");' +
                     'Log(danger,\"I don''t know who you are and why you are here. Your mind is clear and I see that you yourself do not know this ... A pitiful attempt to deceive me!\");' +
                     'Log(danger,\"Since you are in my wonderful tower for a long time, rat, this is what rats are supposed to do, I will drive you to the basement forever! HA HA!\");' +
                 'IF(GetLang() = RU, 3);'+
                     'Log(danger,\"Ну что же. Я окончательно убедился, что ты здесь не просто так, раз смерть отступилась от тебя.\");' +
                     'Log(danger,\"Не знаю кто ты и зачем здесь. Твой разум чист и я вижу, что ты сам этого не знаешь... Ха! Жалкая попытка обмануть меня!\");' +
                     'Log(danger,\"Раз ты надолго в моей чудесной башне, крыса, то как и полагается крысам, я загоню тебя в подвал навечно! ХА-ХА!\");' +
                 'SetCurrTarget(2);'+

             /// первая встреча с икки
             'IF(GetVar(ikki) = 1, 21);'+
                 'SetCurrTarget(5);'+
                 'SetVar(ikki, 2);'+
                 'SetMonsterAsTarget();'+
                 'SetImage(33);'+
                 'SetParam(HP, 1);'+
                 'SetParam(ATK, 0);'+
                 'SetParam(DEF, 0);'+
                 'SetName(RU,\"\");'+
                 'SetName(ENG,\"\");'+
                 'IF(GetLang() = ENG, 5);'+
                     'Log(good,\"Hello stranger. Impressive! To go against the will of oneself ... it doesn''t matter ...\");' +
                     'Log(good,\"But you still need help. And allies in the Tower, as you know, are hard to find.\");' +
                     'Log(good,\"And if this someone else can help you remember whatever you want ...\");' +
                     'Log(good,\"Well, do you need friends?\");' +
                     'Log(good,\"Think about it. See you later, stranger ...\");' +
                 'IF(GetLang() = RU, 5);'+
                     'Log(good,\"Приветствую, незнакомец. Впечатляюще! Пойти поперек воли самого... неважно...\");' +
                     'Log(good,\"Но без помощи тебе все равно не обойтись. А союзников в Башне, как понимаешь, найти трудно.\");' +
                     'Log(good,\"А если еще этот кто-то может помочь тебе вспомнить все, что ты хочешь...\");' +
                     'Log(good,\"Ну как, тебе нужны друзья?\");' +
                     'Log(good,\"Ты пока подумай. Увидимся позднее, незнакомец....\");' +

             /// если первый визит на этаж
             'IF(GetVar(FirstOnFloor) = 3, 7);'+
               'IF(GetLang() = RU, 1);'+
               'Log(normal,\"В ржавом сундуке между этажами нашлось немного зелий.\");'+

               'IF(GetLang() = ENG, 1);'+
               'Log(normal,\"Some potions were found in a rusty chest between floors.\");'+

               'ChangePlayerItemCount(potionAuto, 10);'+
               'SetCurrTarget(4);'+
               'SetVar(FirstOnFloor, 4);'+
        '",'+
        '4:"'+
             'BreakAuto(Tower);'+

             /// вторая встреча с темным мастером
             'IF(GetVar(first_meet) = 2, 18);'+
                 'ChangeVar(first_meet, 1);'+
                 'SetMonsterAsTarget();'+
                 'SetImage(31);'+
                 'SetParam(HP, 9999);'+
                 'SetParam(ATK, 100);'+
                 'SetParam(DEF, 0);'+
                 'SetName(RU,\"\");'+
                 'SetName(ENG,\"\");'+
                 'ChangeLootCount(essence,100);'+
                 'IF(GetLang() = ENG, 3);'+
                     'Log(danger,\"What? You again? You are insignificant and I swat you like a fly, but are you still here ?!\");' +
                     'Log(danger,\"HA! It seems that sabotage is brewing here ...\");' +
                     'Log(danger,\"But it does not matter. You won''t go further, worm!\");' +
                 'IF(GetLang() = RU, 3);'+
                     'Log(danger,\"Что? Опять ты? Ты ничтожен и я прихлопнул тебя как муху, но ты все еще здесь?!\");' +
                     'Log(danger,\"ХА! Кажется, у нас тут назревает диверсия...\");' +
                     'Log(danger,\"Но это не имеет значения. Дальше ты не пройдешь, червь!\");' +
                 'SetCurrTarget(3);'+


             'IF(GetVar(FirstOnFloor) = 4, 11);'+
               'If(GetLang() = RU, 1);'+
               'Log(normal,\"Огромный сундк! Замок поддается не с первого раза...\");'+
               'If(GetLang() = ENG, 1);'+
               'Log(normal,\"You have found a huge chest! The lock does not give in the first time ...\");'+

               'ChangePlayerItemCount(GetRandItemName(), 1);'+
               'ChangePlayerItemCount(GetRandItemName(), 1);'+
               'ChangePlayerItemCount(GetRandItemName(), 1);'+
               'ChangePlayerItemCount(GetRandItemName(), 1);'+
               'ChangePlayerItemCount(GetRandItemName(), 1);'+

               'SetCurrTarget(5);'+
               'SetVar(FirstOnFloor, 5);'+
        '",'+
        '5:"'+
             'BreakAuto(Tower);'+

             /// первая встреча с темным мастером
             'IF(GetVar(first_meet) = 1, 17);'+
                 'ChangeVar(first_meet, 1);'+
                 'SetMonsterAsTarget();'+
                 'SetImage(31);'+
                 'SetParam(HP, 9999);'+
                 'SetParam(ATK, 100);'+
                 'SetParam(DEF, 0);'+
                 'SetName(RU,\"\");'+
                 'SetName(ENG,\"\");'+
                 'ChangeLootCount(essence,100);'+
                 'IF(GetLang() = ENG, 2);'+
                     'Log(danger,\"What are you doing in my Tower, insignificance!?\");' +
                     'Log(danger,\"I will DESTROY you!\");' +
                 'IF(GetLang() = RU, 2);'+
                     'Log(danger,\"Что ты делаешь в моей Башне, ничтожество!?\");' +
                     'Log(danger,\"Я УНИЧТОЖУ тебя!\");' +
                 'AllowThink(darkmaster);'+
                 'SetCurrTarget(4);'+


             // или просто переходим к следующему этажу
             'IF(GetVar(first_meet) = 7, 6);'+
                 'IF(GetLang() = ENG, 1);'+
                     'Log(normal,\"At the place of your meeting with the sorcerer, an indelible trace of energy remained.\");' +
                 'IF(GetLang() = RU, 1);'+
                     'Log(normal,\"На месте вашей встречи с кодуном остался неизгладимый энегетический след.\");' +
                'ChangePlayerLootCount(essence,10);'+
                 'SetCurrTarget(6);'+

        '",'+
        '6:"'+
             'BreakAuto(Tower);'+

             /// вторая встреча с темным мастером
             'IF(GetVar(first_meet) = 7, 20);'+
                 'ChangeVar(first_meet, 1);'+
                 'SetMonsterAsTarget();'+
                 'SetImage(31);'+
                 'SetParam(HP, 99999);'+
                 'SetParam(ATK, 200);'+
                 'SetParam(DEF, 0);'+
                 'SetName(RU,\"\");'+
                 'SetName(ENG,\"\");'+
                 'ChangeLootCount(essence,200);'+
                 'IF(GetLang() = ENG, 4);'+
                     'Log(danger,\"So-so. The rat got out of the basement. You start to ANNOY me!\");' +
                     'Log(danger,\"The games are over! I don’t know how to get rid of you yet, but I’m quite capable of locking you up here on the lower floors.\");' +
                     'Log(danger,\"Perhaps, when I am bored, I will come to see you. After all, I now have a new pet.\");' +
                     'Log(danger,\"See you, rat! HA HA!\");' +
                 'IF(GetLang() = RU, 4);'+
                     'Log(danger,\"Так-так. Крыса выбралась из подвала. Ты начинаешь меня РАЗДРАЖАТЬ!\");' +
                     'Log(danger,\"Игры закончились! Я пока не знаю как от тебя избавиться, но вполне способен запереть тебя здесь, на нижних этажах.\");' +
                     'Log(danger,\"Возможно, когда мне будет скучно, буду приходить тебя проведать. Ведь у меня теперь есть новый питомец.\");' +
                     'Log(danger,\"До встречи, крыса! ХА-ХА!\");' +
                'SetCurrTarget(7);'+

             /// вторая встреча с икки
             'IF(GetVar(ikki) = 4, 23);'+
                 'SetCurrTarget(7);'+
                 'SetMonsterAsTarget();'+
                 'SetImage(33);'+
                 'SetParam(HP, 1);'+
                 'SetParam(ATK, 0);'+
                 'SetParam(DEF, 0);'+
                 'SetName(RU,\"\");'+
                 'SetName(ENG,\"\");'+

                 'SetPlayerAsTarget();'+
                 'IF(GetItemCount(permanentMDEF) < 100, 4);'+
                 'IF(GetLang() = ENG, 1);'+
                     'Log(good,\"Nice to see you again! Have you forgotten that I need 100 ICON_MDEFGET?\");' +
                 'IF(GetLang() = RU, 1);'+
                     'Log(good,\"Рад снова тебя видеть! Ты не забыл, что мне нужны 100 ICON_MDEFGET?\");' +

                 'IF(GetItemCount(permanentMDEF) >= 100, 8);'+
                 'ChangeItemCount(permanentMDEF, -100);'+
                 'SetVar(ikki, 5);'+
                 'IF(GetLang() = ENG, 2);'+
                     'Log(good,\"Wonderful! Exactly what is needed. Now I can weaken the magic barrier.\");' +
                     'Log(good,\"But remember that this only works once. Good luck!\");' +
                 'IF(GetLang() = RU, 2);'+
                     'Log(good,\"Замечательно! То, что нужно. Теперь я смогу ослабить магический барьер.\");' +
                     'Log(good,\"Но помни, что это стработает только один раз. Удачи\");' +

             /// вторая встреча с икки
             'IF(GetVar(ikki) = 3, 21);'+
                 'SetCurrTarget(7);'+
                 'SetVar(ikki, 4);'+
                 'SetMonsterAsTarget();'+
                 'SetImage(33);'+
                 'SetParam(HP, 1);'+
                 'SetParam(ATK, 0);'+
                 'SetParam(DEF, 0);'+
                 'SetName(RU,\"\");'+
                 'SetName(ENG,\"\");'+
                 'IF(GetLang() = ENG, 5);'+
                     'Log(good,\"So we met again, stranger.\");' +
                     'Log(good,\"You got into an argument with ... Hmm ...\");' +
                     'Log(good,\"The magic barrier is powerful, but when you have friends, many problems are easier to solve.\");' +
                     'Log(good,\"And since we are friends, I will help you. Come back when you have 100 ICON_MDEFGET\");' +
                     'Log(good,\"See you!\");' +
                 'IF(GetLang() = RU, 5);'+
                     'Log(good,\"Вот мы и встретились снова, незнакомец.\");' +
                     'Log(good,\"Ты снова повздорил с... Хм...\");' +
                     'Log(good,\"Магический барьер - сильная штука, но когда у тебя есть друзья, многие проблемы решаются легче.\");' +
                     'Log(good,\"А раз уж мы друзья, я помогу тебе. Возвращайся, когда у тебя будет 100 ICON_MDEFGET\");' +
                     'Log(good,\"До встречи!\");'
        +'",'+
        '7:"'+
             'BreakAuto(Tower);'+

             'IF(GetVar(first_meet) = 8, 11);'+ // первая встреча с барьером
                 'SetCurrTarget(6);'+
                 'SetMonsterAsTarget();'+
                 'SetImage(34);'+
                 'SetParam(HP, 5000);'+
                 'SetParam(ATK, 1000);'+
                 'SetParam(DEF, 1000);'+
                 'SetParam(MDEF, 1000);'+
                 'SetName(RU,\"Магический барьер\");'+
                 'SetName(ENG,\"Magic barrier\");'+

                 'IF(GetVar(ikki) = 2, 1);'+     // если пришли сюда до встречи с икки
                 'SetVar(ikki, 3);'+            // продвигаем истрию с Икки, чтобы встретить его еще раз

             'IF(GetVar(ikki) = 5, 11);'+        // разовая акция от Икки-ослабление барьера
                 'SetCurrTarget(8);'+
                 'SetVar(ikki, 6);'+
                 'SetMonsterAsTarget();'+
                 'SetImage(34);'+
                 'SetParam(HP, 3000);'+
                 'SetParam(ATK, 100);'+
                 'SetParam(DEF, 0);'+
                 'SetParam(MDEF, 0);'+
                 'SetName(RU,\"Магический барьер\");'+
                 'SetName(ENG,\"Magic barrier\");' +

         '",'+
        '8:"'+
             'BreakAuto(Tower);'+

             /// первый входна этаж
             'IF(GetVar(first_meet, 8), 16);'+
               'SetCurrTarget(99);'+
               'SetVar(first_meet, 9);'+
               'ChangePlayerItemCount(gold, 100000);'+
               'ChangePlayerItemCount(gold, 100000);'+
               'ChangePlayerItemCount(gold, 100000);'+
               'ChangePlayerItemCount(gold, 100000);'+
               'ChangePlayerItemCount(gold, 100000);'+
               'ChangePlayerItemCount(gold, 100000);'+
               'ChangePlayerItemCount(gold, 100000);'+
               'ChangePlayerItemCount(gold, 100000);'+
               'ChangePlayerItemCount(gold, 100000);'+
               'ChangePlayerItemCount(gold, 100000);'+
               'IF(GetLang() = RU, 1);'+
                 'Log(good,\"Огромные кучи золота на полу!\");'+
               'IF(GetLang() = ENG, 1);'+
                 'Log(good,\"Huge piles of gold on the floor!\");'

        +'",'+
        '99:"'+
             'BreakAuto(Tower);'+
             'SetMonsterAsTarget();'+
             'SetImage(33);'+
             'SetParam(HP, 1);'+
             'SetParam(ATK, 0);'+
             'SetParam(DEF, 0);'+
             'SetName(RU,\"\");'+
             'SetName(ENG,\"\");'+
             'IF(GetLang() = RU, 1);'+
               'Log(good,\"Это конец, друг!..\");'+
             'IF(GetLang() = ENG, 1);'+
               'Log(good,\"This is the end, friend! ..\");'+
             'SetCurrTarget(2);'
        +'",'+
    '},';

var
   data:ISuperObject;

function FloorTargets: ISuperObject;
begin
    if not Assigned(data) then data := SO(data_str);

    result := data;
end;

end.
