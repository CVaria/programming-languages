 /****************************************************************************************************************************/ 
  /*bazei to stoixeio N stin K thesi tis listas*/
replaceElem([],_,_,[]).
replaceElem([_X|Xs],1,N,[N|Xs]):-!.
replaceElem([X|Xs],K,N,[X|Ys]):- K > 1, K1 is K-1, replaceElem(Xs,K1,N,Ys).
 /*kanei tis 4 peristrofes aristerostrofa*/
createMoveRight(L,1,Result):-
 nth1(1,L,C1),nth1(3,L,C2),nth1(4,L,C3),nth1(6,L,C4),
 replaceElem(L,4,C1,L1),replaceElem(L1,1,C2,L2),replaceElem(L2,6,C3,L3),replaceElem(L3,3,C4,Result).

createMoveRight(L,2,Result):-
 nth1(2,L,C1),nth1(4,L,C2),nth1(5,L,C3),nth1(7,L,C4),
 replaceElem(L,5,C1,L1),replaceElem(L1,2,C2,L2),replaceElem(L2,7,C3,L3),replaceElem(L3,4,C4,Result).

createMoveRight(L,3,Result):-
 nth1(6,L,C1),nth1(9,L,C2),nth1(8,L,C3),nth1(11,L,C4),
 replaceElem(L,9,C1,L1),replaceElem(L1,11,C2,L2),replaceElem(L2,6,C3,L3),replaceElem(L3,8,C4,Result).

createMoveRight(L,4,Result):-
 nth1(7,L,C1),nth1(9,L,C2),nth1(10,L,C3),nth1(12,L,C4),
 replaceElem(L,10,C1,L1),replaceElem(L1,7,C2,L2),replaceElem(L2,12,C3,L3),replaceElem(L3,9,C4,Result).
 
 /*kanei tis 4 peristrofes dexiostrofa*/
createMoveLeft(L,1,Result):-
 nth1(1,L,C1),nth1(3,L,C2),nth1(4,L,C3),nth1(6,L,C4),
 replaceElem(L,4,C4,L1),replaceElem(L1,1,C3,L2),replaceElem(L2,6,C2,L3),replaceElem(L3,3,C1,Result).

createMoveLeft(L,2,Result):-
 nth1(2,L,C1),nth1(4,L,C2),nth1(5,L,C3),nth1(7,L,C4),
 replaceElem(L,5,C4,L1),replaceElem(L1,2,C3,L2),replaceElem(L2,7,C2,L3),replaceElem(L3,4,C1,Result).

createMoveLeft(L,3,Result):-
 nth1(6,L,C1),nth1(9,L,C2),nth1(8,L,C3),nth1(11,L,C4),
 replaceElem(L,9,C4,L1),replaceElem(L1,11,C3,L2),replaceElem(L2,6,C2,L3),replaceElem(L3,8,C1,Result).

createMoveLeft(L,4,Result):-
 nth1(7,L,C1),nth1(9,L,C2),nth1(10,L,C3),nth1(12,L,C4),
 replaceElem(L,10,C4,L1),replaceElem(L1,7,C3,L2),replaceElem(L2,12,C2,L3),replaceElem(L3,9,C1,Result).
/********************************************************************************************************/
  add_to_Queue([],Queue,Queue):-!.
add_to_Queue( [H|T], Queue, Queue, Hash, Hash):- head(H,Head2See),
	get_assoc(Head2See, Hash, 1), !. 
add_to_Queue([H|T], Queue, NewQueue, Hash, NewHash):- head(H, Head2See),
	append([H|T],Queue,NewQueue), put_assoc(Head2See, Hash, 1, NewHash).

head([],[]):-!.
head([H|T],H).

remove_at(X,[X|Xs],1,Xs).
remove_at(X,[Y|Xs],K,[Y|Ys]) :- K > 1, K1 is K - 1, remove_at(X,Xs,K1,Ys),!.  
   
remove_from_Queue(X,Queue,NewQueue):- 
	length(Queue,L),remove_at(X,Queue,L,NewQueue),!.

createNodeLeft([Head,Tail],M,[NewHead,[M|Tail]]):- createMoveLeft(Head,M,NewHead),!.
createNodeRight([Head,Tail],M,[NewHead,[M|Tail]]):- createMoveRight(Head,M,NewHead),!.

add4QueueLeft(Hash,Hash5,Queue,[H,T],NewQueue):- 
	createNodeLeft([H,T],1,N1), createNodeLeft([H,T],2,N2),
	createNodeLeft([H,T],3,N3),	createNodeLeft([H,T],4,N4),
	add_to_Queue([N1],Queue,Q1, Hash, Hash2), 
	add_to_Queue([N2],Q1,Q2, Hash2, Hash3),
	add_to_Queue([N3],Q2,Q3, Hash3, Hash4),
	add_to_Queue([N4],Q3,NewQueue, Hash4, Hash5),!. %, write(a42),!.
	
add4QueueRight(Hash,Hash5,Queue,[H,T],NewQueue):- 
	createNodeRight([H,T],1,N1), createNodeRight([H,T],2,N2),
	createNodeRight([H,T],3,N3),createNodeRight([H,T],4,N4),
	add_to_Queue([N1],Queue,Q1, Hash, Hash2), 
	add_to_Queue([N2],Q1,Q2, Hash2, Hash3),
	add_to_Queue([N3],Q2,Q3, Hash3, Hash4),
	add_to_Queue([N4],Q3,NewQueue, Hash4, Hash5),!. %, write(a42),!.

find_node([H],[H],[]):-!.	
find_node([[H1,T1],[H2,T2]|T], [[H1,T1]|Res], M):- length(T1,K1), length(T2,K1), find_node([[H2,T2]|T], Res,M),!.
find_node([[H1,T1],[H2,T2]|T], [[H1,T1]],[[H2,T2]|T]).

bfs1(_,_,[[98,103,98,71,103,71,71,114,71,121,114,121],Tail],Tail):-!.
bfs1(Hash,Queue1,Queue2,[H,T],Result):- 
	add4Queue(Hash,NewHash,Queue,[H,T],Q1),
	remove_from_Queue(L,Q1,NewQ1), bfs1(NewHash,NewQ1,L,Result).
	
myPrint(A,L):-atomic_list_concat(L, Atom),atom_codes(Atom,A). 
   
diapragmateysi(String,M):-
	empty_assoc(Empty),bfs(Empty,[],[String,[]],Moves),
	reverse(Moves,Moves2),myPrint(M,Moves2),!.