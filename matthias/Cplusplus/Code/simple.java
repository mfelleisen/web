// multiplying the elements of a vector, with an indexing mistake 
class Main {

  public static void main(String argv[]) {
    int a[] = {1,2,3};
    int sum = 0; 

    for(int i = 0; i <= 3; i++)
      sum *= a[i];

    System.out.println(sum + " = 6"); 
  }
}


