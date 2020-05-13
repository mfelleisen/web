class Min {
    
    static int min(int a[]) { 
	// assert: a.length > 0 
	int m = a[0]; 
	for(int elmnt : a) 
	    m = smaller(elmnt,m);
	// assert: forall(i in [0,a.length){ m <= a[i] }
	//       & exists(i in [0,a.length){ m == a[i] }
	return m; 
    }

    static int smaller(int x, int y) {
	// assert: true
	if (x < y)
	    // assert: x < y 
	    return x; 
	else 
	    // assert: y <= x
	    return y; 
    }

    public static void main(String argv[]) { 
	int a[] = {-3,2,-8};
	int b[] = {-19};
	int c[] = {};
	System.out.println(min(a) + " == -8");
	System.out.println(min(b) + " == -19");
	try {
	    System.out.println(min(c)); 
	}
	catch (ArrayIndexOutOfBoundsException e) {
	    System.out.println("contract!"); 
	}
    }

}
