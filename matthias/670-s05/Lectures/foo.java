class Amount {
    // convert the amount into a check-style string 
    // with dollars and cents separated by a dot 
    String print() {
	String s = "abc";
	s.toVector()[(s.length() - 1)] = '.';
	return s; 
    }

    public static void main(String argv[]) {
	Amount a = new Amount(); 
	System.out.println(a.print());
    }
}
