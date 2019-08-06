import java.util.Set;
import java.util.HashSet;
import java.util.Queue;
import java.util.ArrayDeque;

public class BFS{
	public  Node solve (Node initial){
		int count=0;
		//Set<Node> seen = new HashSet<Node>();
		Set<String> seen = new HashSet<String>();
		Queue<Node> myQueue= new ArrayDeque<Node>();
		
		seen.add(initial.getState());
		myQueue.add(initial);
		
		while(!myQueue.isEmpty()){
			Node s = myQueue.remove();
			seen.remove(s);
			if(s.isFinal())
				return s;
			for(int i=1; i<5;i++){
				Node curr = new Node(s, i);
				if(!seen.contains(curr.getState())){
					try{
						seen.add(curr.getState());
						count++;
					   // System.out.println(curr.getState());
						myQueue.add(curr);
					}
					catch (Exception e){
						System.out.println(count);
					}
				}
			}
			
		}
		return null;
		
	}
}