import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TutorMate'),
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    labelStyle: TextStyle(color: Colors.yellowAccent),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    labelStyle: TextStyle(color: Colors.yellowAccent),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RoleSelectionPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Sign Up', style: TextStyle(fontSize: 24, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    labelStyle: TextStyle(color: Colors.yellowAccent),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    labelStyle: TextStyle(color: Colors.yellowAccent),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RoleSelectionPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Login', style: TextStyle(fontSize: 24, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoleSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Role Selection Page'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.greenAccent],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateClassPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Teacher', style: TextStyle(fontSize: 24, color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Removed the reference to JoinClassPage
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => JoinClassPage()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Student', style: TextStyle(fontSize: 24, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class CreateClassPage extends StatefulWidget {
  @override
  _CreateClassPageState createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  List<StudentInfo> students = [];

  Future<void> _showDatePickerForStudent(BuildContext context, StudentInfo student) async {
    int? selectedClasses = await Navigator.push<int?>(
      context,
      MaterialPageRoute(builder: (context) => DatePickerPage(student.numberOfClasses)),
    );

    if (selectedClasses != null) {
      setState(() {
        student.classesCount = selectedClasses;
      });
    }
  }

  Future<StudentInfo?> _showAddStudentDialog(BuildContext context) async {
    String className = '';
    String studentEmail = '';
    int numberOfClasses = 1;

    return await showDialog<StudentInfo>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Student'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    className = value;
                  },
                  decoration: InputDecoration(labelText: 'Student Name'),
                ),
                TextField(
                  onChanged: (value) {
                    studentEmail = value;
                  },
                  decoration: InputDecoration(labelText: 'Student Email'),
                ),
                TextField(
                  onChanged: (value) {
                    numberOfClasses = int.tryParse(value) ?? 1;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Number of Classes'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(StudentInfo(
                  className: className,
                  studentEmail: studentEmail,
                  numberOfClasses: numberOfClasses,
                ));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPaymentTrackingDialog(StudentInfo student) async {
    bool isPaymentDue = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment of ${student.className}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<bool>(
                title: const Text('Due'),
                value: true,
                groupValue: isPaymentDue,
                onChanged: (bool? value) {
                  setState(() {
                    isPaymentDue = value ?? false;
                  });
                },
              ),
              RadioListTile<bool>(
                title: const Text('Not Due'),
                value: false,
                groupValue: isPaymentDue,
                onChanged: (bool? value) {
                  setState(() {
                    isPaymentDue = value ?? false;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Here you can update the payment due status for the student
                // based on the value of isPaymentDue.
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }



  void _deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Class Page'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.greenAccent],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  StudentInfo? newStudent = await _showAddStudentDialog(context);
                  if (newStudent != null) {
                    setState(() {
                      students.add(newStudent);
                    });
                  }
                },
                child: Text('Add Student',style: TextStyle(fontSize: 24, color: Colors.redAccent)),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(students[index].className,style: TextStyle(fontSize: 24, color: Colors.yellow),),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _showPaymentTrackingDialog(students[index]);
                            },
                            child: Text('Payment Info'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              _deleteStudent(index);
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                      onTap: () {
                        _showDatePickerForStudent(context, students[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentInfo {
  final String className;
  final String studentEmail;
  final int numberOfClasses;
  int classesCount;

  StudentInfo({
    required this.className,
    required this.studentEmail,
    required this.numberOfClasses,
    this.classesCount = 0,
  });
}
class DatePickerPage extends StatefulWidget {
  final int maxClasses;

  DatePickerPage(this.maxClasses);

  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  late List<DateTime?> selectedDates;

  @override
  void initState() {
    super.initState();
    selectedDates = List.generate(widget.maxClasses, (index) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Class Dates'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.greenAccent],
          ),
        ),
        child: ListView.builder(
          itemCount: widget.maxClasses,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blue,
              child: ListTile(
                title: Text(
                  'Class ${index + 1} Date',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  selectedDates[index] != null
                      ? DateFormat('dd-MM-yy').format(selectedDates[index]!)
                      : 'Not selected',
                  style: TextStyle(color: Colors.yellow),
                ),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );

                  if (selectedDate != null) {
                    setState(() {
                      selectedDates[index] = selectedDate;
                    });
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}






