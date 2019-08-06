fun happy fl=   (*sto telos i exigisi*)
	let
		val infile = TextIO.openIn fl
		val a = Option.valOf(TextIO.scanStream (Int.scan StringCvt.DEC) infile)
		val b = Option.valOf(TextIO.scanStream (Int.scan StringCvt.DEC) infile)	

		fun find_sum 730 acc = acc 
			|find_sum x acc =  
		let
			fun check 1 = 1
			|check 10 = 1		(*euresi tou pinaka happy-unhappy me athroismata apo to 1 eos to 279 pou einai i oxi xaroumenoi arithmoi*)
			|check 100 = 1
			|check 4 = 0
			|check 16 = 0
			|check 37 = 0
			|check 58 = 0
			|check 89 = 0
			|check 145 = 0
			|check 42 = 0
			|check 20 = 0
			|check temp_sum = 
			let 
				val a = temp_sum div 100
				val b = (temp_sum mod 100) div 10
				val c = (temp_sum mod 100) mod 10
			in
				check (a*a+b*b+c*c)
			end
		in
			check x :: find_sum (x+1) acc
		end

		val happy_array = Array.fromList (0::(find_sum 1 [])) (*happy-unhappy array[730]*)
	
		fun sum_digit 0 acc = acc
			|sum_digit a acc =
			let 							(*ypologismos athroismatos ton tetragonon ton psifion enos arithmou*)
				val digit = a mod 10
			in
				sum_digit (a div 10) (acc+digit *digit)
			end	

		fun create_arrays s_array x =
		let
	
			fun sum_ten_tho n limit array =
				if (n>limit) then array
				else let									(*bazoume ston array to plithos ton arithmon me to idio athroisma //1 eos 405// apo 1 eos n me max n 100000*)			
				val d = sum_digit n 0
			in
				(Array.update(array, d-1, Array.sub(array,d-1 )+1); sum_ten_tho (n+1) limit array)
			end
		in
			 sum_ten_tho 1 x s_array
		end
		
fun a_billion a =
	(if (a=1000000000) then (a-1) else a)
	
fun check_first a =
	if (a<100000) then (create_arrays (Array.array(405,0)) a)
	else (create_arrays (Array.array(405,0)) (((a_billion a) mod 100000)))
	
fun check_sec a =
	if (a<100000) then (create_arrays (Array.array(324,0)) 0)  (*an o a<100.000 o sum_array2 tha einai midenikos*)
	else (create_arrays (Array.array(324,0)) (((a_billion a) div 100000)-1))
		
	val  sum_array11 = check_first a        (*edo to a*)
	val sum_array12=check_sec a 		
	val  sum_array21 = check_first b        (*edo to b*)
	val sum_array22=check_sec b 
	val  gen_array = check_first 99999
	
		
	fun cal_sum a array405 array324 g_array h_array  =
		let
			fun is_1bil a =	(sum_digit (a div 100000) 0)
					
			
			fun last_loop x a array405 h_array limit acc =
			if (a>limit) then acc
			else Array.sub(array405, a-1)*Array.sub(h_array, a+x )+ last_loop x (a+1) array405  h_array limit acc
			
			fun one_loop a array11 h_array limit acc =
			if (a>limit) then acc
			else Array.sub(array11, a-1)*Array.sub(h_array,a )+ one_loop (a+1) array11  h_array limit acc
	
			fun two_loops a array324 g_array h_array  acc =
				if (a>323) then acc 
				else let
				fun in_loop g_ar ar324 h_ar x acc=
					if (x>405) then acc
					else Array.sub(g_ar,x-1)*Array.sub(ar324,a-1)* Array.sub(h_ar, a+x ) + in_loop g_ar ar324 h_ar (x+1) acc
				in
				(in_loop g_array array324 h_array 1 0) + (two_loops (a+1) array324 g_array h_array acc)
				end
		in	
		
		if (a<100000) then (one_loop 1 array405 happy_array 405 0)
		else ((one_loop 1 g_array h_array 405 0)+ (last_loop (is_1bil a) 1 array405 h_array 405 0)+ (Array.sub(h_array, (is_1bil a))+ one_loop 1 array324 h_array 324 0) +(two_loops 1 array324 g_array h_array 0))
		
		end
		
	fun limit_correction a num =
		if (a=1000000000) then (num+1) else num
		
		
in 	
	((limit_correction b (cal_sum (a_billion b) sum_array21 sum_array22 gen_array happy_array))-(limit_correction a (cal_sum (a_billion a) sum_array11 sum_array12 gen_array happy_array))+Array.sub(happy_array,(sum_digit a 0)))

end;

(*xorizoume tous arithmous se 5 kai 4 psifia px to 891234132 ginetai 8912 kai 34132, dimiourgoume 2 pinakes :enan 405 theseon (giati max athroisma tou 100.000 = 9^2*5=405) kai enan 324 theseon*)
(*ayto to kanoume gia ta a, b diladi dimiourgoume 4pinakes (2*405*4+2*4*324=5832byte) kai enan epipleon pinaka general_array (405 theseon) gia esoterikous ypologismous*)
(*stous pinakes aytous apothikeyetai to plithos ton arithmon me to idio athroisma px array[56]=43 simainei oti 43 arithmoi exoun athroisma 56*)
(*me aytous tous pinakes kanoume basika ena diplo loop 324x405 (kai 2 epipleon loops (last_loop, one_loop me ton general_array) gia na bgei sosto apotelesma)*)
(*me ayto ton tropo upologizoume tous happy arithmous se 2 diasthmata [1,a], [1,b] kai kanoume analogws tin afairesh*)
(*gia tous happy_numbers exoume enan happy_array 730 theseon kai mia lista (boleye stin ulopoiish) ara 730*4*2=5840bytes*)
