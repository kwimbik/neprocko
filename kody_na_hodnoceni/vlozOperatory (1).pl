

%vlozOperatory(+X, ?V, ?E).
vlozOperatory(X, V, E):- createPostExpression(X, E1), eval(E1, V), createInfixExpression(E1, E).


% Expression out of single value list is the value
createPostExpression([X], X).

% All posibilities how to create an Expression out of 2 values list
createPostExpression([X,Y], plus(X,Y)).
createPostExpression([X,Y], minus(X,Y)).
createPostExpression([X,Y], times(X,Y)).
createPostExpression([X,Y], divide(X,Y)):- dif(Y, 0).

% If the list is longer than 2, cut it in the 2 sublist and create Expressions recursively out of them. Then join those 2 Expressions in the main Expression.
createPostExpression(X, Ex):- length(X, L), L > 2, Ex = plus(Ex1, Ex2), append(X1,X2,X), length(X1,L1), L1 > 0, length(X2,L2), L2 > 0, createPostExpression(X1, Ex1), createPostExpression(X2, Ex2).
createPostExpression(X, Ex):- length(X, L), L > 2, Ex = minus(Ex1, Ex2), append(X1,X2,X), length(X1,L1), L1 > 0, length(X2,L2), L2 > 0, createPostExpression(X1, Ex1), createPostExpression(X2, Ex2).
createPostExpression(X, Ex):- length(X, L), L > 2, Ex = times(Ex1, Ex2), append(X1,X2,X), length(X1,L1), L1 > 0, length(X2,L2), L2 > 0, createPostExpression(X1, Ex1), createPostExpression(X2, Ex2).
createPostExpression(X, Ex):- length(X, L), L > 2, Ex = divide(Ex1, Ex2), append(X1,X2,X), length(X1,L1), L1 > 0, length(X2,L2), L2 > 0, createPostExpression(X1, Ex1), createPostExpression(X2, Ex2), not(eval(Ex2, 0)).

%eval(+Ex, ?V):- checks if postfix Expression is equal to Value.
eval(Ex, Ex):- integer(Ex).
eval(Ex, V):- Ex = plus(Ex1, Ex2), eval(Ex1, V1), eval(Ex2, V2), V is V1 + V2.
eval(Ex, V):- Ex = minus(Ex1, Ex2), eval(Ex1, V1), eval(Ex2, V2), V is V1 - V2.
eval(Ex, V):- Ex = times(Ex1, Ex2), eval(Ex1, V1), eval(Ex2, V2), V is V1 * V2.
eval(Ex, V):- Ex = divide(Ex1, Ex2), eval(Ex1, V1), eval(Ex2, V2), V is V1 // V2.

%createInfixExpression(+Ex, -InEx):- creates Infix Expression out of Postfix Expression.
createInfixExpression(Ex, Ex):- integer(Ex).
createInfixExpression(Ex, InEx):- Ex = plus(Ex1, Ex2), InEx = InEx1 + InEx2, createInfixExpression(Ex1, InEx1), createInfixExpression(Ex2, InEx2).
createInfixExpression(Ex, InEx):- Ex = minus(Ex1, Ex2), InEx = InEx1 - InEx2, createInfixExpression(Ex1, InEx1), createInfixExpression(Ex2, InEx2).
createInfixExpression(Ex, InEx):- Ex = times(Ex1, Ex2), InEx = InEx1 * InEx2, createInfixExpression(Ex1, InEx1), createInfixExpression(Ex2, InEx2).
createInfixExpression(Ex, InEx):- Ex = divide(Ex1, Ex2), InEx = InEx1 / InEx2, createInfixExpression(Ex1, InEx1), createInfixExpression(Ex2, InEx2).

