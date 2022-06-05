:- dynamic appendEdges/1.
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



%2.01 (**) Determine whether a given integer number is prime.
%Example:
%?- is_prime(7).
%Yes

is_prime(2).
is_prime(3).
is_prime(P) :- integer(P), P > 3, P mod 2 =\= 0, \+ has_factor(P,3).  

% has_factor(N,L) :- N has an odd factor F >= L.
%    (integer, integer) (+,+)

has_factor(N,L) :- N mod L =:= 0.
has_factor(N,L) :- L * L < N, L2 is L + 2, has_factor(N,L2).


%2.02 (**) Determine the prime factors of a given positive integer.
%Construct a flat list containing the prime factors in ascending order.
%Example:
%?- prime_factors(315, L).
%L = [3,3,5,7]

prime_factors(X, L) :- prime_factors(X, L, 2).
prime_factors(1, [], _) :-  !.
prime_factors(X, [N|L], N) :- is_prime(N), X mod N =:= 0, X1 is X // N, prime_factors(X1, L, N).
prime_factors(X, L, N) :- N1 is N+1, prime_factors(X, L, N1), !.

%2.05 (**) Goldbach's conjecture.
%Goldbach's conjecture says that every positive even number greater than 2 is the sum of two prime numbers. Example: 28 = 5 + 23. It is one of the most famous facts in number theory that has not been proved to be correct in the general case. It has been numerically confirmed up to very large numbers (much larger than we can go with our Prolog system). Write a predicate to find the two prime numbers that sum up to a given even integer.

%Example:
%?- goldbach(28, L).
%L = [5,23]

goldbach(X, L) :- goldbach(X, L, 2), !.
goldbach(X, [N,K], N) :- is_prime(N), K is X - N, is_prime(K).
goldbach(X, L, N) :- N1 is N + 1, goldbach(X, L, N1).


%(**) Truth tables for logical expressions.
%Define predicates and/2, or/2, nand/2, nor/2, xor/2, impl/2 and equ/2 (for logical equivalence) which succeed or fail according to the result of their respective operations; e.g. and(A,B) will succeed, if and only if both A and B succeed. Note that A and B can be Prolog goals (not only the constants true and fail).

%A logical expression in two variables can then be written in prefix notation, as in the following example: and(or(A,B),nand(A,B)).

%Now, write a predicate table/3 which prints the truth table of a given logical expression in two variables.

%Example:
%?- table(A,B,and(A,or(A,B))).
%true true true
%true fail true
%fail true fail
%fail fail fail

and(A,B) :- A, B.
or(A,_) :- A.
or(_,B) :- B.
equ(A,B) :- or(and(A,B), and(not(A),not(B))).
xor(A,B) :- not(equ(A,B)).
nor(A,B) :- not(or(A,B)).
nand(A,B) :- not(and(A,B)).
impl(A,B) :- or(not(A),B).

bind(true).
bind(fail).

table(A,B,Expr) :- bind(A), bind(B), do(A,B,Expr), fail.

do(A,B,_) :- write(A), write('  '), write(B), write('  '), fail.
do(_,_,Expr) :- Expr, !, write(true), nl.
do(_,_,_) :- write(fail), nl.


%3.04 (**) Gray code.
%An n-bit Gray code is a sequence of n-bit strings constructed according to certain rules. For example,
%n = 1: C(1) = ['0','1'].
%n = 2: C(2) = ['00','01','11','10'].
%n = 3: C(3) = ['000','001','011','010','110','111','101','100'].

%Find out the construction rules and write a predicate with the following specification:

% gray(N,C) :- C is the N-bit Gray code

%Can you apply the method of "result caching" in order to make the predicate more efficient, when it is to be used repeatedly?

% reseni v downloads

%4.01 (*) Check whether a given term represents a binary tree
%Write a predicate istree/1 which succeeds if and only if its argument is a Prolog term representing a binary tree.
%Example:
%?- istree(t(a,t(b,nil,nil),nil)).
%Yes
%?- istree(t(a,t(b,nil,nil))).
%No

istree(nil).
istree(T) :- T = t(X,Y,Z), X \= nil, istree(Y), istree(Z). 

%4.02 (**) Construct completely balanced binary trees
%In a completely balanced binary tree, the following property holds for every node: The number of nodes in its left subtree and the number of nodes in its right subtree are almost equal, which means their difference is not greater than one.

