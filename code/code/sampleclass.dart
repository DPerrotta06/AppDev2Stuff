class Student {
  var stdName;
  var stdAge;
  var stdRoll_no;
  // constructor
  Student(String msg) {
    print('I want to access a message from the child constructor');
    print(msg);
  }
  showinfo() {
    print('name : ${stdName}');
    print('Age : ${stdAge}');
    print('Roll no : ${stdRoll_no}');
  }
}
class VanierStudent extends Student{
  VanierStudent() : super('this is where I am sending the value to the parent class') {
    print(' I am running in child class');
  }
  showinfo() {
    super.showinfo();
    print('I am not working here');
    print('I cant display');
    print('OH no, ');
  }
}
void main() {
//  Student s = new Student();
  VanierStudent s = VanierStudent();
  s.stdName = 'Peter';
  s.stdAge = 17;
  s.stdRoll_no = 23658;
  s.showinfo();
}
