subset([],[]).
        subset([X|L],[X|S]) :-
            subset(L,S).
        subset(L, [_|S]) :-
            subset(L,S).