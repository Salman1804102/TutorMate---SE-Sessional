import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateClassPage extends StatefulWidget {
  @override
  _CreateClassPageState createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  List<StudentInfo> students = [];

  @override
  void initState() {
    super.initState();
    // Load students from SharedPreferences when the widget is first created
    _loadStudentsFromSharedPreferences();
  }

  void _loadStudentsFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? studentsData = prefs.getStringList('students');

    if (studentsData != null) {
      List<StudentInfo> loadedStudents = studentsData
          .map((studentString) => StudentInfo.fromSharedPreferences(studentString))
          .toList();

      setState(() {
        students = loadedStudents;
      });
    }
  }

  Future<void> _saveStudentsToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> studentsData = students.map((student) => student.toSharedPreferences()).toList();
    prefs.setStringList('students', studentsData);
  }

  Future<void> _showDatePickerForStudent(BuildContext context, StudentInfo student) async {
    List<DateTime?>? selectedDates = await Navigator.push<List<DateTime?>>(
      context,
      MaterialPageRoute(builder: (context) => DatePickerPage(student.numberOfClasses, student.selectedDates)),
    );

    if (selectedDates != null) {
      setState(() {
        student.selectedDates = selectedDates;
      });
      // Save students to SharedPreferences after selecting dates
      await _saveStudentsToSharedPreferences();
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
              onPressed: () async {
                StudentInfo newStudent = StudentInfo(
                  className: className,
                  studentEmail: studentEmail,
                  numberOfClasses: numberOfClasses,
                );

                setState(() {
                  students.add(newStudent);
                });

                // Save students to SharedPreferences
                await _saveStudentsToSharedPreferences();

                Navigator.of(context).pop(newStudent);
              },
              child: Text('OK'),
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

    // Save students to SharedPreferences after deletion
    _saveStudentsToSharedPreferences();
  }

  Future<void> _showPaymentTrackingDialog(StudentInfo student) async {
    bool isPaymentDue = student.isPaymentDue;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                  onPressed: () async {
                    // Update payment due status for the student
                    student.isPaymentDue = isPaymentDue;
                    await _saveStudentsToSharedPreferences();
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
      },
    );
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
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  StudentInfo? newStudent = await _showAddStudentDialog(context);
                  // Handle the new student if needed
                },
                child: Text('Add Student', style: TextStyle(fontSize: 29, color: Colors.redAccent)),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(students[index].className, style: TextStyle(fontSize: 25, color: Colors.yellow),),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _showPaymentTrackingDialog(students[index]);
                            },
                            child: Text('Payment Info',style:TextStyle(fontSize:18,color: Colors.blue ),),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              _deleteStudent(index);
                            },
                            child: Text('Delete',style:TextStyle(fontSize:18,color: Colors.blue ),),
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
  List<DateTime?> selectedDates;
  bool isPaymentDue;

  StudentInfo({
    required this.className,
    required this.studentEmail,
    required this.numberOfClasses,
    this.classesCount = 0,
    List<DateTime?>? selectedDates,
    this.isPaymentDue = false,
  }) : this.selectedDates = selectedDates ?? List.generate(numberOfClasses, (index) => null);

  // Convert the student information to a string for SharedPreferences
  String toSharedPreferences() {
    String datesString = selectedDates.map((date) => date?.toIso8601String() ?? '').join(',');
    return '$className|$studentEmail|$numberOfClasses|$classesCount|$datesString|$isPaymentDue';
  }

  // Create a StudentInfo object from a string stored in SharedPreferences
  static StudentInfo fromSharedPreferences(String studentString) {
    List<String> parts = studentString.split('|');
    List<DateTime?> selectedDates = parts[4].split(',').map((dateString) {
      return dateString.isNotEmpty ? DateTime.parse(dateString) : null;
    }).toList();

    return StudentInfo(
      className: parts[0],
      studentEmail: parts[1],
      numberOfClasses: int.parse(parts[2]),
      classesCount: int.parse(parts[3]),
      selectedDates: selectedDates,
      isPaymentDue: parts[5] == 'true',
    );
  }
}

class DatePickerPage extends StatefulWidget {
  final int maxClasses;
  final List<DateTime?> selectedDates;

  DatePickerPage(this.maxClasses, this.selectedDates);

  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  late List<DateTime?> selectedDates;

  @override
  void initState() {
    super.initState();
    selectedDates = List.from(widget.selectedDates);
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
            colors: [Colors.white70, Colors.greenAccent],
          ),
        ),
        child: ListView.builder(
          itemCount: widget.maxClasses,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.redAccent,
              child: ListTile(
                title: Text(
                  'Class ${index + 1} Date',
                  style: TextStyle(color: Colors.white,fontSize: 20),
                ),
                subtitle: Text(
                  selectedDates[index] != null
                      ? DateFormat('dd-MM-yy').format(selectedDates[index]!)
                      : 'Not selected',
                  style: TextStyle(color: Colors.yellowAccent,fontSize: 15),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, selectedDates);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
