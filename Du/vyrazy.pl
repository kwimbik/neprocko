%vlozOperatory(+L, -H, -V) Given list L, create expression with value of H.
vlozOperatory([], [], []).
vlozOperatory(L, H, E) :-  cet(L, V), writeexp(V, E), ev(V, H). 

%cet(+X, -Y) creates all possible postfix expressions from list
cet([X], X).
cet([X1, X2], Y) :- (Y = plus(X1, X2); Y = minus(X1, X2); Y = krat(X1, X2); Y = deleno(X1, X2)).
cet(X, Y) :- length(X,K3), K3 > 2, 
(Y = plus(R1, R2),   append(X1, X2, X),  length(X1,K1), length(X2, K2), K1 >0, K2 > 0, cet(X1, R1), cet(X2, R2);
Y =  minus(R1, R2),  append(X1, X2, X),  length(X1,K1), length(X2, K2), K1 >0, K2 > 0, cet(X1, R1), cet(X2, R2);
Y =  krat(R1, R2),   append(X1, X2, X),  length(X1,K1), length(X2, K2), K1 >0, K2 > 0, cet(X1, R1), cet(X2, R2);
Y =  deleno(R1, R2), append(X1, X2, X),  length(X1,K1), length(X2, K2), K1 >0, K2 > 0, cet(X1, R1), cet(X2, R2)).

%del(+X1, +X2, -Y) Division
del(X1,X2, Y) :- not(X2 is 0), Y is X1 // X2.
del(_,_, 0).

%ev(+X, -Y) evaluates expression in postfix
ev(X, X) :- integer(X).
ev(X, Y) :- X = plus(X1, X2),   ev(X1, R1), ev(X2, R2), Y is R1 + R2.
ev(X, Y) :- X = minus(X1, X2),  ev(X1, R1), ev(X2, R2), Y is R1 - R2.
ev(X, Y) :- X = krat(X1, X2),   ev(X1, R1), ev(X2, R2), Y is R1 * R2.
ev(X, Y) :- X = deleno(X1, X2), ev(X1, R1), ev(X2, R2), del(R1, R2, Y).

%writeexp(+X, -Y) create infix expression from postfix
writeexp(X, X) :- integer(X).
writeexp(X, Y) :- X = plus(X1, X2), Y = (Y1 + Y2),   writeexp(X1, Y1), writeexp(X2, Y2).
writeexp(X, Y) :- X = minus(X1, X2), Y = (Y1 - Y2),  writeexp(X1, Y1), writeexp(X2, Y2).
writeexp(X, Y) :- X = krat(X1, X2), Y = (Y1 * Y2),   writeexp(X1, Y1), writeexp(X2, Y2).
writeexp(X, Y) :- X = deleno(X1, X2), Y = (Y1 / Y2), writeexp(X1, Y1), writeexp(X2, Y2).