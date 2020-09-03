// summing up the elements of a vector, with an indexing mistake 
#include <iostream>
#include <vector>

using std::cin; 
using std::cout; 
using std::endl; 
using std::vector; 

vector<int> make(int n) {
  vector<int> a; 

  for(int i = 0; i < n; i++) 
    a.push_back(i+1);

  return a; 
}

int main() {
  vector< vector<int> > a;
  vector< int > b; 
  
  b = make(3); 
  a[0] = b;

  for(int i = 0; i < 3; i++) 
    a.push_back(make(i));
  
  //  for(int i = 0; i < 3; i++) 
  cout << a[0][0] << endl; 

  return 0; 
}
