// multiplying the elements of an array, with an indexing mistake 
#include <iostream>

using std::cin; 
using std::cout; 
using std::endl; 

int main() {
  int a[3] = {1,2,3};
  int sum = 1; 

  for(int i = 0; i <= 3; i++)
    sum *= a[i];

  cout << sum << " = 6" << endl; 

  return 0; 
}
