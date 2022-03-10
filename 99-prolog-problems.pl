%1.01 (*) Find the last element of a list.
%Example:
%?- my_last(X,[a,b,c,d]).
%X = d

my_last([X],X).
my_last([_|T], X) :- my_last(T, X).


%1.02 (*) Find the last but one element of a list.
% last_but_one(X,L) :- X is the last but one element of the list L
%    (element,list) (?,?)

last_but_one([X|[_]], X).
last_but_one([_|X], L) :- last_but_one(X, L).


%P03 (*) Find the K'th element of a list.
%The first element in the list is number 1.
%Example:
%?- element_at(X,[a,b,c,d,e],3).
%X = c

element_at(X,[X|T],K) :- length([X|T], K).
element_at(X,[_|Y],C) :- element_at(X,Y,C).