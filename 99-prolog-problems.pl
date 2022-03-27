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

%vzorove:
%element_at(X,[X|_],1).
%element_at(X,[_|L],K) :- K > 1, K1 is K - 1, element_at(X,L,K1).

%1.04 (*) Find the number of elements of a list.
elems_in_list(0, []).
elems_in_list(C,[_|Xs]) :-  elems_in_list(C1,Xs), C is C1 + 1.


%P05 (*) Reverse a list.
list_reverse([],[]).
list_reverse([X|Xs],Y) :- list_reverse(Xs,Z), append(Z,[X],Y).


%1.06 (*) Find out whether a list is a palindrome.
palindrom(L) :- list_reverse(L,L).

%1.07 (**) Flatten a nested list structure.
%Transform a list, possibly holding lists as elements into a 'flat' list by replacing each list with its elements (recursively).

%Example:
%?- my_flatten([a, [b, [c, d], e]], X).
%X = [a, b, c, d, e]

my_flatten(X,[X]) :- \+ is_list(X).
my_flatten([],[]).
my_flatten([X|Xs],Y) :- my_flatten(X,Z), my_flatten(Xs,R), append(Z, R, Y).

%1.08a (**) Eliminate duplicates of list elements.
%Example:
%?- compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
%X = [a,b,c,a,d,e]

remove_duplicate([],[]).
remove_duplicate([X|Xs], [X|Y]) :-  \+ member(X,Xs), !, remove_duplicate(Xs, Y).
remove_duplicate([_|Xs], Y) :-  remove_duplicate(Xs, Y).



%1.08b (**) Eliminate consecutive duplicates of list elements.
%If a list contains repeated elements they should be replaced with a single copy of the element. The order of the elements should not be changed.

%Example:
%?- compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
%X = [a,b,c,a,d,e]

compress([],[]).
compress([X|[]],[X]).
compress([X,X|Xs], Y) :-  compress([X|Xs], Y).
compress([X,Z|Xs], [X|Y]) :- X \= Z, compress([Z|Xs], Y).


%1.09 (**) Pack consecutive duplicates of list elements into sublists.
%If a list contains repeated elements they should be placed in separate sublists.

%Example:
%?- pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
%X = [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]

%pack([],[]).
%pack([X],[X]).
%pack([X1|Xs], [Y|Ys]) :-member(X1, Y), append(X1,T, Y), pack(Xs, [T|Ys]). 
%pack([X1|Xs], Ys) :- append(X1, T, Ys), pack(Xs, T).

%vzorovy reseni
pack([],[]).
pack([X|Xs],[Z|Zs]) :- transfer(X,Xs,Ys,Z), pack(Ys,Zs).

% transfer(X,Xs,Ys,Z) Ys is the list that remains from the list Xs
%    when all leading copies of X are removed and transfered to Z

transfer(X,[],[],[X]).
transfer(X,[Y|Ys],[Y|Ys],[X]) :- X \= Y.
transfer(X,[X|Xs],Ys,[X|Zs]) :- transfer(X,Xs,Ys,Zs).

%1.10 (*) Run-length encoding of a list.
%Use the result of problem 1.09 to implement the so-called run-length encoding data compression method. 
%Consecutive duplicates of elements are encoded as terms [N,E] where N is the number of duplicates of the element E.
encode([X], [1-X]).
encode([X1,X2|Xs], [1-X1,Z-X2|Ys]) :- encode([X2|Xs],[Z-X2|Ys]), X1 \= X2.
encode([X,X|Xs], [Y-X|Ys]) :- encode([X|Xs], [YT-X|Ys]), Y is YT + 1.


%1.11 (*) Modified run-length encoding.
%Modify the result of problem 1.10 in such a way that if an element has no duplicates it is simply copied into the result list. Only elements with duplicates are transferred as [N,E] terms.

%Example:
%?- encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
%X = [[4,a],b,[2,c],[2,a],d,[4,e]]


encode_modified(X, Y) :- encode(X, Z), strip(Z, Y).

strip([],[]).
strip([1-X|Ys],[X|Zs]) :- strip(Ys,Zs).
strip([N-X|Ys],[N-X|Zs]) :- N > 1, strip(Ys,Zs).


%1.12 (**) Decode a run-length encoded list.
%Given a run-length code list generated as specified in problem 1.11. Construct its uncompressed version.