%Write a predicate cbal_tree/2 to construct completely balanced binary trees for a given number of nodes. The predicate should generate all solutions via backtracking. Put the letter 'x' as information into all nodes of the tree.
%Example:
%?- cbal_tree(4,T).
%T = t(x, t(x, nil, nil), t(x, nil, t(x, nil, nil))) ;
%T = t(x, t(x, nil, nil), t(x, t(x, nil, nil), nil)) ;

cbal_tree(0, nil) :- !.
cbal_tree(1, X) :- X = t(x, nill, nill); X = t(x, nill ,nil), !.
cbal_tree(N, t(x,Y,Z)):- N2 is (N-1) // 2, N2N is N2 + 1, (cbal_tree(N2N, Y), cbal_tree(N2, Z); cbal_tree(N2, Y), cbal_tree(N2N, Z)).

%4.03 (**) Symmetric binary trees
%Let us call a binary tree symmetric if you can draw a vertical line through the root node and then the right subtree is the mirror image of the left subtree.
%Write a predicate symmetric/1 to check whether a given binary tree is symmetric. Hint: Write a predicate mirror/2 first to check whether one tree is the mirror image of another.
%We are only interested in the structure, not in the contents of the nodes.

symmetric(T) :- T = t(_, Y, Z), mirror(Y,Z), !.

mirror(X,Z) :- (X = t(_, X1, X2), Z = t(_, Y1, Y2),mirror(X1, Y2), mirror(X2, Y1) ; X = nil, Z = nil).


%4.06 (**) Construct height-balanced binary trees
%In a height-balanced binary tree, the following property holds for every node: The height of its left subtree and the height of its right subtree are almost equal, which means their difference is not greater than one.

%Write a predicate hbal_tree/2 to construct height-balanced binary trees for a given height. The predicate should generate all solutions via backtracking. Put the letter 'x' as information into all nodes of the tree.
%Example:
%?- hbal_tree(3,T).
%T = t(x, t(x, t(x, nil, nil), t(x, nil, nil)), t(x, t(x, nil, nil), t(x, nil, nil))) ;
%T = t(x, t(x, t(x, nil, nil), t(x, nil, nil)), t(x, t(x, nil, nil), nil)) ;
%etc......No

hbal_tree(0,nil) :- !.
hbal_tree(1, t(x, nil, nil)) :- !.
hbal_tree(H, T) :- T = t(x, Y, X), H1 is H -1, H2 is H -2, (hbal_tree(H1,Y), hbal_tree(H1,X); hbal_tree(H2,Y), hbal_tree(H1,X); hbal_tree(H1,Y), hbal_tree(H2,X)).

%4.07 (**) Construct height-balanced binary trees with a given number of nodes
%Consider a height-balanced binary tree of height H. What is the maximum number of nodes it can contain?
%Clearly, MaxN = 2**H - 1. However, what is the minimum number MinN? This question is more difficult. Try to find a recursive statement and turn it into a predicate minNodes/2 defined as follwos:

% minNodes(H,N) :- N is the minimum number of nodes in a height-balanced binary tree of height H.
%(integer,integer), (+,?)
minNodes(2,2):- !.
minNodes(1,1):- !.
minNodes(H,N) :- H1 is H -1, H2 is H - 2, minNodes(H1,N1), minNodes(H2,N2), N is N1 + N2 + 1.


maxNodes(H,N) :- N is 2**H - 1.

minHeight(0,0) :- !.
minHeight(N,H) :- N > 0, N1 is N//2, minHeight(N1,H1), H is H1 + 1.

%On the other hand, we might ask: what is the maximum height H a height-balanced binary tree with N nodes can have?

% maxHeight(N,H) :- H is the maximum height of a height-balanced binary tree with N nodes
%(integer,integer), (+,?)
maxHeight(1,1).
maxHeight(2,2).
maxHeight(N, H) :- maxHeight(N, H, 2), !.
maxHeight(N, H, MH) :-minNodes(MH,K), N  >= K, MH1 = MH + 1,  maxHeight(N, H, MH1).
maxHeight(N, H, MH) :- minNodes(MH,K), N < K , H is MH - 1, !.
%Now, we can attack the main problem: construct all the height-balanced binary trees with a given nuber of nodes.

% hbal_tree_nodes(N,T) :- T is a height-balanced binary tree with N nodes.
hbal_tree_nodes(N,T) :-
minHeight(N,Hmin), maxHeight(N,Hmax),
	between(Hmin,Hmax,H),
    hbal_tree(H, T), nodes(T, N).

