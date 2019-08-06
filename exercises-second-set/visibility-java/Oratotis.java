import java.io.*;
import java.util.ArrayList;
import java.util.SortedSet;
import java.util.TreeSet;

public class Oratotis {
	public static void main(String args[]){
		int buildNum;
		int x1, x2, y1, y2;
		float height;
		SortedSet<Integer> xs = new TreeSet<Integer>();
		ArrayList<building> myList = new ArrayList<building>();
		try{
			FileReader  file = new FileReader(args[0]);
			BufferedReader bf = new BufferedReader(file);
			buildNum = Integer.parseInt(bf.readLine());

			for (int i=0; i< buildNum; i++){
				String[] line = bf.readLine().split(" ");
				x1 = Integer.parseInt(line[0]);
				y1 = Integer.parseInt(line[1]);
				x2 = Integer.parseInt(line[2]);
				y2 = Integer.parseInt(line[3]);
				height = Float.parseFloat(line[4]);
				xs.add(x1);
				xs.add(x2);

				building node = new building(x1, y1, x2, y2, height);
				myList.add(node);
			}
			Integer[] intervals = xs.toArray(new Integer[xs.size()]);
	
			Solver x = new Solver();
			System.out.println(x.solution(myList, intervals));
		}
		catch (IOException e){
			System.out.println("Error: "+ e.toString());
		}
	}
}