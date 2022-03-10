%rotate(?L, ?M)
rotate(X,X).
rotate(X,Y) :- length(X,L), length(Y,L), append(Xa,Xb,X), append(Xb,Xa,Y).


