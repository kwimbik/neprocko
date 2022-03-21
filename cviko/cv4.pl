:- use_module(library(dialect/hprolog), [sublist/2]).
%choose2(?X, ?Y, Z) where X is the list, Y is target sum, Z are 2 elements with sum Y.
choose2(X, Y, [Z1, Z2]) :- member(Z1, X), member(Z2, X), Y is Z1 + Z2, !.



%vyber(+S, +N, -P) :- P je podseznam S, tk suma P = N.
vyber([], N, _):-N>0, fail.
vyber([], 0, []).
vyber([H|T], N, [H|Z]):-N1 is N-H,vyber(T,N1,Z).
vyber([_|T],N,Z):-vyber(T,N,Z).


