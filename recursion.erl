-module(recursion).
-export([find/2, fact/1, fibo/1, binarySearch/2, len/1, reverse/1, duplicate/2, zip/2, quickSort/1, swap/3, partition/4]).

find(List, X)->
	find(1, List, X).
find(I, List, X)->
	if I =< length(List)->
		Y = lists: nth(I, List),
		if X =:=Y -> I; 
			true-> find( I + 1, List, X)
		end;
	true -> "not found"
	end.
	
%% bad code due to growth:
%fact(N)->
%	if N == 0 -> 1;
%		N > 0 ->  N * fact(N -1)
%	end. 

%% using tail recursion
fact(N) -> fact(N, 1).
fact(0, ACC) -> ACC;
fact(N, ACC)-> fact(N - 1, N * ACC).
%% bad code due to growth:
%len([])-> 0;
%len([_|T])-> 1+ len(T).

%% using tail recursion
len(L) -> len(L, 0).
len([_|T], ACC) -> len(T, ACC+ 1);
len([], ACC) -> ACC.

fibo (N) -> 
	if N == 0 -> 1;
		N == 1 -> 1;
		true ->  fibo(N -1) + fibo(N- 2)
	end. 
	

duplicate(N, T)-> duplicate (N, T , []).
duplicate (0, _, List) -> List;
duplicate(N, T, List) -> duplicate(N-1, T, [T|List]).
	

reverse(L) -> reverse(L, []).
reverse([], Lr) -> Lr;
reverse(L, Lr) -> reverse(tl(L), [hd(L)|Lr]).

zip(L1, L2)-> zip(L1, L2, []).
zip([], [], L3) -> reverse(L3);
zip(L1, L2, L3) -> zip(tl(L1), tl(L2), [{hd(L1), hd(L2)}|L3]).	

quickSort([])-> []; 
quickSort([P|_] = L)->
	Len = length(L),
	if Len > 1 ->
		{List, NewPlace} = partition(L, 1, Len, P),
		{L1,[P|L2]} = lists:split(NewPlace - 1 ,List),
		L3 = quickSort(L1),
		L4 = quickSort(L2), 
		L3++ [P] ++L4;
	true -> L
	end.
	
partition(L, Low, High, Pivot)->
	if Low =< High ->
		E1 = lists: nth(Low, L),
		E2 = lists: nth(High, L),
		if (E1 > Pivot) and ( E2 < Pivot) ->
			Lt = swap(L, Low, High), 
			partition( Lt, Low + 1, High - 1, Pivot);
		(E1 >  Pivot) and (E2 >= Pivot) ->
			partition( L, Low, High - 1, Pivot);
		(E1 =<  Pivot) and (E2 < Pivot) -> 
			partition( L, Low + 1, High, Pivot);
		(E1 =<  Pivot) and (E2 >= Pivot) ->
			partition( L, Low + 1, High - 1, Pivot)
		end;
	true -> {swap(L, find(L, Pivot), High), High}
	end.
	
swap(L, I, J)->
	{L2,[F|L3]} = lists:split(I - 1 ,L),
	L4 = L2 ++ [lists: nth( J, L)] ++ L3,
	{L5, [_|L6]} = lists:split(J - 1,L4),
	L5 ++  [F] ++ L6.
	
	

binarySearch(List, X)->
		binarySearch(List, X , 0, length(List)).
binarySearch(List, X , B, E) ->
	M = round((B + E)/2),
	Y =  lists: nth(M, List),
	if (B =/= M) and (E =/= M) ->
		if X =:=Y -> M;
			X > Y -> binarySearch(List, X, M, E);
			X < Y -> binarySearch(List, X, B, M)	
		end;
	true-> 
		if X =:=Y -> M;
			true-> "not in list"
		end
	end.
		
		
	
