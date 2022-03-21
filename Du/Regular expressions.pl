%one(List) means a single occurrence of List
%star(List) means 0 or more occurrences of List
%plus(List) means 1 or more occurrences of List
%opt(List) means 0 or 1 occurrences of List

% match(+E, ?S)  is true if the expression E matches the sequence S
match([], []) :-!.

match([X|Xs], Y) :- X = one(Yk), append(Yk,Ys, Y), match(Xs, Ys).

match([X|Xs], Y) :- X = star(Yk), (append([],Ys, Y), match(Xs, Ys); append(Yk,Ys, Y), match([X|Xs], Ys)).

match([X|Xs], Y) :- X = plus(Yk), (append(Yk,Ys, Y), match(Xs, Ys);append(Yk,Ys, Y), match([X|Xs], Ys)).

match([X|Xs], Y) :- X = opt(Yk), (append(Yk,Ys, Y), match(Xs, Ys); append([],Ys, Y),match(Xs, Ys)).


%nejak napsat append([Yk,Yk],Ys, Y ) pro vsechny Yk.. idk jak

