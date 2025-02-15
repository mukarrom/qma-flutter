import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qma/app/app_colors.dart';
import 'package:qma/features/students/ui/widgets/single_input_field_with_icon.dart';
import 'package:qma/features/students/ui/widgets/single_select_field_with_icon.dart';

class Student {
  final String id;
  final String name;
  final String fatherName;
  final String className;
  final String mobileNo;

  Student({
    required this.id,
    required this.name,
    required this.fatherName,
    required this.className,
    required this.mobileNo,
  });
}

class StudentsListScreen extends StatefulWidget {
  const StudentsListScreen({super.key});
  static const String name = '/students';

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  List<Student> students = [
    Student(
        id: "001",
        name: "John Doe",
        fatherName: "Michael Doe",
        className: "10A",
        mobileNo: "1234567890"),
    Student(
        id: "002",
        name: "Jane Smith",
        fatherName: "Robert Smith",
        className: "9B",
        mobileNo: "9876543210"),
    Student(
        id: "003",
        name: "Alice Johnson",
        fatherName: "David Johnson",
        className: "11C",
        mobileNo: "5555555555"),
    Student(
        id: "003",
        name: "Alice Johnson",
        fatherName: "David Johnson",
        className: "11C",
        mobileNo: "5555555555"),
    Student(
        id: "003",
        name: "Alice Johnson",
        fatherName: "David Johnson",
        className: "11C",
        mobileNo: "5555555555"),
    Student(
        id: "003",
        name: "Alice Johnson",
        fatherName: "David Johnson",
        className: "11C",
        mobileNo: "5555555555"),
    Student(
        id: "003",
        name: "Alice Johnson",
        fatherName: "David Johnson",
        className: "11C",
        mobileNo: "5555555555"),
    Student(
        id: "003",
        name: "Alice Johnson",
        fatherName: "David Johnson",
        className: "11C",
        mobileNo: "5555555555"),
    Student(
        id: "003",
        name: "Alice Johnson",
        fatherName: "David Johnson",
        className: "11C",
        mobileNo: "5555555555"),
    Student(
        id: "003",
        name: "Alice Johnson",
        fatherName: "David Johnson",
        className: "11C",
        mobileNo: "5555555555"),
    Student(
        id: "003",
        name: "Alice Johnson",
        fatherName: "David Johnson",
        className: "11C",
        mobileNo: "5555555555"),
    Student(
        id: "003",
        name: "Alice Johnson",
        fatherName: "David Johnson",
        className: "11C",
        mobileNo: "5555555555"),
    Student(
        id: "003",
        name: "Alice Johnson",
        fatherName: "David Johnson",
        className: "11C",
        mobileNo: "5555555555"),
    Student(
        id: "003",
        name: "Alice Johnson",
        fatherName: "David Johnson",
        className: "11C",
        mobileNo: "5555555555"),
    Student(
        id: "003",
        name: "Alice Johnson",
        fatherName: "David Johnson",
        className: "11C",
        mobileNo: "5555555555"),
    // Add more student data as needed
  ];

  List<Student> filteredStudents = [];
  String searchTerm = "";
  String? sortColumn;
  bool isAscending = true;
  Map<String, bool> visibleColumns = {
    'id': true,
    'name': true,
    'fatherName': true,
    'className': true,
    'mobileNo': true,
  };

