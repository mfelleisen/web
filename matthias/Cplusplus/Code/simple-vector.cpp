// summing up the elements of a vector, with an indexing mistake 
#include <iostream>
#include <vector>

using std::cin; 
using std::cout; 
using std::endl; 
using std::vector; 

int main() {
  int prod = 0; 
  vector<int> a;
  
  for(int i = 0; i < 3; i++)
    a.push_back(i+1);

  for(int i = 0; i <= 3; i++) {
    cout << a[i] << endl; 
    prod = prod * a[i];
  }

  cout << prod << endl; 

  return 0; 
}
