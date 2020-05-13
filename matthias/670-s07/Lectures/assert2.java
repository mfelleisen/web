class Cons {
    private int  fst; 
    private Cons rst; 
    public Cons(int fst, Cons rst) { 
	this.fst = fst; 
	this.rst = rst; 
    }

    // find the minimum number on this list 
    public int min() { 
	int m; 
	if (null != this.rst)
	    m = smaller(this.fst,this.rst.min()); 
	else 
	    m = this.fst; 
	// assert: forall(i in Nat) { m <= this.rest^i().first() }
	//       & exists(i in Nat) { m = this.rest^i().first() }
	return m; 
    }

    private static int smaller(int x, int y) {
	if (x < y)
	    return x; 
	else 
	    return y; 
    }
    
    // effect: strange 
    public void set(Cons nxt) {
	this.rst = nxt; 
    }
}

class Main2 {
    public static void main(String argv[]) { 
	Cons mt = null; 
	Cons c1 = new Cons(+1,mt); 
	Cons c2 = new Cons(-1,c1); 

	System.out.println(c2.min() + " == -1");

	try {
	    c2.set(c2);
	    System.out.println(c2.min() + " == -1");
	}
	catch (StackOverflowError e) { 
	    System.out.println("contract!");
	}
    }
}

