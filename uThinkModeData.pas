unit uThinkModeData;

interface

var

/// n(ame) - внутреннее имя, используется скриптами
/// e(nable) - признак, доступна ли эта запись или нет (1/0)
/// RU - имя для интерфейса на русском
/// ENG - имя для интерфейса на английском
/// exp - при exp=0 элемент не отображается в интерфейсе и выполняется скрипт
/// script - скрипт при завершении обдумывания (при exp=0)
arrThinks : array [0..9] of string =(

'n=WhoIAm,e=1,RU="Кто я?",ENG="Who am I?",exp=10,script="'+
    'IF({GetLang() = RU}, 1);'+
    'AddThinkEvent("Как странно. Ни имени, ни прошлого. Только пустота и головная боль, когда я пытаюсь что-то вспомнить...");'+
    'IF({GetLang() = ENG)}, 1);'+
    'AddThinkEvent("How strange. No name, no past. Only emptiness and headache when I try to remember something...");'+
    'OpenThink(OverPain);'+
'"',
    'n=OverPain,e=0,RU="Через боль",ENG="Through pain",exp=200,script="'+
        'IF({GetLang() = RU}, 5);'+
        'AddThinkEvent("Похоже, нужно немного расслабиться, придти в себя... Вдох-выдох...");'+
        'AddThinkEvent("Однако, руки уверенно держат оружие и словно вспоминают как им пользоваться. Но они привыкли к другому. К чему?");'+
        'AddThinkEvent("И монстры, монстры, монстры...");'+
        'AddThinkEvent("Этот мир выглядит не настоящим, каким-то поддельным, призрачным. Отчего такое чувство?");'+
        'AddThinkEvent("Я не помню, но чувствую, что чужак в этом мире. Мире? Я вижу только нутро и лестницы этой проклятой Башни, из которой нет выхода!");'+
        'IF({GetLang() = ENG)}, 5);'+
        'AddThinkEvent("It looks like i need to relax a little, come to your senses ... Inhale, exhale ...");'+
        'AddThinkEvent("However, hands confidently hold the weapon and seem to remember how to use it. But they are used to something else. For what?");'+
        'AddThinkEvent("And monsters, monsters, monsters...");'+
        'AddThinkEvent("This world looks not real, somehow fake, ghostly. Why is this feeling?");'+
        'AddThinkEvent("I do not remember, but I feel like a stranger in this world. The world? I can only see the insides and stairs of this damned Tower, from which there is no exit!");'+
        'OpenThink(OldSkills);'+
        'OpenThink(FakeWorld);'+
        'OpenThink(SomeRest);'+
    '"',
        'n=OldSkills,e=0,RU="Старые навыки",ENG="Old skills",exp=300,script="'+
            'IF({GetLang() = RU}, 3);'+
            'AddThinkEvent("Игрок получил 10000 опыта!");'+
            'AddThinkEvent("Но сейчас есть только это грубое ржавое оружие. И с ним я обращаться умею. Да! Нужно просто двигаться... Вот так! Легко, свободно, плавно...");'+
            'AddThinkEvent("Да! Руки помнят! Не это грубое железо меча. Что-то совершенно иное. Легкое, опасное, смертоносное!...");'+
            'IF({GetLang() = ENG)}, 3);'+
            'AddThinkEvent("Player got 10000 EXP!");'+
            'AddThinkEvent("But now there is only this crude rusty weapon. And I know how to handle him. Yes! You just need to move ... That is it! Easy, free, smooth ...");'+
            'AddThinkEvent("Yes! Hands remember! This is not the crude iron of the sword. Something completely different. Light, dangerous, deadly! ...");'+
            'ChangePlayerAttr(EXP, 10000);'+
        '"',
        'n=SomeRest,e=0,RU=Передышка,ENG=Respite,exp=1000,script="'+
            'IF({GetLang() = RU}, 4);'+
            'AddThinkEvent("Игрок получил 10000 автодействий!");'+
            'AddThinkEvent("За дело!");'+
            'AddThinkEvent("Не остается ничего другого, как разобраться с тем, что происходит и найти выход из этой башни.");'+
            'AddThinkEvent("После короткой медитации возвращается спокойствие и ясность.");'+
            'IF({GetLang() = ENG)}, 2);'+
            'AddThinkEvent("Player got 10000 auto actions!");'+
            'AddThinkEvent("Get down to business!");'+
            'AddThinkEvent("There is nothing left to do but to deal with what is happening and find a way out of this tower.");'+
            'AddThinkEvent("After a short meditation, calmness and clarity return.");'+
            'ChangeAutoATK(10000);'+
        '"',
        'n=FakeWorld,e=0,RU="Поддельный мир",ENG="Fake world",exp=500,script="'+
            'IF({GetLang() = RU}, 2);'+
            'AddThinkEvent("");'+
            'IF({GetLang() = ENG)}, 2);'+
            'AddThinkEvent("");'+
            'OpenThink();'+
        '"',

'n=WhereIAm,e=1,RU="Где я?",ENG="Where I am?",exp=100,script="'+
    'IF({GetLang() = RU}, 10);'+
    'AddThinkEvent();'+
    'IF({GetLang() = ENG)}, 10);'+
    'AddThinkEvent();'+
'"',
'n=,e=0,RU=,ENG=,exp=,script=""',
'n=,e=0,RU=,ENG=,exp=,script=""',
'n=,e=0,RU=,ENG=,exp=,script=""',
'n=,e=0,RU=,ENG=,exp=,script=""'
);

implementation

end.
