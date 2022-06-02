% vlozOperatory nedeterministicky rozdeli list na dve casti (kazda sa spracovava rekurzivne), pri dlzke jedna vrati hodnotu, inak nedeterministicky zvoli jeden operator ,
% vytvori vyraz a spocita hodnotu

% rez vyuzivam len na zrychlenie vypoctu
% v klauzuli s delenim je pridana kontrola na delenie nulou

vlozOperatory([X],X,X):- length([X], 1),!.
vlozOperatory(X,H,V):- append(L,R,X), length(L,LL), length(R,LR), LL >= 1, LR >=1, vlozOperatory(L,LH,LV), vlozOperatory(R,PH,PV), V=LV * PV, H is LH * PH .
vlozOperatory(X,H,V):- append(L,R,X), length(L,LL), length(R,LR), LL >= 1, LR >=1, vlozOperatory(L,LH,LV), vlozOperatory(R,PH,PV), V=LV + PV, H is LH + PH .
vlozOperatory(X,H,V):- append(L,R,X), length(L,LL), length(R,LR), LL >= 1, LR >=1, vlozOperatory(L,LH,LV), vlozOperatory(R,PH,PV), V=LV - PV, H is LH - PH .
vlozOperatory(X,H,V):- append(L,R,X), length(L,LL), length(R,LR), LL >= 1, LR >=1, vlozOperatory(L,LH,LV), vlozOperatory(R,PH,PV), PH \= 0, V=LV / PV, H is div(LH ,PH) .

