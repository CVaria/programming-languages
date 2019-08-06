fun danger fp =
let
	val file = TextIO.openIn fp
	fun read_int fl = getOpt (TextIO.scanStream (Int.scan StringCvt.DEC) fl, 0)
		
	val N = read_int file
	val M = read_int file
	
	
	fun read_text i limit_m array_list = 
		if (i>limit_m) then array_list 
		else let
			val newline = TextIO.inputLine file											(*Dimiourgia pinaka liston*)
			val limit_k = read_int file
			fun read_line  j array_l =
				if (j>limit_k) then ()
				else (Array.update(array_l, i-1, (read_int file :: Array.sub(array_l,i-1))); read_line (j+1) array_l)
		in
				(read_line 1 array_list ;read_text (i+1) limit_m array_list )
		end
																				
(************************************************************************************************************************************************************************)
fun bubblesort array1 i limit =						(*taxinomisi tou pinaka liston os pros to mikos tis listas se ayxousa seira*)
	if i > (limit-1) then array1
	else let
		fun in_loop j = if j > (limit  - i) then ()
								else 
								let
									val a = Array.sub (array1, j-1)
								in
									if (length (Array.sub (array1,j-1)) > length (Array.sub(array1, j))) then 
										(Array.update(array1,j-1, Array.sub(array1,j));(Array.update(array1,j,a)); in_loop (j+1))
									else (in_loop (j+1))
								end
		in
			((in_loop 1); bubblesort array1 (i+1) limit)
		end;
		
	val current_array = bubblesort (read_text 1 M (Array.array(M,[]):int list array)) 1 M
(**************************************************************************************************************************************************************************)	
	type Node = {dangers : int array, measures : int array, remaining : int} (*orismos kombou ouras*)

	fun create (node:Node) = 
	let
		val rem = #remaining node;
		val mea = #measures node;
		val dan = #dangers node;									(*dimiourgia neou kombou gia tin oura*)

		fun create_node (dangers, measures, remaining)=
		let
			val copy_dangers = Array.array(M,1)
			val copy_measures = Array.array(N,1)
			val _ = Array.copy ({di=0,src = dangers, dst = copy_dangers})
			val _ = Array.copy ({di =0, src = measures, dst = copy_measures})
		in 
			{dangers = copy_dangers, measures = copy_measures, remaining = remaining}
		end
	in 
		create_node (dan, mea, rem)
	end

	fun fix_node (n:Node) measure combo = (Array.update(#dangers n, combo-1, 0); Array.update(#measures n, measure-1,0);
	{dangers = #dangers n, measures = #measures n, remaining = (#remaining n - 1)})


	val my_queue = Queue.mkQueue():(Node)Queue.queue
	fun push (q:Node Queue.queue, n :Node) = Queue.enqueue (q,n)		(*synarthseis ouras*)
	fun pop (q: Node Queue.queue) = Queue.dequeue q
	
	val basic_node = {dangers = Array.array(M,1), measures = Array.array (N,1), remaining = M} (*kanei tin arxi tis ouras alla den einai aparaithth h dipli antigrafi ton pinakon*)
	

(***********************************************************************************************************************************************************************************)


 fun bfs (head_node:Node) = if ((#remaining head_node) =0) then (#measures head_node)
	else 
		let
		val danger = #dangers head_node
		val nothing = #remaining head_node
		fun find_min2 i true array1 acc = acc
			|find_min2 i false array1 acc = if (Array.sub(array1,i-1) = 1 ) then (find_min2 (i+1) true array1 i) else find_min2 (i+1) false array1 acc
		val minimum2 = find_min2 1 false danger 100 (*to max length einai 42*)
	
		val row = Array.sub (current_array, minimum2 -1)

		fun check_list c_list =  if (null c_list) then () else
			let																										(*exo mia lista - syndyasmo kai exetazo 1-1 ta stoixeia tis*)
				val new_node = create (head_node)																	(*gia kathe stoixeio tsekaro ton pinaka dedomenon syndyasmon moy*)
				val num = hd c_list																					(*an o pinakas periexei to stoixeio sto neo kombo pou*)
				fun search_combo number arr i limit new_node = 														(*dimiourgo diagrafo ton antistoixo syndyasmo gia to *)
				if (i>limit) then new_node																			(*antistoixo metro. Otan exetaso olous tous epizontes*)
				else let																							(*syndyasmous gia ena stoixeio bazo to neo kombo stin oura*)
					fun search_num number nil acc = acc																(*epanalambano gia ola ta stoixeia tis listas*)
					|search_num number (h::t) acc = if (h = number) then (search_num number nil (fix_node acc number (i))) else (search_num number t acc)
				in
					if (Array.sub (danger,i-1) = 0) then (search_combo number arr (i+1) limit new_node) 
					else (search_combo number arr (i+1) limit (search_num number (Array.sub (arr ,i-1)) new_node))
				end
			in
				(push (my_queue, search_combo num current_array 1 M new_node ); check_list (tl c_list))
			end
	in (check_list row; bfs (pop(my_queue)))
	end	

	fun make_solution arr i acc =								(*briskei poia metra apemeinan apo to bfs*)
	if (i>N) then rev acc
		else if(Array.sub(arr,i-1)=0) then (make_solution arr (i+1) acc) 
			else (make_solution arr (i+1) (i::acc));

	(*fun all_numbers_dangerous arr = if ( length (Array.sub (arr,M-1))= N) then true else false;	mporei kapoios syndyasmos na exei ola ta metra*)

in
	(push(my_queue, basic_node);
 (make_solution (bfs basic_node) 1 []))
end;
	
	

	
	