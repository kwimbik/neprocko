%vlozOperatory(+L, -H, -V) kde L je list cisel, H je hodnota vysledneho vyrazu a V je vyraz s kombinaci operatoru
vlozOperatory([], [], []).
vlozOperatory(L, H, V) :- createExpression(L, V), eval(V, H).



%createExpression
createExpression([X1, X2], Y) :- (Y = plus(X1, X2); Y = minus(X1, X2); Y = krat(X1, X2); Y = deleno(X1, X2)).
createExpression([X|Xs], Y) :-
(createExpression(Xs, X1), Y = plus(X, X1);
createExpression(Xs, X1), Y = minus(X, X1);
createExpression(Xs, X1), Y = krat(X, X1);
createExpression(Xs, X1), Y = deleno(X, X1)).


%chooseTwo(+List, -A, -B, -Rest)
chooseTwo([], [], [], []).
chooseTwo(L, A, B, R) :- member(A, L), member(B, L), A \= B, delete([A,B], L, R).

%eval(+Expr, -Value)
eval([], []).
eval(X, Y) :- X = plus(X1, X2),
(integer(X1),integer(X2), Y is X1 + X2;
integer(X1),\+ integer(X2), eval(X2, Y2), Y is X1 + Y2;
\+ integer(X1),integer(X2), eval(X1, Y1), Y is X2 + Y1;
eval(X1, Y1), eval(X2, Y2), Y is Y1 + Y2).

eval(X, Y) :- X = minus(X1, X2),
(integer(X1),integer(X2), Y is X1 - X2;
integer(X1),\+ integer(X2), eval(X2, Y2), Y is X1 - Y2;
\+ integer(X1),integer(X2), eval(X1, Y1), Y is X2 - Y1;
eval(X1, Y1), eval(X2, Y2), Y is Y1 - Y2).

eval(X, Y) :- X = krat(X1, X2),
(integer(X1),integer(X2), Y is X1 * X2;
integer(X1),\+ integer(X2), eval(X2, Y2), Y is X1 * Y2;
\+ integer(X1),integer(X2), eval(X1, Y1), Y is X2 * Y1;
eval(X1, Y1), eval(X2, Y2), Y is Y1 * Y2).


eval(X, Y) :- X = deleno(X1, X2),
(integer(X1),integer(X2), Y is X1 / X2;
integer(X1),\+ integer(X2), eval(X2, Y2), Y is X1 / Y2;
\+ integer(X1),integer(X2), eval(X1, Y1), Y is X2 / Y1;
eval(X1, Y1), eval(X2, Y2), Y is Y1 / Y2).