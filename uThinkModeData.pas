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
arrThinks : array [0..5] of TThink =(
(name: 'WhoIAm'; enable: 1; caption: 'RU="��� �?",ENG="Who am I?"'; exp: 10; script:
  'AddThinkEvent(............................................................);'+
  'IF({GetLang() = RU}, 1);'+
  'AddThinkEvent("��� �������. �� �����, �� ��������. ������ ������� � �������� ����, ����� � ������� ���-�� ���������...");'+
  'IF({GetLang() = ENG}, 1);'+
  'AddThinkEvent("How strange. No name, no past. Only emptiness and headache when I try to remember something...");'+
  'OpenThink(OverPain);'
),
  (name: 'OverPain'; enable: 0; caption: 'RU="����� ����",ENG="Through pain"'; exp: 20; script:
    'AddThinkEvent(............................................................);'+
    'IF({GetLang() = RU}, 5);'+
    'AddThinkEvent("������, ����� ������� ������������, ������ � ����... ����-�����...");'+
    'AddThinkEvent("������, ���� �������� ������ ������ � ������ ���������� ��� �� ������������. �� ��� �������� � �������. � ����?");'+
    'AddThinkEvent("� �������, �������, �������...");'+
    'AddThinkEvent("���� ��� �������� �� ���������, �����-�� ����������, ����������. ������ ����� �������?");'+
    'AddThinkEvent("� �� �����, �� ��������, ��� ����� � ���� ����. ����? � ���� ������ ����� � �������� ���� ��������� �����, �� ������� ��� ������!");'+
    'IF({GetLang() = ENG}, 5);'+
    'AddThinkEvent("It looks like i need to relax a little, come to your senses ... Inhale, exhale ...");'+
    'AddThinkEvent("However, hands confidently hold the weapon and seem to remember how to use it. But they are used to something else. For what?");'+
    'AddThinkEvent("And monsters, monsters, monsters...");'+
    'AddThinkEvent("This world looks not real, somehow fake, ghostly. Why is this feeling?");'+
    'AddThinkEvent("I do not remember, but I feel like a stranger in this world. The world? I can only see the insides and stairs of this damned Tower, from which there is no exit!");'+
    'OpenThink(OldSkills);'+
    'OpenThink(FakeWorld);'+
    'OpenThink(SomeRest);'
  ),
    (name: 'OldSkills'; enable: 0; caption: 'RU="������ ������",ENG="Old skills"'; exp: 30; script:
      'AddThinkEvent(............................................................);'+
      'IF({GetLang() = RU}, 3);'+
      'AddThinkEvent("����� ������� 10000 �����!");'+
      'AddThinkEvent("�� ������ ���� ������ ��� ������ ������ ������. � � ��� � ���������� ����. ��! ����� ������ ���������... ��� ���! �����, ��������, ������...");'+
      'AddThinkEvent("��! ���� ������! �� ��� ������ ������ ����. ���-�� ���������� ����. ������, �������, ������������!...");'+
      'IF({GetLang() = ENG}, 3);'+
      'AddThinkEvent("Player got 10000 EXP!");'+
      'AddThinkEvent("But now there is only this crude rusty weapon. And I know how to handle him. Yes! You just need to move ... That is it! Easy, free, smooth ...");'+
      'AddThinkEvent("Yes! Hands remember! This is not the crude iron of the sword. Something completely different. Light, dangerous, deadly! ...");'+
      'ChangePlayerAttr(EXP, 10000);'
    ),
    (name: 'SomeRest'; enable: 0; caption: 'RU=���������,ENG=Respite'; exp: 10; script:
      'AddThinkEvent(............................................................);'+
      'IF({GetLang() = RU}, 4);'+
      'AddThinkEvent(">>> ����� ������� 10000 ������������! <<<");'+
      'AddThinkEvent("�� ����!");'+
      'AddThinkEvent("�� �������� ������ �������, ��� ����������� � ���, ��� ���������� � ����� ����� �� ���� �����.");'+
      'AddThinkEvent("����� �������� ��������� ������������ ����������� � �������.");'+
      'IF({GetLang() = ENG}, 4);'+
      'AddThinkEvent(">>> Player got 10000 auto actions! <<<");'+
      'AddThinkEvent("Get down to business!");'+
      'AddThinkEvent("There is nothing left to do but to deal with what is happening and find a way out of this tower.");'+
      'AddThinkEvent("After a short meditation, calmness and clarity return.");'+
      'ChangeAutoATK(10000);'
    ),
    (name: 'FakeWorld'; enable: 0; caption: 'RU="���������� ���",ENG="Fake world"'; exp: 500; script:
      'IF({GetLang() = RU}, 2);'+
      'AddThinkEvent("");'+
      'IF({GetLang() = ENG}, 2);'+
      'AddThinkEvent("");'+
      'OpenThink();'
    ),

(name: 'WhereIAm'; enable: 1; caption: 'RU="��� �?",ENG="Where I am?"'; exp: 100; script:
    'IF({GetLang() = RU}, 10);'+
    'AddThinkEvent();'+
    'IF({GetLang() = ENG}, 10);'+
    'AddThinkEvent();'
)
);
{
(name: ''; enable: 0; caption: 'RU="",ENG=""'; exp: 0; script:
),
}
implementation

end.