  @override
  void initState() {
    super.initState();
    filteredStudents = students;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Data Management'),
        leading: IconButton(
          onPressed: _onClickAddNewStudent,
          icon: Icon(
            Icons.add,
          ),
          color: Colors.white,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.themeColor),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search students...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: filterStudents,
            ),
          ),
          Expanded(
            child: DataTable2(
              columns: [
                if (visibleColumns['id']!)
                  DataColumn2(
                    label: const Text('ID'),
                    onSort: (_, __) => sortStudents('id'),
                  ),
                if (visibleColumns['name']!)
                  DataColumn2(
                    label: Text('Name'),
                    onSort: (_, __) => sortStudents('name'),
                  ),
                if (visibleColumns['fatherName']!)
                  DataColumn2(
                    label: Text('Father\'s Name'),
                    onSort: (_, __) => sortStudents('fatherName'),
                  ),
                if (visibleColumns['className']!)
                  DataColumn2(
                    label: Text('Class'),
                    onSort: (_, __) => sortStudents('className'),
                  ),
                if (visibleColumns['mobileNo']!)
                  DataColumn2(
                    label: Text('Mobile No.'),
                    onSort: (_, __) => sortStudents('mobileNo'),
                  ),
              ],
              rows: filteredStudents.map((student) {
                return DataRow(cells: [
                  if (visibleColumns['id']!) DataCell(Text(student.id)),
                  if (visibleColumns['name']!) DataCell(Text(student.name)),
                  if (visibleColumns['fatherName']!)
                    DataCell(Text(student.fatherName)),
                  if (visibleColumns['className']!)
                    DataCell(Text(student.className)),
                  if (visibleColumns['mobileNo']!)
                    DataCell(Text(student.mobileNo)),
                ]);
              }).toList(),
              sortColumnIndex: sortColumn != null
                  ? ['id', 'name', 'fatherName', 'className', 'mobileNo']
                      .indexOf(sortColumn!)
                  : null,
              sortAscending: isAscending,
              columnSpacing: 20,
              horizontalMargin: 10,
              minWidth: 600,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_list),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Toggle Columns'),
                content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: visibleColumns.keys.map((column) {
                        return CheckboxListTile(
                          title: Text(column),
                          value: visibleColumns[column],
                          onChanged: (bool? value) {
                            setState(() {
                              visibleColumns[column] = value!;
                            });
                            this.setState(() {});
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _onClickAddNewStudent() {
    Get.dialog(
      AlertDialog(
        title: const Text("Fill Out the Form"),
        content: Form(
          // key: _formKey,
          child: Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            children: [
              // academic year, class, group, gender
              Row(
                children: [
                  SingleSelectFieldWithIcon(
                    icon: Icons.class_outlined,
                    required: true,
                    dropdownItems: ["2025", "2024-25"],
                    hint: "শিক্ষাবর্ষ",
                  ),
                  SingleSelectFieldWithIcon(
                    required: true,
                    hint: "ক্লাস",
                    dropdownItems: ["Class 1", "Class 2"],
                  ),
                  SingleSelectFieldWithIcon(
                    hint: "গ্রুপ",
                    dropdownItems: ["Group 1", "Group 2"],
                  ),
                  SingleSelectFieldWithIcon(
                    required: true,
                    width: 150,
                    hint: "ছাত্র/ছাত্রী",
                    dropdownItems: ["ছাত্র", "ছাত্রী"],
                  ),
                ],
              ),
              // Name, father name, mother name
              Row(
                children: [
                  SingleInputFieldWithIcon(
                    required: true,
                    width: 300,
                    icon: Icons.person_outline,
                    hint: "শিক্ষার্থীর নাম",
                  ),
                  SingleInputFieldWithIcon(
                    required: true,
                    width: 300,
                    hint: "পিতার নাম",
                  ),
                  SingleInputFieldWithIcon(
                    width: 300,
                    hint: "মাতার নাম",
                  ),
                ],
              ),
              // Date of birth, Birth Certificate No, blood group
              Row(
                children: [
                  SingleInputFieldWithIcon(
                    icon: Icons.date_range_outlined,
                    hint: "জন্ম তারিখ",
                  ),
                  SingleInputFieldWithIcon(
                    hint: "জন্ম নিবন্ধন নম্বর",
                  ),
                  SingleSelectFieldWithIcon(
                    width: 150,
                    hint: "রক্তের গ্রুপ",
                    dropdownItems: [
                      "A+",
                      "A-",
                      "B+",
                      "B-",
                      "AB+",
                      "AB-",
                      "O+",
                      "O-",
                    ],
                  ),
                ],
              ),
              // Mobile No, Email
              Row(
                children: [
                  SingleInputFieldWithIcon(
                    required: true,
                    icon: Icons.phone_android_outlined,
                    hint: "মোবাইল নাম্বার ১",
                  ),
                  SingleInputFieldWithIcon(
                    hint: "মেবাইল নাম্বার ২",
                  ),
                  SingleInputFieldWithIcon(
                    // icon: Icons.email_outlined,
                    hint: "Email",
                  ),
                ],
              ),
              // Address
              Row(
                children: [
                  SingleInputFieldWithIcon(
                    width: 450,
                    icon: Icons.location_on_outlined,
                    hint: "বর্তমান ঠিকানা",
                  ),
                  SingleInputFieldWithIcon(
                    width: 450,
                    hint: "স্থায়ী ঠিকানা",
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // if (_formKey.currentState!.validate()) {
              // Process data
              Get.back(); // Close the dialog
              // }
            },
            child: const Text("Submit"),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          )
        ],
      ),
    );
  }

  void filterStudents(String query) {
    setState(() {
      searchTerm = query;
      filteredStudents = students.where((student) {
        return student.id.toLowerCase().contains(query.toLowerCase()) ||
            student.name.toLowerCase().contains(query.toLowerCase()) ||
            student.fatherName.toLowerCase().contains(query.toLowerCase()) ||
            student.className.toLowerCase().contains(query.toLowerCase()) ||
            student.mobileNo.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void sortStudents(String column) {
    setState(() {
      if (sortColumn == column) {
        isAscending = !isAscending;
      } else {
        sortColumn = column;
        isAscending = true;
      }

      filteredStudents.sort((a, b) {
        var aValue = getColumnValue(a, column);
        var bValue = getColumnValue(b, column);
        return isAscending
            ? aValue.compareTo(bValue)
            : bValue.compareTo(aValue);
      });
    });
  }

  String getColumnValue(Student student, String column) {
    switch (column) {
      case 'id':
        return student.id;
      case 'name':
        return student.name;
      case 'fatherName':
        return student.fatherName;
      case 'className':
        return student.className;
      case 'mobileNo':
        return student.mobileNo;
      default:
        return '';
    }
  }
}
