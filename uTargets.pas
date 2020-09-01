unit uTargets;

interface

type
    TTarget = record
        level: integer;
        script: string;
    end;

var
    /// ������ ��������� ��������� ���� ��� ���������� ������������� �������.
    /// ������ ����, ���� �������� �������� ����� �� ���������
    targets: array [0..7] of TTarget = (
        (level: 1;
         script:
             'ChangePlayerItemCount(Gold, 100000);'+
             'AddEvent(..................);'+

//             'IF({GetLang() = RU}, 14);'+
             'AddEvent(    ����� ������� 100 000 ������);'+
             'AddEvent( );'+
             'AddEvent("���!");'+
             'AddEvent("���� ������������� �������� ������� ��������� ������ ���������� ������� � ��������� ��� ��������� �������� �� ���� �������.");'+
             'AddEvent("����������, �� ������ ������, ����������� ��������� � ����� �������.");'+
             'AddEvent("��������� ��� ��������� ��������, �� ��� � �� ����� ��� ������. �� ����� ������ �� ���� ���� �� ����.");'+
             'AddEvent( );'+
             'AddEvent("��� �� ������ �����. ������ ����� ������ �� ����. ����, ��� ������ �� ���� � ����� � ������ �� �������, '+
                 '�� ��� ���� ���������� �������. ������� ��� ��� �������. � ��� �� �� ����������� � �����, �����: ����� ����� �����! ������ �� � ����� ������� �� ����, �� � ����� ���������� ����� �����. �����, ��� ����!");'+
             'AddEvent( );'+
             'AddEvent("� ������ ����� ������� �� � ������ ���������� �����:");'+
             'AddEvent("����������� ��� ����� �������������� ��������� ��������� ������� � ������������ � ���� ��������.");'+
             'AddEvent("���� �����������. ������ ������ ������ �� ������. � ������� ���� ������ ��������� �������� ������ � ���������, ������� ������� �����.");'+
             'AddEvent("������� �����������, �� ���������, ��� ���������� � �����-�� ������� ������ ���������, ���������� ��������� ������.");'+
             'AddEvent("� ������ �������, ������ ��������� �� �������� ������.");'+
             'AddEvent("�� ���������� ����� � ��������� �� �������� ����.");'+

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
             'AddEvent(    ����� ������� GetVar(gold) ������);'+
             'AddEvent(    �������� ����� ��������!);'+
             'AddEvent( );'+
             'AddEvent("������� ��� ������� �������� �� ����!");'+
             'AddEvent("���������. ����� �����, ����� ������ ������? ��� � ����� �����?");'+
             'AddEvent( );'+
             'AddEvent("�, ����! � ������� ���� ������� � ����� ����� �����! ���� ����������� ������ �������! ���� �� ������ �� ��, ��� �� ����������, ������� ����������� ����� ��� �� ����� �������� � ������ �����... �, ����!..");'+
             'AddEvent( );'+
             'AddEvent("������ � �������� ������� ������� �� ������, ��������� ������� ������� ������ � ������������� � ��������� �� �� ������! � ����, ��� �� �������� ���� ��������� ����, ����������� ������� �������.");'+
             'AddEvent( );'+
             'AddEvent("������ ������ �������� ���� ����� ���� � �����, ����� �� ����������� ������. �� ���� ����� ���� �� �������� ��� ����� � ������ ��� �������.");'+
             'AddEvent( );'+
             'AddEvent("��� ��, � ������� ����� ��������� ������ ������:");'+
             'AddEvent(� ������ ������� ����� ������� ������� ������� ������.);'+

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
             'AddEvent(����� ������� GetVar(count) ����� AutoAction);'+
             'AddEvent(� ������ ������� ����� ������� ������� ������� �����.);'+

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
             'AddEvent(����� ������� GetVar(iName)!);'+
             'If({GetLang() = ENG}, 1);'+
             'AddEvent(Player get GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If({GetLang() = RU}, 1);'+
             'AddEvent(����� ������� GetVar(iName)!);'+
             'If({GetLang() = ENG}, 1);'+
             'AddEvent(Player get GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If({GetLang() = RU}, 1);'+
             'AddEvent(����� ������� GetVar(iName)!);'+
             'If({GetLang() = ENG}, 1);'+
             'AddEvent(Player get GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If({GetLang() = RU}, 1);'+
             'AddEvent(����� ������� GetVar(iName)!);'+
             'If({GetLang() = ENG}, 1);'+
             'AddEvent(Player get GetVar(iName)!);'+

             'SetVar(iName, GetRandItemName());'+
             'ChangePlayerItemCount(GetVar(iName), 1);'+
             'If({GetLang() = RU}, 1);'+
             'AddEvent(����� ������� GetVar(iName)!);'+
             'If({GetLang() = ENG}, 1);'+
             'AddEvent(Player get GetVar(iName)!);'+

             'AddEvent( );'+

             'If({GetLang() = RU}, 1);'+
             'AddEvent(�� ����� �������� �����! ����� ��������� �� � ������� ����...);'+
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
             'SetVar(DarkMaster, ������ ������);'+
             'AddEvent(" - �� �� ��������!");' +
             'AddEvent(" - ��� �� ������� � ���� �����, �����������!?");' +
             'SetCreatureScript(OnDeath,"SetBreak(Tower);AddEvent(..................);AddEvent(- �� ������� ����!? �� ����� ����! ��� �� �����!?);AddEvent(..................);AllowTool(Sword);SetNextTarget();");'+

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
             'SetVar(DarkMaster,���� ������ ������);'+
             'AddEvent(" - ��� ���� ��������� �������, �����! �� �� ������� �� ���� �����!");' +
             'SetCreatureScript(OnDeath,"AddEvent(..................);AddEvent(- �� ������� ����!? �� ����� ����! ��� �� �����!?);AddEvent(..................);SetNextTarget();");'+

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
             'SetVar(DarkMaster,�������� ������ ������);'+
             'AddEvent(" - �� �������� � ��� �����, ������� ��������, ��������� �������. �� ��� �� ����� ����� �����!?");' +
             'AddEvent(" - ��� ������ ����� ���� ��������� �������!");' +
             'SetCreatureScript(OnDeath,"AddEvent(..................);AddEvent(- �� ������� ����!? �� ����� ����! ��� �� �����!?);AddEvent(..................);SetNextTarget();");'+

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
             'AddEvent(!!! ���������� !!!);' +
             'AddEvent(!!! �� ������ ���� !!!);' +
             'AddEvent(..................);'+

             'CurrentLevel(1);InitCreatures();'
        )
    );

implementation

end.
