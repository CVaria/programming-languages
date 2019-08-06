addf(X,Y,M):-M is X+Y.
subf(X,Y,M):-M is X-Y.
mulf(X,Y,M):-M is X*Y.
divf(X,Y,M):-M is X/Y.

combinations(X,Y,L):- A is X+Y, S is X-Y, M is X*Y,(Y=:=0->append([A,S],[M],L);D is X/Y,append([A,S],[M,D],L)).


find_digits(X,1):- X < 10.
find_digits(X,L):-  X1 is  X div 10, find_digits(X1,L1),L is L1+1.


parts(C, [C]).
parts(L, Ps) :-
    append(H, T, L), H \= [], T \= [],
    parts(T, Ts),
    append([H], Ts, Ps).
	
concat(Num,Result):- number_codes(Num,L), parts(L,Ls), maplist(number_codes,Result,Ls).

make_rationals([],[]).
make_rationals([H|T],[M|Result]):- M is rationalize(H),make_rationals(T,Result). 

help_combos([],_L,[]):-!.
help_combos(_L,[],[]):-!.
help_combos([H1],[H2|T1],L):- combinations(H1,H2,L1), help_combos([H1],T1,L2), append(L1,L2,L),!.
help_combos([H1|T1],L,R):- help_combos([H1],L,R1), help_combos(T1,L,R2), append(R1,R2,R),!.

/*breakList([], [], []).
breakList([X,Y], [X], [Y]):-!.
breakList([H|T], [H],T). %:- length(T,N),N>0.
breakList([H|T], [H|P1], P2):- breakList(T, P1, P2).*/

find_comb([],[]):-!.
find_comb([H],[H]):-!.
find_comb(L1,L):- break_list(L1,H,T), find_comb(H,H1), find_comb(T,T1), help_combos(H1,T1,L). 

break_list([],[],[]).
break_list([H],[H],[]).
break_list(H,X,Y):- append(X,Y,H), length(X,K1),K1>0, length(Y,K2),K2>0.


/*pre_find_comb(L1, L):- findall(L, find_comb(L1,L), L).*/

result([100]):-!.
result(L):- break_list(L,L1,L2), find_comb(L1,K1),find_comb(L2,K2),help_combos(K1,K2,R),member(100, R),!.

number1(9000000000,true):-!.
number1(8000000000,true):-!.
number1(7000000000,true):-!.
number1(6000000000,true):-!.
number1(5000000000,true):-!.
number1(4000000000,true):-!.
number1(3000000000,true):-!.
number1(2000000000,true):-!.
number1(X, false):- concat(X,L1), make_rationals(L1, L2), result(L2),!.
number1(_, true).

lucky_numbers([],[]).
lucky_numbers([H|T], [X|Xs]):- number1(H, X), lucky_numbers(T, Xs).

