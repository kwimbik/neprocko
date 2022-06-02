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

rle_decode([], []).
rle_decode([X|Xs], [X|Ys]) :- X \= _-_ , rle_decode(Xs, Ys).
rle_decode([1-X|Xs], [X|Ys]) :- rle_decode(Xs, Ys).
rle_decode([N-X|Xs], [X|Ys]) :- N > 1 , N1 is N - 1, rle_decode([N1-X|Xs], Ys).


%1.14 (*) Duplicate the elements of a list.
%Example:
%?- dupli([a,b,c,c,d],X).
%X = [a,a,b,b,c,c,c,c,d,d]

dupli([],[]).
dupli([X|Xs],[X,X|Ys]) :- dupli(Xs,Ys).

%1.15 (**) Duplicate the elements of a list a given number of times.
%Example:
%?- dupli([a,b,c],3,X).
%X = [a,a,a,b,b,b,c,c,c]

dupli([],_,[]).
dupli(X,Y,Z) :- \+ is_list(Y), dupli(X,[Y,Y],Z).
dupli([X|Xs],[1, M],[X|Ys]) :- dupli(Xs,[M,M],Ys).
dupli([X|Xs],[N, M],[X|Ys]) :- N > 1, N1 is N -1, dupli([X|Xs],[N1,M],Ys).

%1.16 (**) Drop every N'th element from a list.
%Example:
%?- drop([a,b,c,d,e,f,g,h,i,k],3,X).
%X = [a,b,d,e,g,h,k]

drop(X, N, Y) :- drop(X, N, N, Y).
drop([], _, _, []) :- !.
drop([_|AX], 1, N, B) :- drop(AX, N, N, B), !.
drop([A|AX], N, N0, [A|B]) :- N1 is N - 1,  drop(AX, N1, N0, B).

%1.17 (*) Split a list into two parts; the length of the first part is given.
%Do not use any predefined predicates.

%Example:
%?- split([a,b,c,d,e,f,g,h,i,k],3,L1,L2).
%L1 = [a,b,c]
%L2 = [d,e,f,g,h,i,k]

split([], _, [], []) :- !.
split([A|AX], N, [A|L1], L2) :- N > 0, N1 is N -1, split(AX, N1, L1, L2), !.
split([A|AX], 0, [], [A|AX]).




%1.20 (*) Remove the K'th element from a list.
%Example:
%?- remove_at(X,[a,b,c,d],2,R).
%X = b
%R = [a,c,d]

remove_at([], [], _, []).
remove_at(A, [A|AL], 1, AL).
remove_at(X, [A|AL], N, [A|R]) :- N > 1, N1 is N - 1, remove_at(X, AL, N1, R), !.

%1.21 (*) Insert an element at a given position into a list.
%Example:
%?- insert_at(alfa,[a,b,c,d],2,L).
%L = [a,alfa,b,c,d]


insert_at(Y, [A|AX], N, [A|R]) :- N > 1, N1 is N - 1,  insert_at(Y, AX, N1, R), !.
insert_at(Y, A, 1, [Y|A]) :- !.

%1.22 (*) Create a list containing all integers within a given range.
%Example:
%?- range(4,9,L).
%L = [4,5,6,7,8,9]

range(X, X, [X]) :- !.
range(X, Y, [X|L]) :- X1 is X + 1, range(X1, Y, L). 

%1.23 (**) Extract a given number of randomly selected elements from a list.
%The selected items shall be put into a result list.
%Example:
%?- rnd_select([a,b,c,d,e,f,g,h],3,L).
%L = [e,d,a]

rnd_select(_, 0, []) :- !.
rnd_select(X, N, [I1|LI]) :- N1 is N - 1, length(X, LX), LX1 is LX +1, random(1,LX1, R), remove_at(I1,X,R,Z), rnd_select(Z, N1, LI).

%Hint: Use the built-in random number generator random/2 and the result of problem 1.20.

%1.24 (*) Lotto: Draw N different random numbers from the set 1..M.
%The selected numbers shall be put into a result list.
%Example:
%?- lotto(6,49,L).
%L = [23,1,17,33,21,37]

%Hint: Combine the solutions of problems 1.22 and 1.23.

lotto(0,_,[]).
lotto(N, M, L) :- range(1, M, IL), rnd_select(IL, N, L).