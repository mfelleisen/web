#include <algorithm>
#include <iomanip>
#include <ios>
#include <iostream>
#include <string>
#include <vector>

using std::cin; 
using std::cout; 
using std::endl; 
using std::sort; 
using std::streamsize; 
using std::string; 
using std::vector; 
using std::setprecision; 

int main() {

  // ask for and read the student's name
  cout << "Please enter your first name: "; 
  string name; 
  cin >> name; 
  cout << "Hello, " << name << "!" << endl; 

  // ask for and read the midterm and final grades 
  cout << "Please enter your midterm and final exam grades: "; 
  double midterm, final; 
  cin >> midterm >> final; 

  // ask for and read the homework grades 
  cout << 
    "Enter all your homework grades, "
    "followed by the end of file: ";
  double x;
  vector<double> homework; 
  typedef vector<double>::size_type vec_sz;
  vec_sz size = homework.size();

  while (cin >> x)
    homework.push_back(x);
  
  // check that the student entered some homework grades 
//   if (size == 0) {
//     cout << endl << "You must enter some homework grades";
//     return 1; 
//   } 
//   else {
    // compute the median homework grade 
    sort(homework.begin(), homework.end()); 
    vec_sz mid = size / 2;
    double median; 
    median = size % 2 == 0
      ? (homework[mid] + homework[mid-1]) / 2
      : homework[mid];
    
    // compute and write the final grade 
    streamsize prec = cout.precision();
    cout << "Your final grade is " << setprecision(3)
	 << 0.2 * midterm + 0.4 * final + 0.4 * median 
	 << setprecision(prec) << endl; 

    return 0; 
//  }
}