nodes(nil, 0).
nodes(t(_,Y,Z), N) :- nodes(Y, N1), nodes(Z, N2), N is N1 + N2 +1.

%Find out how many height-balanced trees exist for N = 15.

%4.12 (**) Construct a complete binary tree
%A complete binary tree with height H is defined as follows: The levels 1,2,3,...,H-1 contain the maximum number of nodes (i.e 2**(i-1) at the level i, note that we start counting the levels from 1 at the root). In level H, which may contain less than the maximum possible number of nodes, all the nodes are "left-adjusted". This means that in a levelorder tree traversal all internal nodes come first, the leaves come second, and empty successors (the nil's which are not really nodes!) come last.

%Particularly, complete binary trees are used as data structures (or addressing schemes) for heaps.

%We can assign an address number to each node in a complete binary tree by enumerating the nodes in levelorder, starting at the root with number 1. In doing so, we realize that for every node X with address A the following property holds: The address of X's left and right successors are 2*A and 2*A+1, respectively, supposed the successors do exist. This fact can be used to elegantly construct a complete binary tree structure. Write a predicate complete_binary_tree/2 with the following specification:

% complete_binary_tree(N,T) :- T is a complete binary tree with N nodes. (+,?)

complete_binary_tree(0,nil).

%todo finish if needed


%-------------GRAFY
% graph([b,c,d,f,g,h,k],[e(b,c),e(b,f),e(c,f),e(f,k),e(g,h)]) default form of graph


%6.02 (**) Path from one node to another one

%Write a predicate path(G,A,B,P) to find an acyclic path P from node A to node B in the graph G. The predicate should return all paths via backtracking.


path(G,A,B,P) :- G = (X, Y), member(A,X), member(B,X), path_find(A,B,Y,P).


path_find(A,B,X,[E|P]) :- member(E, X), E = e(A,TE), TE \= B, path_find(TE, B, X, P).
path_find(A,B,X,[E1]) :- E1 = e(A,B), member(E1, X), !.
path_find(A,B,X,[E2]) :- E2 = e(B,A),  member(E2, X), !.



%6.03 (*) Cycle from a given node

%Write a predicate cycle(G,A,P) to find a closed path (cycle) P starting at a given node A in the graph G. The predicate should return all cycles via backtracking.
cycle(G,A,P) :- path(G,A,A,P).

%6.04 (**) Construct all spanning trees

%Write a predicate s_tree(Graph,Tree) to construct (by backtracking) all spanning trees of a given graph. With this predicate, find out how many spanning trees there are for the graph depicted to the left.
%The data of this example graph can be found in the file p6_04.dat. When you have a correct solution for the s_tree/2 predicate, use it to define two other useful predicates: is_tree(Graph) and is_connected(Graph).
%Both are five-minutes tasks!


%Todo

%6.06 (**) Graph isomorphism

%Two graphs G1(N1,E1) and G2(N2,E2) are isomorphic if there is a bijection f: N1 -> N2 such that for any nodes X,Y of N1, X and Y are adjacent if and only if f(X) and f(Y) are adjacent.

%Write a predicate that determines whether two graphs are isomorphic. Hint: Use an open-ended list to represent the function f.

isographs(G1, G2) :- isoProjection(G1,G2, G1N), G1N = G2. %opravit na subset, poradi hran se mohlo zmenit

isoProjection(G1,G2, G1N) :- isoProjection(G1,G2, G1N, []).
isoProjection((X,E),(Y,_), (Y,E), R) :- subset(X,R), subset(Y,R).
isoProjection((X,Y), (P,Q), (A,BR), R) :- member(L,X), member(K,P),  \+ member(L,R), \+ member(K,R), appendEdges(L,K,Y,B,RE), append(B, RE, NEG), isoProjection((X,NEG), (P,Q), (A,BR), [L,K|R]).

appendEdges(_,_,[],[],[]) :- !.
appendEdges(L, K, [Y|YX], [e(K,Z)|E], RE) :- Y= e(L,Z),  appendEdges(L,K,YX, E, RE), !.
appendEdges(L, K, [Y|YX], [e(Z,K)|E], RE) :- Y= e(Z,L),  appendEdges(L,K,YX, E, RE), !.
appendEdges(L, K, [CE|YX], E, [CE|RE]) :- appendEdges(L,K,YX, E, RE), !.

%6.10 (**) Bipartite graphs

%Write a predicate that finds out whether a given graph is bipartite.



% ZKOUSKOVE TESTY
%Definujte predikát kruznice(+G, -Cykly), který

%zjistí, zdali G sestává z vrcholově disjunktních kružnic
%přitom uvažujeme i kružnice délky 2 (2 vrcholy propojené hranami v obou měrech) a 0 (izolovaný vrchol)


%?- kruznice(og([b,c,d,e,f],[e(f-c), e(e-f), e(c-e), e(d-b), e(b-d)]), Cykly).
%Cykly = [[a],[b,d],[c,e,f]]

opath(og(_,X),A,A,X, [A]) :- is_separate([A],X).
opath(G,A,B,P,U) :- G = og(X, Y), member(A,X), member(B,X), opath_find(A,B,Y,P,U).

opath_find(A,B,X,[E|P],[TE|UN]) :- member(E, X), E = e(A-TE), TE \= B, opath_find(TE, B, X, P, UN).
opath_find(A,B,X,[E1], [B]) :- E1 = e(A-B), member(E1, X), !.

ocycle(G,A,P) :- opath(G,A,A,P, _).

kruznice(og([], _), []).
kruznice(G, Cykly):- G=og(X,Y), append([A|L1], L2, X), opath(og([A|L1],Y),A,A, _, C1), subset(C1,[A|L1]), kruznice(og(L2, Y), C2), Cykly = [C1, C2], !.

is_separate([A], X) :- \+ (member(E,X), E = e(L1-L2), A = L1, A \= L2). 

%nefunguje optimalne, pouze, pokud jsou vrcholy v poradi za sebou, tedy rozdeluju appendem, ekvivalentni reseni by bylo pouzit subset a jeho zbytek
%pro reseni blizsi zadani


%Na vstupu je obecný strom (ne nutně binární) strom, v jehož vrcholech jsou uložena navzájem různá celá čísla. Naším cílem je definovat predikát cesta/4, který
%
%
%
%ve stromě najde cestu z vrcholu se zadanou hodnotou x do vrcholu se zadanou hodnotou y
%nalezenou cestu vrátí jako seznam čísel vrcholů tvořících tuto cestu
%pokud hodnota x či y ve stromě není, predikát selže.
%(a) Popište reprezentaci obecného stromu, kterou budete používat.
%
%(b) Sestavte definici predikátu cesta(+Strom, +X, +Y, -Cesta).


%1. Prolog: Generátor seznamů (10 bodů)

%Cílem úlohy je definovat predikát gen(-Xs,+N), který

%obdrží přirozené číslo N
%a postupně vrátí všechny korektně utvořené termy, které jsou tvořeny právě N do sebe různě vnořenými seznamy.
%Každý seznam uvedeného typu bychom měli na výstupu obdržet právě jednou, na pořadí odpovědí nezáleží.

%Příklad:
%
%?- gen(Xs,4).
%Xs = [[[[]]]] ;
%Xs = [[[], []]] ;
%Xs = [[], [[]]] ;
%Xs = [[], [], []] ;
%Xs = [[[]], []] ;
%false.

gen(1, []):- !.
gen(N, X) :- N1 is N-1, N2 is N - 2,  between(0,N2,B), A is N1 - B,
    (A = 0, gen(B,L2), X = [L2];
    B = 0, gen(A,L1), X = [L1];
    gen(A,L1), gen(B,L2), X = [L1, L2]);



%Vytvořte predikát allTrees, který pro daný seznam hladin vygeneruje všechny možné binární stromy.

%[[1], [2, 3], [4]]
bin_tree_with_levels([[]], nil).
bin_tree_with_levels([X|[]], t(X, nil, nil)) :- length(X, 1).
bin_tree_with_levels([Root|Rest], t(Root,X,Y)) :- length(Root, 1), split_lists(Rest, L1, L2), bin_tree_with_levels(L1, X), bin_tree_with_levels(L2,Y).

%split_lists(X, L1, L2) splits X into 2 lists where from each element of X, both lists gain +- half
split_lists([], [], []).
split_lists([X|Xs], [Y|L1], [Z|L2]) :-  append(Y, Z, X), split_lists(Xs, L1, L2).



%Je zadán seznam množin Mss. Chceme všemi možnými způsoby vybrat a vrátit v seznamu reprezentanty daných množin
% v odpovídajícím pořadí s podmínkou, že konkrétní reprezentanti v jednom výběru jsou různí. Sestrojte reprezentanti(+Mss, -Rss):

%reprezentanti([[1],[1,2,3],[1,3,4]], R).
%R = [[1,2,3],[1,2,4],[1,3,4]]

