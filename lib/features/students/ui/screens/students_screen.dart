import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qma/app/app_colors.dart';
import 'package:qma/features/students/data/models/student_model.dart';
import 'package:qma/features/students/ui/widgets/single_input_field_with_icon.dart';
import 'package:qma/features/students/ui/widgets/single_select_field_with_icon.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  List<Student> students = List.generate(
    100,
    (index) => Student(
      id: (index + 1).toString().padLeft(3, '0'),
      name: "Student ${index + 1}",
      fatherName: "Father ${index + 1}",
      className: "${(index % 12) + 1}${String.fromCharCode(65 + (index % 3))}",
      mobileNo: "555-${index.toString().padLeft(4, '0')}",
    ),
  );

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

  int _rowsPerPage = 10;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    filteredStudents = students;
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
      _currentPage = 0;
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

  void _showContextMenu(BuildContext context, Student student) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset position =
        button.localToGlobal(Offset.zero, ancestor: overlay);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        overlay.size.width - position.dx,
        overlay.size.height - position.dy,
      ),
      items: [
        PopupMenuItem(value: 'details', child: Text('Details')),
        PopupMenuItem(value: 'edit', child: Text('Edit')),
        PopupMenuItem(value: 'change_photo', child: Text('Change Photo')),
        PopupMenuItem(value: 'change_class', child: Text('Change Class')),
        PopupMenuItem(value: 'take_fees', child: Text('Take Fees')),
        PopupMenuItem(value: 'delete', child: Text('Delete')),
      ],
    ).then((value) {
      if (value != null) {
        // Handle the selected option
        print('Selected action: $value for student: ${student.name}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'শিক্ষার্থীদের তালিকা',
          style: TextStyle(
            fontSize: 20,
            color: AppColors.themeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: _onClickAddNewStudent,
          icon: Icon(
            Icons.add,
          ),
          color: Colors.white,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.themeColor),
          ),
          tooltip: "নতুন শিক্ষার্থী যুক্ত করুন",
        ),
        actions: [
          // Search bar
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      labelText: 'Search students...',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: filterStudents,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: _onPressFilter,
            icon: Icon(Icons.filter_list_outlined),
            tooltip: "কলাম নির্বাচন করুন",
            color: Colors.white,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.themeColor),
            ),
          ),
          SizedBox(
            width: 8,
          )
        ],
      ),
      body: Column(
        children: [
          // DataTable
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                dataTableTheme: DataTableThemeData(
                  headingRowColor: WidgetStateProperty.all(
                    AppColors.themeColor,
                  ),
                  headingTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ador',
                  ),
                  dataRowColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.hovered)) {
                        return AppColors.themeColor.withAlpha(50);
                      }
                      return null;
                    },
                  ),
                ),
              ),
              child: PaginatedDataTable2(
                columns: [
                  if (visibleColumns['id']!)
                    DataColumn2(
                      label: Center(child: Text('আইডি নং')),
                      onSort: (_, __) => sortStudents('id'),
                    ),
                  if (visibleColumns['name']!)
                    DataColumn2(
                      label: Center(child: Text('শিক্ষার্থীর নাম')),
                      onSort: (_, __) => sortStudents('name'),
                    ),
                  if (visibleColumns['fatherName']!)
                    DataColumn2(
                      label: Center(child: Text('পিতার নাম')),
                      onSort: (_, __) => sortStudents('fatherName'),
                    ),
                  if (visibleColumns['className']!)
                    DataColumn2(
                      label: Center(child: Text('শ্রেণী')),
                      onSort: (_, __) => sortStudents('className'),
                    ),
                  if (visibleColumns['mobileNo']!)
                    DataColumn2(
                      label: Center(child: Text('মোবাইল নং')),
                      onSort: (_, __) => sortStudents('mobileNo'),
                    ),
                ],
                source: _StudentDataSource(
                  filteredStudents,
                  visibleColumns,
                  _showContextMenu,
                  context,
                ),
                rowsPerPage: _rowsPerPage,
                onRowsPerPageChanged: (value) {
                  setState(() {
                    _rowsPerPage = value!;
                    _currentPage = 0;
                  });
                },
                availableRowsPerPage: [10, 20, 50],
                sortColumnIndex: sortColumn != null
                    ? ['id', 'name', 'fatherName', 'className', 'mobileNo']
                        .indexOf(sortColumn!)
                    : null,
                sortAscending: isAscending,
                columnSpacing: 16,
                horizontalMargin: 4,
                minWidth: 600,
                border: TableBorder(
                  top: BorderSide(color: AppColors.themeColor),
                  bottom: BorderSide(color: AppColors.themeColor),
                  left: BorderSide(color: AppColors.themeColor),
                  right: BorderSide(color: AppColors.themeColor),
                  verticalInside:
                      BorderSide(color: AppColors.themeColor.withAlpha(64)),
                  horizontalInside:
                      BorderSide(color: AppColors.themeColor.withAlpha(100)),
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.themeColor,
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           title: const Text('Toggle Columns'),
      //           content: StatefulBuilder(
      //             builder: (BuildContext context, StateSetter setState) {
      //               return Column(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: visibleColumns.keys.map((column) {
      //                   return CheckboxListTile(
      //                     title: Text(column),
      //                     value: visibleColumns[column],
      //                     onChanged: (bool? value) {
      //                       setState(() {
      //                         visibleColumns[column] = value!;
      //                       });
      //                       this.setState(() {});
      //                     },
      //                   );
      //                 }).toList(),
      //               );
      //             },
      //           ),
      //           actions: <Widget>[
      //             TextButton(
      //               child: const Text('Close'),
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //               },
      //             ),
      //           ],
      //         );
      //       },
      //     );
      //   },
      //   child: const Icon(Icons.filter_list),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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

  void _onPressFilter() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Toggle Columns'),
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
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _StudentDataSource extends DataTableSource {
  final BuildContext context;
  final List<Student> _students;
  final Map<String, bool> _visibleColumns;
  final Function(BuildContext, Student) _showContextMenu;

  _StudentDataSource(
    this._students,
    this._visibleColumns,
    this._showContextMenu,
    this.context,
  );

  @override
  DataRow getRow(int index) {
    final student = _students[index];
    return DataRow2(
      cells: [
        if (_visibleColumns['id']!) DataCell(Center(child: Text(student.id))),
        if (_visibleColumns['name']!) DataCell(Text(student.name)),
        if (_visibleColumns['fatherName']!) DataCell(Text(student.fatherName)),
        if (_visibleColumns['className']!) DataCell(Text(student.className)),
        if (_visibleColumns['mobileNo']!)
          DataCell(Center(child: Text(student.mobileNo))),
      ],
      onTap: () {
        print('Tapped on ${student.name}');
      },
      onSecondaryTap: () {
        _showContextMenu(context, student);
      },
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _students.length;

  @override
  int get selectedRowCount => 0;
}
