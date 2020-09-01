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
/// n(ame) - внутреннее имя, используется скриптами
/// e(nable) - признак, доступна ли эта запись или нет (1/0)
/// RU - имя для интерфейса на русском
/// ENG - имя для интерфейса на английском
/// exp - при exp=0 элемент не отображается в интерфейсе и выполняется скрипт
/// script - скрипт при завершении обдумывания (при exp=0)
arrThinks : array [0..14] of TThink =(
(name: 'WhoIAm'; enable: 1; caption: 'RU="Кто я?",ENG="Who am I?"'; exp: 100; script:
  'AddThinkEvent(............................................................);'+
  'IF({GetLang() = RU}, 1);'+
  'AddThinkEvent("Как странно. Ни имени, ни прошлого. Только пустота и головная боль, когда я пытаюсь что-то вспомнить...");'+
  'IF({GetLang() = ENG}, 1);'+
  'AddThinkEvent("How strange. No name, no past. Only emptiness and headache when I try to remember something...");'+
  'OpenThink(OverPain);'
),
  (name: 'OverPain'; enable: 0; caption: 'RU="Вспомнить через боль",ENG="Remember through pain"'; exp: 500; script:
    'AddThinkEvent(............................................................);'+
    'IF({GetLang() = RU}, 7);'+
    'AddThinkEvent("    Игрок получил 500 опыта!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("Похоже, нужно немного расслабиться, придти в себя... Вдох-выдох...");'+
    'AddThinkEvent("Однако, руки уверенно держат оружие и словно вспоминают как им пользоваться. Но они привыкли к другому. К чему?");'+
    'AddThinkEvent("И монстры, монстры, монстры...");'+
    'AddThinkEvent("Этот мир выглядит не настоящим, каким-то поддельным, призрачным. Отчего такое чувство?");'+
    'AddThinkEvent("Я не помню, но чувствую, что чужак в этом мире. Мире? Я вижу только нутро и лестницы этой проклятой Башни, из которой нет выхода!");'+
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
    (name: 'OldSkills'; enable: 0; caption: 'RU="Старые навыки",ENG="Old skills"'; exp: 300; script:
      'AddThinkEvent(............................................................);'+
      'IF({GetLang() = RU}, 4);'+
      'AddThinkEvent("     Игрок получил 5000 опыта!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("Но сейчас есть только это грубое ржавое оружие. И с ним я обращаться умею. Да! Нужно просто двигаться... Вот так! Легко, свободно, плавно...");'+
      'AddThinkEvent("Да! Руки помнят! Не это грубое железо меча. Что-то совершенно иное. Легкое, опасное, смертоносное!...");'+
      'IF({GetLang() = ENG}, 4);'+
      'AddThinkEvent("     Player got 5000 EXP!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("But now there is only this crude rusty weapon. And I know how to handle him. Yes! You just need to move ... That is it! Easy, free, smooth ...");'+
      'AddThinkEvent("Yes! Hands remember! This is not the crude iron of the sword. Something completely different. Light, dangerous, deadly! ...");'+
      'ChangePlayerParam(EXP, 5000);'
    ),
    (name: 'SomeRest'; enable: 0; caption: 'RU=Передышка,ENG=Respite'; exp: 1000; script:
      'AddThinkEvent(............................................................);'+
      'IF({GetLang() = RU}, 5);'+
      'AddThinkEvent("     Игрок получил 5000 автодействий!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("За дело!");'+
      'AddThinkEvent("Не остается ничего другого, как разобраться с тем, что происходит и найти выход из этой башни.");'+
      'AddThinkEvent("После короткой медитации возвращается спокойствие и ясность.");'+
      'IF({GetLang() = ENG}, 5);'+
      'AddThinkEvent("     Player got 5000 auto actions!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("Get down to business!");'+
      'AddThinkEvent("There is nothing left to do but to deal with what is happening and find a way out of this tower.");'+
      'AddThinkEvent("After a short meditation, calmness and clarity return.");'+
      'ChangeAutoATK(5000);'
    ),
    (name: 'FakeWorld'; enable: 0; caption: 'RU="Поддельный мир",ENG="Fake world"'; exp: 500; script:
      'AddThinkEvent(............................................................);'+
      'IF({GetLang() = RU}, 4);'+
      'AddThinkEvent("    Игрок получил доступ к режиму Секретов!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("Однако, любая иллюзия поддается изучению и разоблачению. Теперь, когда я осознаю призрачность мира, я могу проникнуть во все его секреты и увидеть все скрытые механизмы!");'+
      'AddThinkEvent("Да, это, несомненно, мир иллюзий и навождений, но как покинуть его?..");'+
      'IF({GetLang() = ENG}, 4);'+
      'AddThinkEvent("    Player got access to Secrets mode!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("However, any illusion lends itself to study and exposure. Now, when I realize the illusion of the world, I can penetrate into all its secrets and see all the hidden mechanisms!");'+
      'AddThinkEvent("Yes, this is undoubtedly a world of illusion and guidance, but how to leave it?..");'+
      'AllowMode(Secrets, 1);'
    ),

(name: 'WhereIAm'; enable: 1; caption: 'RU="Где я?",ENG="Where I am?"'; exp: 100; script:
  'AddThinkEvent(............................................................);'+
  'IF({GetLang() = RU}, 2);'+
  'AddThinkEvent("Стоит подробнее изучить окружающую обстановку.");'+
  'AddThinkEvent("Никаких идей. Это какая-то огромная башня с бесконечными лестницами вверх и монстрами на каждом этаже.");'+
  'IF({GetLang() = ENG}, 2);'+
  'AddThinkEvent("It is worthwhile to study the environment in more detail.");'+
  'AddThinkEvent("No ideas. This is some kind of huge tower with endless stairs and monsters on each floor.");'+
  'OpenThink(Tower);'+
  'OpenThink(Floors);'+
  'OpenThink(Monsters);'+
  'OpenThink(DarkMaser);'
),
  (name: 'Tower'; enable: 0; caption: 'RU="Башня?",ENG="Tower?"'; exp: 300; script:
    'AddThinkEvent(............................................................);'+
    'IF({GetLang() = RU}, 6);'+
    'AddThinkEvent("    Игрок получил 100 опыта!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("Интересная идея, но является ли она верной?");'+
    'AddThinkEvent("И миры эти настолько отличаются, что переход между ними не может быть реальным и обладать четкими законами...");'+
    'AddThinkEvent("И то, что воспринимается как башня, на самом деле - переход. Тоннель, пробитый кам-то из одного мира в другой.");'+
    'AddThinkEvent("Если этот мир на самом деле призрачный, вещи в нем могут быть не такими как кажутся.");'+
    'IF({GetLang() = ENG}, 6);'+
    'AddThinkEvent("    Player got 100 EXP!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("An interesting idea, but is it correct?");'+
    'AddThinkEvent("And these worlds are so different that the transition between them cannot be real and have clear laws...");'+
    'AddThinkEvent("And what is perceived as a tower is actually a transition. A tunnel made by a cam from one world to another.");'+
    'AddThinkEvent("If this world is really ghostly, things in it may not be what they seem.");'+
    'ChangePlayerParam(EXP, 100);'
  ),
  (name: 'DarkMaser'; enable: 0; caption: 'RU="Темный Мастер",ENG="Dark Master"'; exp: 300; script:
    'AddThinkEvent(............................................................);'+
    'IF({GetLang() = RU}, 4);'+
    'AddThinkEvent("    Игрок получил 100 опыта!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("Не думаю, что получится с ним договориться, но и победить его практически невозможно. Нужно продолжить поиски. Возможно, найдется подсказка, как одолеть или обмануть этого опасного противника.");'+
    'AddThinkEvent("Темный Мастер, судя по всему, является хозяином и хранителем этой Башни.");'+
    'IF({GetLang() = ENG}, 6);'+
    'AddThinkEvent("    Player got 100 EXP!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("I do not think that it will be possible to come to an agreement with him, but it is almost impossible to defeat him. We need to continue looking. Perhaps there is a hint on how to defeat or deceive this dangerous foe.");'+
    'AddThinkEvent("The Dark Master appears to be the owner and guardian of this Tower.");'+
    'ChangePlayerParam(EXP, 100);'
  ),
  (name: 'Floors'; enable: 0; caption: 'RU="Этажи",ENG="Floors"'; exp: 300; script:
    'AddThinkEvent(............................................................);'+
    'IF({GetLang() = RU}, 6);'+
    'AddThinkEvent("    Игрок получил 100 опыта!");'+
    'AddThinkEvent("    Получил доступ к режиму Этажи!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("Нужно подробнее исследовать каждый этаж!");'+
    'AddThinkEvent("Но есть мысль, что на эти площадки можно обустроить, чтобы немного отдохнуть.");'+
    'AddThinkEvent("Чем выше этаж, тем он просторнее и плотнее забит монстрами. Но перед входом на каждый есть небольшая площадка. Некоторые из них пустуют, на некоторых есть сундуки. Возможно, попадется и еще что-то.");'+
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
    (name: 'Exit'; enable: 0; caption: 'RU="Выход?",ENG="Exit?"'; exp: 500; script:
      'AddThinkEvent(............................................................);'+
      'IF({GetLang() = RU}, 4);'+
      'AddThinkEvent("    Игрок расширил возможности режима Этажи!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("А может, тут полно скрытых проходов, просто нужно хорошенько поискать на каждом этаже?");'+
      'AddThinkEvent("Я еще не видел здесь ни одной двери или окна наружу. Может они есть на верхних этажах? Или нет совсем? Интересно, насколько крепки стены? Может получится их пробить и выбраться наружу?");'+
      'IF({GetLang() = ENG}, 4);'+
      'AddThinkEvent("    The player has expanded the capabilities of the Floors mode!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("Or maybe there are a lot of hidden passages here, I just need to do a good search on each floor?");'+
      'AddThinkEvent("I have not seen a single door or window out here yet. Maybe they are on the upper floors? Or not at all? Wondering how strong the walls are? Maybe it will be possible to break through them and get out?");'+
      ''
//      'AllowMode(Floors, 2);'
    ),
  (name: 'Monsters'; enable: 0; caption: 'RU="Монстры",ENG="Monsters"'; exp: 300; script:
    'AddThinkEvent(............................................................);'+
    'IF({GetLang() = RU}, 4);'+
    'AddThinkEvent("    Игрок получил 100 опыта!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("Я просто уверен, что смогу все это как-то использовать. Нужно изучить эти предметы подробнее!");'+
    'AddThinkEvent("С каждым этажом эти твари все сильнее и опаснее! Но из некоторых получается добыть некие предметы, а из наиболее сильных даже падают зелья!");'+
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
    (name: 'Resources'; enable: 0; caption: 'RU="Ресурсы",ENG="Resources"'; exp: 800; script:
      'AddThinkEvent(............................................................);'+
      'IF({GetLang() = RU}, 6);'+
      'AddThinkEvent("    Игрок получил 200 опыта!");'+
      'AddThinkEvent("    Игрок получил возможность исследовать ресурсы!");'+
      'AddThinkEvent("    Игрок получил доступ к режиму Ремесла!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("Чтобы точно понять, как можно применить каждый из материалов, придется поэкспериментировать с каждым.");'+
      'AddThinkEvent("Я подробно изучил все эти штуки, которые падают из монстров. Это действительно можно использовать для очень многого!");'+
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
    (name: 'Potions'; enable: 0; caption: 'RU="Зелья",ENG="Potions"'; exp: 1200; script:
      'AddThinkEvent(............................................................);'+
      'IF({GetLang() = RU}, 5);'+
      'AddThinkEvent("    Игрок получил 400 опыта!");'+
      'AddThinkEvent("    Игрок получил возможность исследовать зелья!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("Что если попытаться их подробно изучить? Возможно получится понять из чего они сделаны и повторить?");'+
      'AddThinkEvent("Зелья, выпадающие из особо сильных монстров - крайне полезны, но их так мало!");'+
      'IF({GetLang() = ENG}, 5);'+
      'AddThinkEvent("    Player got 400 EXP!");'+
      'AddThinkEvent("    The player got the opportunity to research potions!");'+
      'AddThinkEvent( );'+
      'AddThinkEvent("What if you try to study them in detail? Perhaps you can understand what they are made of and repeat?");'+
      'AddThinkEvent("Potions dropped from especially powerful monsters are extremely useful, but there are so few of them!");'+
      'AllowMode(PotionResearch, 2);'+
      'ChangePlayerParam(EXP, 400);'
    ),
(name: 'Diary'; enable: 0; caption: 'RU="Дневник",ENG="Diary"'; exp: 500; script:
  'ChangePlayerParam(EXP, 400);'+
  'AddThinkEvent(............................................................);'+
  'IF({GetLang() = RU}, 6);'+
  'AddThinkEvent("    Игрок получил 1000 опыта!");'+
  'AddThinkEvent( );'+
  'AddThinkEvent("Но нет никаких сомнений, что содержащаяся в них информация будет крайне полезна.");'+
  'AddThinkEvent("Долгое изучение страниц приводит к выводу, что на каждой странице используется свой шифр и придется расшифровывапть их по отдельности.");'+
  'AddThinkEvent("Страницы содержат какие-то схемы, рисунки, записи. Но все они зашифрованы.");'+
  'AddThinkEvent("Это объемный журнал или дневник. Кто его автор и в чем его предназначение, сказать трудно.");'+
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
  (name: 'Page1'; enable: 0; caption: 'RU="Дневник: 1 стр.",ENG="Diary: 1 page"'; exp: 2000; script:
    'AddThinkEvent(............................................................);'+
    'IF({GetLang() = RU}, 8);'+
    'AddThinkEvent("    Игрок получил 1000 опыта!");'+
    'AddThinkEvent( );'+
    'AddThinkEvent("Внемли же мудрости твоих павших учителей. И пусть нога твоя отыщет истинный Путь!");'+
    'AddThinkEvent("Здесь я описал все, что узнал о Башне, ее сокровищах, монстрах и секретах. Эти знания накоплены не только мной, но моими предшественниками, которые так-же искали Путь.");'+
    'AddThinkEvent("Но знания содержащиеся в нем слишком ценны, чтобы попасть в руки врага и главный из них - Темный Мастер. Потому, все тексты зашифрованы и защищены заклинаниями. Если ты действительно мой премник - ты найдешь способ прочитать дневник.");'+
    'AddThinkEvent("Тогда этот дневник станет твоим подспорьем, другом и наставником.");'+
    'AddThinkEvent("Приветствую тебя, незнакомец! Если ты читаешь эти строки, значит моя миссия провалена. И, возможно, именно ты мой приемник на этом Пути.");'+
    'AddThinkEvent("Личный дневник Олонда, искателя Пути");'+
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
