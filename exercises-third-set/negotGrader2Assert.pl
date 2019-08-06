:- dynamic myExists/1.%adds myExists

/*bazei to stoixeio N stin K thesi tis listas*/
replaceElem([],_,_,[]).
replaceElem([_X|Xs],1,N,[N|Xs]):-!.
replaceElem([X|Xs],K,N,[X|Ys]):- K > 1, K1 is K-1, replaceElem(Xs,K1,N,Ys).

 /*kanei tis 4 peristrofes*/
createMove(L,1,Result):-
	nth1(1,L,C1),nth1(3,L,C2),nth1(4,L,C3),nth1(6,L,C4),
	replaceElem(L,4,C1,L1),replaceElem(L1,1,C2,L2),
	replaceElem(L2,6,C3,L3),replaceElem(L3,3,C4,Result),!.

createMove(L,2,Result):-
	nth1(2,L,C1),nth1(4,L,C2),nth1(5,L,C3),nth1(7,L,C4),
	replaceElem(L,5,C1,L1),replaceElem(L1,2,C2,L2),
	replaceElem(L2,7,C3,L3),replaceElem(L3,4,C4,Result),!.

createMove(L,3,Result):-
	nth1(6,L,C1),nth1(9,L,C2),nth1(8,L,C3),nth1(11,L,C4),	
	replaceElem(L,9,C1,L1),replaceElem(L1,11,C2,L2),
	replaceElem(L2,6,C3,L3),replaceElem(L3,8,C4,Result),!.

createMove(L,4,Result):-
	 nth1(7,L,C1),nth1(9,L,C2),nth1(10,L,C3),nth1(12,L,C4),
	 replaceElem(L,10,C1,L1),replaceElem(L1,7,C2,L2),
	 replaceElem(L2,12,C3,L3),replaceElem(L3,9,C4,Result),!.

/***prosthiki kombou stin oura***/
add_to_Queue([],Queue,Queue).
%add_to_Queue( [H|T], Queue, NewQueue):- append([H|T],Queue,NewQueue).
add_to_Queue([H|T], Queue, NewQueue):-	
	head(H, Head2Assert), \+myExists(Head2Assert), 
	assert(myExists(Head2Assert)), append([H|T],Queue,NewQueue),!.
add_to_Queue(_, Queue, Queue).
%:-a write(a42).

remove_at(X,[X|Xs],1,Xs):-!.
remove_at(X,[Y|Xs],K,[Y|Ys]) :- K > 1, K1 is K - 1, remove_at(X,Xs,K1,Ys).  
   
remove_from_Queue(X,Queue,NewQueue):-
    	length(Queue,L),remove_at(X,Queue,L,NewQueue),!.

createNode([Head,Tail],M,[NewHead,[M|Tail]]):- 
	createMove(Head,M,NewHead).

head([],[]):-!.
head([H|T],H).

add4Queue(Queue,[H,T],NewQueue):- 
%	not(myExists(H)),write(H),
	createNode([H,T],1,N1),createNode([H,T],2,N2),
	createNode([H,T],3,N3),createNode([H,T],4,N4),
	add_to_Queue([N1],Queue,Q1), add_to_Queue([N2],Q1,Q2),
	add_to_Queue([N3],Q2,Q3),add_to_Queue([N4],Q3,NewQueue),!.

%add4Queue(Queue, _Node, Queue):- write(a42).
  
bfs(_,[[98,103,98,71,103,71,71,114,71,121,114,121],Tail],Tail):-!.
bfs(Queue,[H,T],Result):- 
	add4Queue(Queue,[H,T],Q1),remove_from_Queue(L,Q1,NewQ1),
	bfs(NewQ1,L,Result).
    
myPrint(A,L):-
	atomic_list_concat(L, Atom),atom_codes(Atom,A). 
   
diapragmateysi(String,M):-
	bfs([],[String,[]],Moves),reverse(Moves,Moves2),myPrint(M,Moves2),!.
