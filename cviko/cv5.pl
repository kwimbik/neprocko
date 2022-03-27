scalar(Ai, Bi, C, Z) :- Z is C + Ai*Bi.

horner(Ai, C, Z) :-Z  is 10*C +Ai.


generate([], 0).
%generate([X], 1) :- (X is 1; X is 0).
generate([X|Xs], Y) :- length([X|Xs], Y), generate(Xs, Z), member(X, [0,1]), Z is Y - 1.