unit uThinkModeData;

interface

type
   TThink = record
     name: string;
     enable: integer;
     caption: string;
     exp: integer;
     script: string;
   end;

var
/// n(ame) - ���������� ���, ������������ ���������
/// e(nable) - �������, �������� �� ��� ������ ��� ��� (1/0)
/// RU - ��� ��� ���������� �� �������
/// ENG - ��� ��� ���������� �� ����������
/// exp - ��� exp=0 ������� �� ������������ � ���������� � ����������� ������
/// script - ������ ��� ���������� ����������� (��� exp=0)
arrThinks : array [0..14] of TThink =(
(name: 'WhoIAm'; enable: 1; caption: 'RU="��� �?",ENG="Who am I?"'; exp: 100; script:
  'AddThinkEvent(............................................................);'+
  'IF({GetLang() = RU}, 1);'+
  'AddThinkEvent("��� �������. �� �����, �� ��������. ������ ������� � �������� ����, ����� � ������� ���-�� ���������...");'+
  'IF({GetLang() = ENG}, 1);'+
  'AddThinkEvent("How strange. No name, no past. Only emptiness and headache when I try to remember something...");'+
  'OpenThink(OverPain);'
),
  (name: 'OverPain'; enable: 0; caption: 'RU="��������� ����� ����",ENG="Remember through pain"'; exp: 500; script:
    'AddThinkEvent(............................................................);'+
    'IF({GetLang() = RU}, 7);'+
    'AddThinkEvent("    ����� ������� 500 �����!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("������, ����� ������� ������������, ������ � ����... ����-�����...");'+
    'AddThinkEvent("������, ���� �������� ������ ������ � ������ ���������� ��� �� ������������. �� ��� �������� � �������. � ����?");'+
    'AddThinkEvent("� �������, �������, �������...");'+
    'AddThinkEvent("���� ��� �������� �� ���������, �����-�� ����������, ����������. ������ ����� �������?");'+
    'AddThinkEvent("� �� �����, �� ��������, ��� ����� � ���� ����. ����? � ���� ������ ����� � �������� ���� ��������� �����, �� ������� ��� ������!");'+
    'IF({GetLang() = ENG}, 7);'+
    'AddThinkEvent("    Player got 500 EXP!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("It looks like i need to relax a little, come to your senses ... Inhale, exhale ...");'+
    'AddThinkEvent("However, hands confidently hold the weapon and seem to remember how to use it. But they are used to something else. For what?");'+
    'AddThinkEvent("And monsters, monsters, monsters...");'+
    'AddThinkEvent("This world looks not real, somehow fake, ghostly. Why is this feeling?");'+
    'AddThinkEvent("I do not remember, but I feel like a stranger in this world. The world? I can only see the insides and stairs of this damned Tower, from which there is no exit!");'+
    'OpenThink(OldSkills);'+
    'OpenThink(FakeWorld);'+
    'OpenThink(SomeRest);'+
    'ChangePlayerParam(EXP, 500);'
  ),
    (name: 'OldSkills'; enable: 0; caption: 'RU="������ ������",ENG="Old skills"'; exp: 300; script:
      'AddThinkEvent(............................................................);'+
      'IF({GetLang() = RU}, 4);'+
      'AddThinkEvent("     ����� ������� 5000 �����!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("�� ������ ���� ������ ��� ������ ������ ������. � � ��� � ���������� ����. ��! ����� ������ ���������... ��� ���! �����, ��������, ������...");'+
      'AddThinkEvent("��! ���� ������! �� ��� ������ ������ ����. ���-�� ���������� ����. ������, �������, ������������!...");'+
      'IF({GetLang() = ENG}, 4);'+
      'AddThinkEvent("     Player got 5000 EXP!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("But now there is only this crude rusty weapon. And I know how to handle him. Yes! You just need to move ... That is it! Easy, free, smooth ...");'+
      'AddThinkEvent("Yes! Hands remember! This is not the crude iron of the sword. Something completely different. Light, dangerous, deadly! ...");'+
      'ChangePlayerParam(EXP, 5000);'
    ),
    (name: 'SomeRest'; enable: 0; caption: 'RU=���������,ENG=Respite'; exp: 1000; script:
      'AddThinkEvent(............................................................);'+
      'IF({GetLang() = RU}, 5);'+
      'AddThinkEvent("     ����� ������� 5000 ������������!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("�� ����!");'+
      'AddThinkEvent("�� �������� ������ �������, ��� ����������� � ���, ��� ���������� � ����� ����� �� ���� �����.");'+
      'AddThinkEvent("����� �������� ��������� ������������ ����������� � �������.");'+
      'IF({GetLang() = ENG}, 5);'+
      'AddThinkEvent("     Player got 5000 auto actions!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("Get down to business!");'+
      'AddThinkEvent("There is nothing left to do but to deal with what is happening and find a way out of this tower.");'+
      'AddThinkEvent("After a short meditation, calmness and clarity return.");'+
      'ChangeAutoATK(5000);'
    ),
    (name: 'FakeWorld'; enable: 0; caption: 'RU="���������� ���",ENG="Fake world"'; exp: 500; script:
      'AddThinkEvent(............................................................);'+
      'IF({GetLang() = RU}, 4);'+
      'AddThinkEvent("    ����� ������� ������ � ������ ��������!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("������, ����� ������� ��������� �������� � ������������. ������, ����� � ������� ������������ ����, � ���� ���������� �� ��� ��� ������� � ������� ��� ������� ���������!");'+
      'AddThinkEvent("��, ���, ����������, ��� ������� � ����������, �� ��� �������� ���?..");'+
      'IF({GetLang() = ENG}, 4);'+
      'AddThinkEvent("    Player got access to Secrets mode!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("However, any illusion lends itself to study and exposure. Now, when I realize the illusion of the world, I can penetrate into all its secrets and see all the hidden mechanisms!");'+
      'AddThinkEvent("Yes, this is undoubtedly a world of illusion and guidance, but how to leave it?..");'+
      'AllowMode(Secrets, 1);'
    ),

(name: 'WhereIAm'; enable: 1; caption: 'RU="��� �?",ENG="Where I am?"'; exp: 100; script:
  'AddThinkEvent(............................................................);'+
  'IF({GetLang() = RU}, 2);'+
  'AddThinkEvent("����� ��������� ������� ���������� ����������.");'+
  'AddThinkEvent("������� ����. ��� �����-�� �������� ����� � ������������ ���������� ����� � ��������� �� ������ �����.");'+
  'IF({GetLang() = ENG}, 2);'+
  'AddThinkEvent("It is worthwhile to study the environment in more detail.");'+
  'AddThinkEvent("No ideas. This is some kind of huge tower with endless stairs and monsters on each floor.");'+
  'OpenThink(Tower);'+
  'OpenThink(Floors);'+
  'OpenThink(Monsters);'+
  'OpenThink(DarkMaser);'
),
  (name: 'Tower'; enable: 0; caption: 'RU="�����?",ENG="Tower?"'; exp: 300; script:
    'AddThinkEvent(............................................................);'+
    'IF({GetLang() = RU}, 6);'+
    'AddThinkEvent("    ����� ������� 100 �����!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("���������� ����, �� �������� �� ��� ������?");'+
    'AddThinkEvent("� ���� ��� ��������� ����������, ��� ������� ����� ���� �� ����� ���� �������� � �������� ������� ��������...");'+
    'AddThinkEvent("� ��, ��� �������������� ��� �����, �� ����� ���� - �������. �������, �������� ���-�� �� ������ ���� � ������.");'+
    'AddThinkEvent("���� ���� ��� �� ����� ���� ����������, ���� � ��� ����� ���� �� ������ ��� �������.");'+
    'IF({GetLang() = ENG}, 6);'+
    'AddThinkEvent("    Player got 100 EXP!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("An interesting idea, but is it correct?");'+
    'AddThinkEvent("And these worlds are so different that the transition between them cannot be real and have clear laws...");'+
    'AddThinkEvent("And what is perceived as a tower is actually a transition. A tunnel made by a cam from one world to another.");'+
    'AddThinkEvent("If this world is really ghostly, things in it may not be what they seem.");'+
    'ChangePlayerParam(EXP, 100);'
  ),
  (name: 'DarkMaser'; enable: 0; caption: 'RU="������ ������",ENG="Dark Master"'; exp: 300; script:
    'AddThinkEvent(............................................................);'+
    'IF({GetLang() = RU}, 4);'+
    'AddThinkEvent("    ����� ������� 100 �����!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("�� �����, ��� ��������� � ��� ������������, �� � �������� ��� ����������� ����������. ����� ���������� ������. ��������, �������� ���������, ��� ������� ��� �������� ����� �������� ����������.");'+
    'AddThinkEvent("������ ������, ���� �� �����, �������� �������� � ���������� ���� �����.");'+
    'IF({GetLang() = ENG}, 6);'+
    'AddThinkEvent("    Player got 100 EXP!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("I do not think that it will be possible to come to an agreement with him, but it is almost impossible to defeat him. We need to continue looking. Perhaps there is a hint on how to defeat or deceive this dangerous foe.");'+
    'AddThinkEvent("The Dark Master appears to be the owner and guardian of this Tower.");'+
    'ChangePlayerParam(EXP, 100);'
  ),
  (name: 'Floors'; enable: 0; caption: 'RU="�����",ENG="Floors"'; exp: 300; script:
    'AddThinkEvent(............................................................);'+
    'IF({GetLang() = RU}, 6);'+
    'AddThinkEvent("    ����� ������� 100 �����!");'+
    'AddThinkEvent("    ������� ������ � ������ �����!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("����� ��������� ����������� ������ ����!");'+
    'AddThinkEvent("�� ���� �����, ��� �� ��� �������� ����� ����������, ����� ������� ���������.");'+
    'AddThinkEvent("��� ���� ����, ��� �� ���������� � ������� ����� ���������. �� ����� ������ �� ������ ���� ��������� ��������. ��������� �� ��� �������, �� ��������� ���� �������. ��������, ��������� � ��� ���-��.");'+
    'IF({GetLang() = ENG}, 6);'+
    'AddThinkEvent("    Player got 100 EXP!");'+
    'AddThinkEvent("    Player got access to Floors mode!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("I need to explore each floor in more detail!");'+
    'AddThinkEvent("But there is an idea that these sites can be equipped to relax a little.");'+
    'AddThinkEvent("The higher the floor, the more spacious and dense it is filled with monsters. But in front of each entrance there is a small area. Some of them are empty, some have chests. Perhaps something else will come across.");'+
    'ChangePlayerParam(EXP, 100);'+
    'AllowMode(Floors, 1);'+
    'OpenThink(Exit);'
  ),
    (name: 'Exit'; enable: 0; caption: 'RU="�����?",ENG="Exit?"'; exp: 500; script:
      'AddThinkEvent(............................................................);'+
      'IF({GetLang() = RU}, 4);'+
      'AddThinkEvent("    ����� �������� ����������� ������ �����!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("� �����, ��� ����� ������� ��������, ������ ����� ���������� �������� �� ������ �����?");'+
      'AddThinkEvent("� ��� �� ����� ����� �� ����� ����� ��� ���� ������. ����� ��� ���� �� ������� ������? ��� ��� ������? ���������, ��������� ������ �����? ����� ��������� �� ������� � ��������� ������?");'+
      'IF({GetLang() = ENG}, 4);'+
      'AddThinkEvent("    The player has expanded the capabilities of the Floors mode!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("Or maybe there are a lot of hidden passages here, I just need to do a good search on each floor?");'+
      'AddThinkEvent("I have not seen a single door or window out here yet. Maybe they are on the upper floors? Or not at all? Wondering how strong the walls are? Maybe it will be possible to break through them and get out?");'+
      ''
//      'AllowMode(Floors, 2);'
    ),
  (name: 'Monsters'; enable: 0; caption: 'RU="�������",ENG="Monsters"'; exp: 300; script:
    'AddThinkEvent(............................................................);'+
    'IF({GetLang() = RU}, 4);'+
    'AddThinkEvent("    ����� ������� 100 �����!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("� ������ ������, ��� ����� ��� ��� ���-�� ������������. ����� ������� ��� �������� ���������!");'+
    'AddThinkEvent("� ������ ������ ��� ����� ��� ������� � �������! �� �� ��������� ���������� ������ ����� ��������, � �� �������� ������� ���� ������ �����!");'+
    'IF({GetLang() = ENG}, 4);'+
    'AddThinkEvent("    Player got 100 EXP!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("I am just sure I can use it all somehow. You need to study these subjects in more detail!");'+
    'AddThinkEvent("With each floor, these creatures are getting stronger and more dangerous! But from some it turns out to get certain objects, and from the most powerful potions even fall!");'+
    'ChangePlayerParam(EXP, 100);'+
    'AllowMode(Craft, 1);'+
    'OpenThink(Resources);'+
    'OpenThink(Potions);'
  ),
    (name: 'Resources'; enable: 0; caption: 'RU="�������",ENG="Resources"'; exp: 800; script:
      'AddThinkEvent(............................................................);'+
      'IF({GetLang() = RU}, 6);'+
      'AddThinkEvent("    ����� ������� 200 �����!");'+
      'AddThinkEvent("    ����� ������� ����������� ����������� �������!");'+
      'AddThinkEvent("    ����� ������� ������ � ������ �������!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("����� ����� ������, ��� ����� ��������� ������ �� ����������, �������� �������������������� � ������.");'+
      'AddThinkEvent("� �������� ������ ��� ��� �����, ������� ������ �� ��������. ��� ������������� ����� ������������ ��� ����� �������!");'+
      'IF({GetLang() = ENG}, 6);'+
      'AddThinkEvent("    Player got 200 EXP!");'+
      'AddThinkEvent("    The player got the opportunity to research resources!");'+
      'AddThinkEvent("    The player has gained access to the Craft mode!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("To understand exactly how each of the materials can be applied, you will have to experiment with each.");'+
      'AddThinkEvent("I have studied in detail all these things that fall from monsters. It can really be used for a lot!");'+
      'ChangePlayerParam(EXP, 200);'+
      'AllowMode(ResResearch, 1);'
    ),
    (name: 'Potions'; enable: 0; caption: 'RU="�����",ENG="Potions"'; exp: 1200; script:
      'AddThinkEvent(............................................................);'+
      'IF({GetLang() = RU}, 5);'+
      'AddThinkEvent("    ����� ������� 400 �����!");'+
      'AddThinkEvent("    ����� ������� ����������� ����������� �����!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("��� ���� ���������� �� �������� �������? �������� ��������� ������ �� ���� ��� ������� � ���������?");'+
      'AddThinkEvent("�����, ���������� �� ����� ������� �������� - ������ �������, �� �� ��� ����!");'+
      'IF({GetLang() = ENG}, 5);'+
      'AddThinkEvent("    Player got 400 EXP!");'+
      'AddThinkEvent("    The player got the opportunity to research potions!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("What if you try to study them in detail? Perhaps you can understand what they are made of and repeat?");'+
      'AddThinkEvent("Potions dropped from especially powerful monsters are extremely useful, but there are so few of them!");'+
      'AllowMode(PotionResearch, 2);'+
      'ChangePlayerParam(EXP, 400);'
    ),
(name: 'Diary'; enable: 0; caption: 'RU="�������",ENG="Diary"'; exp: 500; script:
  'ChangePlayerParam(EXP, 400);'+
  'AddThinkEvent(............................................................);'+
  'IF({GetLang() = RU}, 6);'+
  'AddThinkEvent("    ����� ������� 1000 �����!");'+
  'AddThinkEvent( );'+
  'AddThinkEvent("�� ��� ������� ��������, ��� ������������ � ��� ���������� ����� ������ �������.");'+
  'AddThinkEvent("������ �������� ������� �������� � ������, ��� �� ������ �������� ������������ ���� ���� � �������� ��������������� �� �� �����������.");'+
  'AddThinkEvent("�������� �������� �����-�� �����, �������, ������. �� ��� ��� �����������.");'+
  'AddThinkEvent("��� �������� ������ ��� �������. ��� ��� ����� � � ��� ��� ��������������, ������� ������.");'+
  'IF({GetLang() = ENG}, 6);'+
  'AddThinkEvent("    Player got 1000 EXP!");'+
  'AddThinkEvent( );'+
  'AddThinkEvent("But there is no doubt that the information they contain will be extremely useful.");'+
  'AddThinkEvent("A long study of the pages leads to the conclusion that each page uses its own cipher and will have to decrypt them separately.");'+
  'AddThinkEvent("Pages contain some kind of diagrams, drawings, notes. But they are all encrypted.");'+
  'AddThinkEvent("This is a voluminous journal or diary. Who is its author and what is its purpose is difficult to say.");'+
  'OpenThink(Page1);'+
{  'OpenThink(Page2);'+
  'OpenThink(Page3);'+
  'OpenThink(Page4);'+
  'OpenThink(Page5);'+
  'OpenThink(Page6);'+
  'OpenThink(Page7);'+
  'OpenThink(Page8);'+
  'OpenThink(Page9);'+
  'OpenThink(Page10);'+
  'OpenThink(Page11);'+
  'OpenThink(Page12);'+
  'OpenThink(Page13);'+
  'OpenThink(Page14);'+
  'OpenThink(Page15);'+
  'OpenThink(Page16);'+
  'OpenThink(Page17);'+
  'OpenThink(Page18);'+
  'OpenThink(Page19);'+
  'OpenThink(Page20);'+
  'OpenThink(Page21);'+
  'OpenThink(Page22);'+
  'OpenThink(Page23);'
}
  ''
),
  (name: 'Page1'; enable: 0; caption: 'RU="�������: 1 ���.",ENG="Diary: 1 page"'; exp: 2000; script:
    'AddThinkEvent(............................................................);'+
    'IF({GetLang() = RU}, 8);'+
    'AddThinkEvent("    ����� ������� 1000 �����!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("������ �� �������� ����� ������ ��������. � ����� ���� ���� ������ �������� ����!");'+
    'AddThinkEvent("����� � ������ ���, ��� ����� � �����, �� ����������, �������� � ��������. ��� ������ ��������� �� ������ ����, �� ����� �����������������, ������� ���-�� ������ ����.");'+
    'AddThinkEvent("�� ������ ������������ � ��� ������� �����, ����� ������� � ���� ����� � ������� �� ��� - ������ ������. ������, ��� ������ ����������� � �������� ������������. ���� �� ������������� ��� ������� - �� ������� ������ ��������� �������.");'+
    'AddThinkEvent("����� ���� ������� ������ ����� ����������, ������ � �����������.");'+
    'AddThinkEvent("����������� ����, ����������! ���� �� ������� ��� ������, ������ ��� ������ ���������. �, ��������, ������ �� ��� �������� �� ���� ����.");'+
    'AddThinkEvent("������ ������� ������, �������� ����");'+
    'IF({GetLang() = ENG}, 8);'+
    'AddThinkEvent("    Player got 1000 EXP!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("Hear the wisdom of your fallen teachers. And may your foot find the true Path!");'+
    'AddThinkEvent("Here I have described everything I have learned about the Tower, its treasures, monsters and secrets. This knowledge has been accumulated not only by me, but by my predecessors, who were also looking for the Path.");'+
    'AddThinkEvent("But the knowledge contained in it is too valuable to fall into the hands of the enemy, '+
        'and the main one is the Dark Master. Therefore, all texts are encrypted and protected by spells. If you are really my presenter, you will find a way to read the diary.");'+
    'AddThinkEvent("Then this diary will become your help, friend and mentor.");'+
    'AddThinkEvent("Greetings stranger! If you are reading these lines, then my mission has failed. And, perhaps, you are my successor on this Path.");'+
    'AddThinkEvent("Personal diary of Olond, the seeker of the Path");'+
    'ChangePlayerParam(EXP, 1000);'
  )
);
{
(name: ''; enable: 0; caption: 'RU="",ENG=""'; exp: 0; script:
),
}
implementation

end.
