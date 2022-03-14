% cviceni s rezem

prvek(X, [X|_]).
prvek(X, [_|Xs]) :- prvek(X,Xs).

prvek_det(X, [X|_]) :- !.
prvek_det(X, [_|Xs]) :- prvek_det(X,Xs).

%rezovy max. Zastavi hledani, nehleda dalsi vysledky
max(X,Y,X) :- X >= Y,! .
max(X,Y,Y) :- X < Y.

%sjednoceni pomoci rezu
sjednoceni([],Ys,Ys).
sjednoceni([X|Xs],Ys,Zs):-
 member(X,Ys),!,
 sjednoceni(Xs,Ys,Zs).
sjednoceni([X|Xs],Ys,[X|Zs]):-
 sjednoceni(Xs,Ys,Zs).
%
muz(kain).
muz(abel).
muz(adam).



%maplist\2
maplist(_,[]).
maplist(P,[X|Xs]):- call(P,X),
 maplist(P,Xs).

%priklad folfd reverse. Jinak Foldl se rekurzivne vola postupnena vsechny prvky listu a vysledek predzhociho vypoctu. s
seznam(X,Xs,[X|Xs]). % vytvoří seznam
obrat(Xs,Ys):- foldl(seznam,Xs,[],Ys).

pricti1(_, [], 1) :- !.
pricti1(_, Y, Z):- Z is Y + 1.
delka(X,Y) :- foldl(pricti1,X,[],Y).