structure IntKey =
	struct
	type ord_key = Int.int
	val compare = Int.compare
	end
	structure IntMap = RedBlackMapFn(IntKey)
	
fun oratotis file_p =
let
	type Node ={xsw:int, ysw:int, xne:int, yne:int, height:real}
	fun create_node (x1, y1, x2, y2, h) = ({xsw = x1, ysw = y1, xne = x2, yne =y2, height = h} :Node)
	fun find_min x1 xmin = if (x1< xmin) then x1 else xmin
	fun find_max x2  xmax = if (x2 > xmax) then x2 else xmax	
	
	val emptymap  = (IntMap.empty)
	val curmap = ref (IntMap.insert(emptymap,~5,~5))
	
	fun read_file fp =
	let
		val i_list = []
		val file = TextIO.openIn fp
		fun read_int fl = getOpt(TextIO.scanStream(Int.scan StringCvt.DEC) fl, 0)
		fun read_real fl = Option.valOf(TextIO.inputLine fl)
	
		val buildings = read_int file
		val _= TextIO.inputLine file
		fun read_text 0 (xmin, xmax,(b_list: Node list),l )   =(TextIO.closeIn file;(xmin, xmax,b_list,l))
			|read_text i (xmin, xmax,(b_list : Node list),l)   =
				let 
					val x1 = read_int file
					val y1 = read_int file							(*diabasma arxeiou*)
					val x2 = read_int file
					val y2 = read_int file
					val h =Option.getOpt( Real.fromString(read_real file),0.0)
				in
					(read_text (i-1)  ((( find_min x1 xmin), (find_max x2 xmax),(create_node(x1, y1, x2, y2, h)::b_list),x1::x2::l)))
				end
	in
		(read_text buildings (valOf(Int.maxInt),0,[],i_list) )
	end

	val ( xmin,xmax, basic_list,inter) = read_file file_p

(************************************************************************************************************************************)
(*ulopoihsh mergesort gia ti lista mas me basi to ktirio pou einai pio konta ston x'x, se ayxoysa seira*)
(*ulopoihsh apo diafaneies*)
	fun halve nil = (nil, nil)
		|halve [a] = ([a], nil)
		|halve (a::b::cs) =
			let
				val (x,y) = halve cs	
			in
				(a::x, b::y)
			end
		
	fun merge (nil, ys) = (ys : Node list)			(*gia tin taxinomisi ton kombon*)
		|merge(xs, nil) = xs
		| merge (x::xs, y::ys) =
			let
				val apostash1 = #ysw x
				val apostash2 = #ysw y
			in
				if apostash1 < apostash2 then x:: merge (xs, y::ys)
										else y :: merge (x::xs, ys)
			end
	
			
	fun mergeSort nil = nil
		|mergeSort [a] =[a]
		|mergeSort theList =
			let	
				val (x,y) = halve theList
			in
				merge(mergeSort x, mergeSort y)
			end

	val sort_list = mergeSort basic_list
	val intervals = Array.fromList(ListMergeSort.uniqueSort (fn (x,y) => if (x=y) then EQUAL else if (x>y) then GREATER else LESS) inter) (*gia taxinomisi kai dimiourgia ton diasthmaton*)

(******************************************************************************************************************************************************)
	val Heights = Array.array(Array.length intervals, 0.0) (*pinakas apothikeysis tou upsous kathe ktiriou*)
	val num =0
	
fun make_map i limit  arr =
		if (i>=limit) then () 
		else (curmap:=(IntMap.insert(!curmap,Array.sub(arr,i),i));make_map (i+1) limit arr)
		
	val _ = make_map 0 (Array.length intervals) intervals
		
	fun update_arr [] x_arr num = num
	|update_arr (n_list : Node list) x_arr  num =
	let 
	
		fun check_height arr num =
			let
				val node = hd n_list
				val limit = #xne node
				val start = #xsw node
				val n_h = #height node
			
				val index1 = getOpt(IntMap.find(!curmap,start),~1) (*briskoume ton index tou xsw ston pinaka intervals*)
				val index2 = getOpt(IntMap.find(!curmap,limit),~1)
				val visited = false
		
				fun update_xs j x_arr h_arr  limit height f =		(*ananeonoume ton pinaka Heights gia to diasthma [xsw, xne)*)
					if(j>=limit) then f 
					else let
							val element = Array.sub (h_arr, j)
						in
							if(element < height) then ( Array.update(h_arr,j,height); update_xs (j+1) x_arr h_arr limit height true ) else (update_xs (j+1) x_arr h_arr limit height f)
						end	
			in
				if (update_xs index1 intervals Heights  index2 n_h false) then (num+1) else num
			end	
	in 
		update_arr (tl n_list) x_arr (num +(check_height Heights 0))
	end
in
 update_arr sort_list intervals 0 
end