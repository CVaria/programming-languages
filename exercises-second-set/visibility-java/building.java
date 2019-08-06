public class building implements Comparable<building>{
	private int xsw, ysw, xne, yne;
	private float height;
	
	public building (int x1, int y1, int x2, int y2, float h){
		xsw = x1;
		ysw = y1;
		xne = x2;
		yne = y2;
		height = h;
	}
	
	public int get_xsw(){
		return xsw;
	}
	
	public int get_ysw(){
		return ysw;
	}
	
	public int get_xne(){
		return xne;
	}
	
	public float get_height(){
		return height;
	}
	
	public void print_info(){
		System.out.println("xsw= "+ xsw+" xne= "+xne+ " ysw= "+ysw + " yne= "+yne+ " height= "+height+"\n");
	}
	@Override
		public int compareTo(building build_comp){
			int comp = (build_comp).get_ysw();
			return (this.ysw - comp);
		
		}
	
}