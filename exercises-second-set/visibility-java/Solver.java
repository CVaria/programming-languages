import java.util.ArrayList;
import java.util.Collections;
import java.util.Arrays;
public class Solver{
	public int solution(ArrayList<building> build_list, Integer[] xs){
		float[] heights;
		int result=0;
		building temp;
		boolean visited;
		float ypsos;
		int position_start, position_end;
		Collections.sort(build_list);
		/*for(int k=0; k<build_list.size(); k++){
			System.out.println("building# "+k+ " xsw= "+build_list.get(k).get_xsw()+" xne= "+build_list.get(k).get_xne());
		}*/
		heights = new float[xs.length];
		for(int j=0; j< build_list.size(); j++){
			temp = build_list.get(j);
			visited=false;
			ypsos = temp.get_height();
			position_start= Arrays.binarySearch(xs, (temp.get_xsw()));
			position_end = Arrays.binarySearch(xs, (temp.get_xne()));
			for(int i=position_start; i< position_end; i++){
				if(heights[i]< ypsos){
					heights[i] = ypsos;
					visited = true;
				}
			}
			if(visited) result++;
		}
		
		return result;
	}
}