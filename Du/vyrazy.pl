%vlozOperatory(+L, -H, -V) kde L je list cisel, H je hodnota vysledneho vyrazu a V je vyraz s kombinaci operatoru
vlozOperatory([], [], []).
vlozOperatory(L, H, E) :-  cet(L, V), writeexp(V, E), ev(V, H). 

cet([X], X).
cet([X1, X2], Y) :- (Y = plus(X1, X2); Y = minus(X1, X2); Y = krat(X1, X2); Y = deleno(X1, X2)).
cet(X, Y) :- length(X,K3), K3 > 2, (Y = plus(R1, R2), append(X1, X2, X), length(X1,K1), length(X2, K2), K1 >0, K2 > 0, cet(X1, R1), cet(X2, R2); Y = minus(R1, R2),append(X1, X2, X),length(X1,K1), length(X2, K2), K1 >0, K2 > 0, cet(X1, R1), cet(X2, R2); Y = krat(R1, R2), append(X1, X2, X),length(X1,K1), length(X2, K2), K1 >0, K2 > 0, cet(X1, R1), cet(X2, R2); Y = deleno(R1, R2), append(X1, X2, X),length(X1,K1), length(X2, K2), K1 >0, K2 > 0, cet(X1, R1), cet(X2, R2)).


%eval(+Expr, -Value)
eval([], []).
eval(X, Y) :- X = plus(X1, X2),(integer(X1),integer(X2), Y is X1 + X2;integer(X1),\+ integer(X2), eval(X2, Y2), Y is X1 + Y2;\+ integer(X1),integer(X2), eval(X1, Y1), Y is Y1 + X2;eval(X1, Y1), eval(X2, Y2), Y is Y1 + Y2).
eval(X, Y) :- X = minus(X1, X2),
(integer(X1),integer(X2), Y is X1 - X2;
integer(X1),\+ integer(X2), eval(X2, Y2), Y is X1 - Y2;
\+ integer(X1),integer(X2), eval(X1, Y1), Y is Y1 - X2;
eval(X1, Y1), eval(X2, Y2), Y is Y1 - Y2).

eval(X, Y) :- X = krat(X1, X2),
(integer(X1),integer(X2), Y is X1 * X2;
integer(X1),\+ integer(X2), eval(X2, Y2), Y is X1 * Y2;
\+ integer(X1),integer(X2), eval(X1, Y1), Y is X2 * Y1;
eval(X1, Y1), eval(X2, Y2), Y is Y1 * Y2).

eval(X, Y) :- X = deleno(X1, X2), 
(integer(X1),integer(X2), del(X1,X2, Y);
integer(X1),\+ integer(X2), eval(X2, Y2), del(X1,Y2, Y);
\+ integer(X1),integer(X2), eval(X1, Y1), del(Y1,X2, Y);
eval(X1, Y1), eval(X2, Y2), del(Y1,Y2, Y)).

del(X1,X2, Y) :- not(X2 is 0), Y is X1 // X2.
del(_,_, 0).


ev(X, X) :- integer(X).
ev(X, Y) :- X = plus(X1, X2), ev(X1, R1), ev(X2, R2), Y is R1 + R2.
ev(X, Y) :- X = minus(X1, X2),  ev(X1, R1), ev(X2, R2), Y is R1 - R2.
ev(X, Y) :- X = krat(X1, X2), ev(X1, R1), ev(X2, R2), Y is R1 * R2.
ev(X, Y) :- X = deleno(X1, X2), ev(X1, R1), ev(X2, R2), del(R1, R2, Y).



%create expression from postfix
writeexp(X, X) :- integer(X).
writeexp(X, Y) :- X = plus(X1, X2), Y = (Y1 + Y2), writeexp(X1, Y1), writeexp(X2, Y2).
writeexp(X, Y) :- X = minus(X1, X2), Y = (Y1 - Y2), writeexp(X1, Y1), writeexp(X2, Y2).
writeexp(X, Y) :- X = krat(X1, X2), Y = (Y1 * Y2), writeexp(X1, Y1), writeexp(X2, Y2).
writeexp(X, Y) :- X = deleno(X1, X2), Y = (Y1 / Y2), writeexp(X1, Y1), writeexp(X2, Y2).