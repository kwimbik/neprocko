:- use_module(library(dialect/hprolog), [sublist/2]).
my_graph(G) :- G =
    [a -> [b, c], b -> [a, c, e, f], c -> [a, b, d, e, f],
     d -> [c, f], e -> [b, c, f], f -> [b, c, d, e]].

% clique(+G, +N, ?C) takes graph G, integer N and returns C such that C is a clique on N vertices in graph G
clique(_, 0, []).
clique(G, 1, PC) :- getVertices(G,C), sublist(PC, C), length(PC, 1).
clique(G, N, PC) :- getVertices(G, V), sublist(PC, V), length(PC, N),  is_clique(G, PC).


%getVertices(+X, -V)
getVertices([], []).
getVertices([(V -> _)|Xs], VL) :- VL = [V|VL1], getVertices(Xs, VL1).



%isEdge(G,U,V) true if UV is edge in G
isEdge(G,U,V) :- member((U -> A),G), member(V,A).

%is_clique(G, V) return true if vertices V 
is_clique(_, []).
is_clique(G, [X|Xs]) :- member((X -> A),G), subset(Xs, A), is_clique(G, Xs).
