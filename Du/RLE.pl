rle([], []).
rle([N], [1-N]).
rle([N, Y|T], [1-N, SCount-Y | R]) :- rle([Y|T], [SCount-Y|R]), N \= Y.
rle([N,N|T], [Count-N|R]) :- rle([N|T], [SCount-N|R]), Count is SCount + 1.


%rle([1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4,1,1,1,1,1], R).