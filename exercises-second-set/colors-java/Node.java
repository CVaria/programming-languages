public class Node {
	private final String solution = "bgbGgGGrGyry";
	private String state;
	private String movements;
	
	public Node(String s, String m){
			state = s;
			movements = m;
	}
	
	public Node (Node n, int b){
			String a = n.getState();
			String m = n.getMovement();
			String c="";
			String d="";
	switch(b){
		case 1: 
			 c = new StringBuilder().append(a.charAt(2)).append(a.charAt(1)).append(a.charAt(5)).append(a.charAt(0)).append(a.charAt(4)).append(a.charAt(3)).append(a.substring(6)).toString();
			 d = m +"1"; 
			break;
		case 2:
			c = new StringBuilder().append(a.charAt(0)).append(a.charAt(3)).append(a.charAt(2)).append(a.charAt(6)).append(a.charAt(1)).append(a.charAt(5)).append(a.charAt(4)).append(a.substring(7)).toString();
			 d = m + "2";
			break;
		case 3:
			c = new StringBuilder().append(a.substring(0,5)).append(a.charAt(7)).append(a.charAt(6)).append(a.charAt(10)).append(a.charAt(5)).append(a.charAt(9)).append(a.charAt(8)).append(a.charAt(11)).toString();
			 d = m+"3";
			break;
		case 4:
			c = new StringBuilder().append(a.substring(0,6)).append(a.charAt(8)).append(a.charAt(7)).append(a.charAt(11)).append(a.charAt(6)).append(a.charAt(10)).append(a.charAt(9)).toString();
			d = m + "4"; 
			break;
	}
		state = c;
		movements = d;
	}
	
	public boolean isFinal(){
		return ((this.state).equals(solution));
	}
	
	public String getMovement(){
		return movements;
	}
	
	public String getState(){
		return state;
	}
	
	
}