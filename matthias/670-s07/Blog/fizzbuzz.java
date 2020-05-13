class Main {
    public static void main(String argv[]) {
	for(int i = 1; i <= 100; i++) { 
	    if (multiple(i,3) && multiple(i,5))
		System.out.println("FizzBuzz");
	    else if (multiple(i,3)) 
		System.out.println("Fizz");
	    else if (multiple(i,5)) 
		System.out.println("Buzz");
	    else 
		System.out.println(i);
	}
    }
    
    // is m a multiple of n? 
    public static boolean multiple(int m, int n) { 
	return (m % n) == 0; 
    }
}
