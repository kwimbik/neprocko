muz(honza). 
muz(adam).
muz(david).
muz(jiri).

% Stejnym zpusobem dalsi klauzule rikaji, ze `jitka`, `jana` a `lida` jsou zeny.

zena(jitka).
zena(jana).
zena(lida).

% Klauzule mohou mit i vice nez jeden parametr. Nasledujici klauzule vyjadruje, 
% ze `honza` je potomek `adam`a. Podobne pro dalsi klauzule.

%potomek(X, Y)
%X je potomek Y
potomek(honza, adam).
potomek(adam, david).
potomek(jiri, adam).

potomek(jitka, adam).
potomek(jitka, jana).

pokus(X, Y) :- zena(X), zena(Y), X \== Y.

% Pravidla, ktera plati mezi jednotlivymi klauzulemi, se daji napsat pomoci 
% klauzuli s telem. Napriklad fakt, ze kdyz je `X` potomek `Y`, a zaroven je 
% `X` zena, tak `X` je dcera `Y`. V logice bychom to mohli zapsat jako `zena(X) 
% & potomek(X,Y) -> dcera(X,Y)`. V Prologu napiseme to same, jen pomoci 
% prologovske syntaxe, tedy:

dcera(X,Y):-zena(X),potomek(X,Y).
syn(X,Y):-muz(X),potomek(X,Y).

% adam \== eva true, pokud se nerovnaji