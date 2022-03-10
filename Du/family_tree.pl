/*male(liam). male(noah). male(oliver). male(william).
male(elijah). male(james). male(ben).

female(olivia). female(emma). female(ava).
female(sophia). female(isabella). female(evelyn).

parent(liam, oliver).
parent(olivia, oliver).

parent(liam, emma).
parent(olivia, emma).

parent(noah, william).
parent(olivia, william).

parent(william, evelyn).

parent(oliver, ava).
parent(ava, james).
parent(james, isabella).

parent(emma, elijah).
parent(elijah, sophia).
parent(sophia, ben).*/


% true if G is great-grandmother of X
great_grandmother(G, X) :- parent(G,Z), parent(Z,Y), parent(Y,X), female(G).
% true if X is sibling of Y
sibling(X, Y) :- dif(X,Y), parent(P, Y), parent(P, X).

% if X and Y have both parents in commin
full_sibling(X, Y) :- dif(X,Y), parent(P1, Y), parent(P1, X),parent(P2, Y), parent(P2, X), dif(P1, P2), male(P1), female(P2).

% First cousins have parents who are full siblings.
first_cousin(X, Y) :- parent(P1, Y), parent(P2, X), full_sibling(P1, P2).

% Second cousins have parents who are first cousins.
second_cousin(X, Y) :- parent(P1, Y), parent(P2, X), first_cousin(P1, P2).

% True if X and Y are Nth cousins for any N ≥ 1.
nth_cousin(X, Y) :- first_cousin(X, Y).
nth_cousin(X, Y) :- parent(P1, Y), parent(P2, X), nth_cousin(P1, P2).