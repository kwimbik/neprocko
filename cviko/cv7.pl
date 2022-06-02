%prohledavani grafu -> bud pamatovat seznam navstivenych vrcholu, 
%nebo LEPSI: hledat cestu delky n a zvetsovat n : Iterative deepining


%prohledavani stavoveho prostoru prelevani vody mezi 2 nadobami

% akce(+Stav, +MaxV1, +MaxV2, -NovyStav):-NovyStav je Stav, ktery vznikne
% aplikaci jedne akce na Stav, kdyz nadoby maji maximalni objemy MaxV1 a MaxV2
akce(s(_, Y), _, _, s(0, Y)). % vyliti prvni nadoby
akce(s(X, _), _, _, s(X, 0)). % vyliti druhe nadoby
akce(s(_, Y), V1, _, s(V1, Y)). % naplneni prvni nadoby
akce(s(X, _), _, V2, s(X, V2)). % naplneni druhe nadoby
akce(s(X, Y), V1, _, s(X1, Y1)):-X + Y > V1, X1 = V1, Y1 is Y - (V1 - X). % preliti druhe nadoby do prvni, nevejde se vse
akce(s(X, Y), V1, _, s(X1, Y1)):-X + Y =< V1, X1 is X + Y, Y1 = 0. % preliti druhe do prvni, vse se vejde 
akce(s(X, Y), _, V2, s(X1, Y1)):-X + Y > V2, Y1 = V2, X1 is X - (V2 - Y). % preliti prvni do druhe, nevejde se vse
akce(s(X, Y), _, V2, s(X1, Y1)):-X + Y =< V2, Y1 is X + Y, X1 = 0. % preliti prvni do druhe, vejde se vse


%dostali bychom nekonecne zacykleni, musime pouzit length(MS, X) ktere postupne zvetsovat, kdyz vyres nevrati reseni.
vyres(PS, PS, _ , _, [PS]).
vyres(PS, KS, C1, C2, [PS2|S]) :- akce(PS, C1, C2, KS),
                                    vyres(PS2, KS, C1, C2, S).

%iterative deenening postupne pro 1...n
vyresID(PS, KS, C1, C2, MS) :- between(1, 30, N), length(MS, N), vyres(PS, KS, C1, C2, MS).

%moznost pridani a* like heuristiky na pocet zbyvajicich kroku, pokud zbyva min kroku nez je odhad heuristiky, okamzite failujeme pro Lloyda
