%spocti(+ListCisel,-HodnotaVyrazu,-Vyraz)
spocti([X],X,X).
spocti(L,H,V):-
    % Rozdel list L na dvě neprázdné části
    append([X|TX],[Y|TY],L),
    % Rekurzivně vytvoř výraz pro obě části L
    spocti([X|TX],_,V1),
    spocti([Y|TY],_,V2),
    % Spoj výrazy znaménkem, děl jen pokud pravá část není nula
    (
        member(V,[V1+V2,V1-V2,V1*V2]);
        (H2 is V2, H2 =\= 0, V = (V1/V2))
    ),
    % Spočti hodnotu výsledného výrazu
    H is V.

vlozOperatory(L,H,V):-
    spocti(L,H,V).
   