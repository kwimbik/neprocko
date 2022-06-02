%pridejBVS(+X, +T1, -T2) adds element X to tree T1, creating tree T2
pridejBVS(X, nil, t(nil, X, nil)).
pridejBVS(X, t(LP, H, PP), t(LP, H, S)) :- X > H, pridejBVS(X, PP, S).
pridejBVS(X, t(LP, H, PP), t(S, H, PP)) :- X =< H, pridejBVS(X, LP, S).


%listToBVS(+L, -T)
listToBVS([], nil).
listToBVS([X|Xs], NT) :- listToBVS(Xs, T1), pridejBVS(X, T1, NT).


%mapTree(+G, +T, -GS) where G is goal, T is tree and GS is goal applied to every node in T
mapTree(_, nil, nil).
mapTree(G, t(LP, H, PS), t(NTL, NH, NTP)) :-
mapTree(G, LP, NTL), mapTree(G, PS, NTP),
call(G, H, NH).



%najit, jak se napise call nejak rozumne.. protoze obvi neni pouzitelnej na zkousce
%foldtree(+LeftAcum, +Value, +RightAcum, NewValue)
foldltree(P, Init, nil, Init).
foldltree(P, Init, t(LP, H, PP), V) :-
foldltree(P, Init, LP, LA),
foldltree(P, Init, PP, PA),
call(P, H, PA, LA, V).

%mel by byt tridici algoritmus :D
spoj(LA, H, PP, NH) :- append(LA, [H|PP], NH).


%hrana(+SN, -V1, -V2):- hrana reprezentovana v seznamu nasledniku SN
hrana(SN, V1, V2) :- member(V1 - N, SN), member(V2, N). 




