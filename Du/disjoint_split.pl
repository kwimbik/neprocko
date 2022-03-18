%(?L, ?M, ?N) true if L can be split into the two disjoint subsequences M and N
split([],[],[]) :- !.
split([L|Ls],[L|Ms],N) :- split(Ls,Ms,N).
split([L|Ls],M,[L|Ns]) :- split(Ls,M,Ns).