
%one_rgs(one(X), Y).
%star_rgc(star(X), Y).
%plus_rgs(plus(X), Y).
%opt_rgx(opt(X), Y).

% match(+E, ?S)  is true if the expression E matches the sequence S
match([], []).
%jeste osetrit aby to bylo prave 1
match([X|Xs], Y) :- X = one(Yk), match(Xs, Ys), append(Yk,Ys, Y).