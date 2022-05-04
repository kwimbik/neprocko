%2 4 3
%5 1 7
%. 6 8
% = [2,4,3,5,1,7,0,6,8]
% tvaru l/r/u/d

%pro testy
%test" [1,2,3,4,5,6,7,0,8]
vyresStd(X,S):-vyres(X,[1,2,3,4,5,6,7,8,0],S).

%vyres(+X,+Y,-S) která řeší Lloydovu osmičku X, tj. najde posloupnost kroků S takovou, že při jejich aplikování na X dostaneme Y.
%spodni hranici potrebnych tahu odhaduji jako Man. metriku / 2, protoze pri jednom posunu muzeme zlepsit celkovou pozici max o 2
vyres(X, Y, S):- heur(X,1,V), vyres(X,Y,S,V/2).
vyres(X, Y, S, N):-nkroku(X, Y, S, N), !.
vyres(X, Y, S, N):-N1 is N + 1, N1 < 32,   
                    vyres(X, Y, S, N1).

%nkroku(+X, +Y, -S, +N) vrati posloupnost S, pokud na N tahu najde presun z X do Y
nkroku(X, Y, S, N):- nkroku(X, Y, S, N, [], []). 
nkroku(X, X, B, 0, _, B) :- !.
nkroku(X,Y, S, N, A, B):- heur(X,1,V), V1 is V/2, N - V1 >=0, tah(X, T, NT), %pouzivam orezavani pomoci man. metriky a stejny odhad, jako na zacatku
                                    \+member(NT, A),
                                    N1 is N - 1, 
                                    append(B, [T], C), nkroku(NT, Y, S, N1, [NT|A], C ).


%tah (+X, +T, -Y) kde X je osmicka, T je typ tahu a Y je vysledna osmicka
tah(X, T, Y) :- T = r, posunDoprava(X,[], Y).
tah(X, T, Y) :- T = l, posunDoleva(X,[], Y).
tah(X, T, Y) :- T = u, posunNahoru(X,[], Y).
tah(X, T, Y) :- T = d, posunDolu(X,[], Y).


%nevyuzita optimalizace
%bestMove(+X, -Y, -Z, +U1, -U2) kde X je osmicka, Y je typ tahu a Z je osmicka po dokonceni, U1 je mnozina pouzitych tahu a U2 nova mnozina pouzitych tahu
%bestMove(X, Y, Z, U1, U2) :- tah(X, r, P1), tah(X, l, P2),tah(X, u, P3),tah(X, d, P4),
%                     ((member(P1, U1), H1 is 100, !); heur(P1 , 1 , H1)),
%                     ((member(P2, U1), H2 is 100, !); heur(P2 , 1 , H2)),
%                     ((member(P3, U1), H3 is 100, !); heur(P3 , 1 , H3)),
%                     ((member(P4, U1), H4 is 100, !); heur(P4 , 1 , H4)),
%                     minim([H1, H2, H3, H4], MIN),
%                    ((MIN = H1, Z = P1, Y = r, append(U1,[P1], U2));
%                    (MIN = H2, Z = P2, Y = l, append(U1,[P2], U2));
%                    (MIN = H3, Z = P3, Y = u, append(U1,[P3], U2));
%                    (MIN = H4, Z = P4, Y = d , append(U1,[P4], U2))).

%posunDoprava(+X,-T, -Y) posune 0 doprava v listu, kde T je temp promenna
posunDoprava([0],T, T1) :- reverse([0|T], T1).
posunDoprava([0,Z|X],T, Y) :- length(T,R),((2 is mod(R,3), reverse(T, T1), append(T1,[0,Z|X], Y ),!);  append(TL1, [Z,0|X], Y), reverse(T, TL1), !).
posunDoprava([Z|X],T,Y) :-  posunDoprava(X,[Z|T], Y).

%posunDoleva(+X,-T, -Y) posune 0 doleva v listu, kde T je temp promenna
posunDoleva([0|X], [], [0|X]).
posunDoleva([Z,0|X],T, Y) :- length(T, R),((2 is mod(R,3), reverse(T, T1), append(T1,[Z,0|X],Y),!); append(TL1, [0,Z|X], Y), reverse(T, TL1), !).
posunDoleva([Z|X],T,Y) :-  posunDoleva(X,[Z|T], Y).


%posunNahoru(+X,-T, -Y) posune 0 nahoru v listu, kde T je temp promenna
posunNahoru([Z|X],T,Y) :-  posunNahoru(X,[Z|T], Y), Z \= 0.
posunNahoru([0|X],T, Y) :- length(T, R), ((R < 3, reverse(T, T1), append(T1, [0|X], Y),!); append([T1, T2, T3], TLS1, T), append([T1, T2, 0], TLS1, TLS2), reverse(TLS2, TLS), append(TLS, [T3|X], Y)).

%posunDolu(+X,-T, -Y) posune 0 dolu v listu, kde T je temp promenna
posunDolu([Z|X],T,Y) :-  posunDolu(X,[Z|T], Y), Z \= 0.
posunDolu([0|X],T, Y) :- length(X, R), ((R < 3), reverse(T, T1), append(T1, [0|X], Y),  !); (append([T1, T2, T3], TX1, X), append([T1, T2, 0], TX1, TX), reverse(T, TL), append(TL, [T3|TX], Y)).

%heur(+X,1, -Y) secte hodnotu pozice Y na boardu X, cim mensi, tim lepsi.
heur([], _, 0).
heur([X|Xs], I, Y) :- I2 is I + 1, map(I, [A1, A2]), map(X, [B1, B2]), heur(Xs, I2, Ys), Y is Ys + abs(A1 - B1) + abs(A2 - B2).
heur(X, 9, Y) :- map(9, [A1, A2]), map(X, [B1, B2]), Y is abs(A1 - B1) + abs(A2 - B2), !.

%map(+X, -Y) kde X je cislo hry a Y je jeho pozice na mrizce (kvuli jednoduchosti pocitani manhattansky normy, protoze jsem linej vymyslet sofistikovanejsi zpusob)
map(1,[1,1]).
map(2,[1,2]).
map(3,[1,3]).
map(4,[2,1]).
map(5,[2,2]).
map(6,[2,3]).
map(7,[3,1]).
map(8,[3,2]).
map(9,[3,3]).
map(0,[3,3]).

%minim(+X, -Y) kde X jsou promenne a Y jejich minimum
minim([X1, X2, X3, X4], Y) :- A is min(X1, X2), B is min(X3, X4), Y is min(A, B).



