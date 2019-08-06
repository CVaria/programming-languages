public class Diapragmateysi {
	public static void main(String args[]){
		BFS solver;
		solver = new BFS();
		Node initial = new Node(args[0],"");
		Node result = solver.solve(initial);
		if(result == null)
			System.out.println("problem");
		else
			printNode(result);
		
	}
	
	private static void printNode(Node s){
		System.out.println(s.getMovement());
	}
}