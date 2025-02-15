import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:qma/app/app_colors.dart';

class User {
  final String id;
  final String name;
  final String fatherName;
  final String className;
  final String mobileNo;

  User(
      {required this.id,
      required this.name,
      required this.fatherName,
      required this.className,
      required this.mobileNo});
}

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<User> students = List.generate(
    100,
    (index) => User(
      id: (index + 1).toString().padLeft(3, '0'),
      name: "Student ${index + 1}",
      fatherName: "Father ${index + 1}",
      className: "${(index % 12) + 1}${String.fromCharCode(65 + (index % 3))}",
      mobileNo: "555-${index.toString().padLeft(4, '0')}",
    ),
  );

  List<User> filteredStudents = [];
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

  String getColumnValue(User student, String column) {
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

  void _showContextMenu(BuildContext context, User student) {
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
          'Student Data Management',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo.shade300,
      ),
      body: Column(
        children: [
          // Search bar
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

          // DataTable
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                dataTableTheme: DataTableThemeData(
                  headingRowColor:
                      WidgetStateProperty.all(Colors.indigo.shade100),
                  dataRowColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.hovered)) {
                        return Colors.indigo.shade50;
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
                      label: Center(
                          child: Text('ID',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      onSort: (_, __) => sortStudents('id'),
                    ),
                  if (visibleColumns['name']!)
                    DataColumn2(
                      label: Center(
                          child: Text('Name',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      onSort: (_, __) => sortStudents('name'),
                    ),
                  if (visibleColumns['fatherName']!)
                    DataColumn2(
                      label: Center(
                          child: Text('Father\'s Name',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      onSort: (_, __) => sortStudents('fatherName'),
                    ),
                  if (visibleColumns['className']!)
                    DataColumn2(
                      label: Center(
                          child: Text('Class',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      onSort: (_, __) => sortStudents('className'),
                    ),
                  if (visibleColumns['mobileNo']!)
                    DataColumn2(
                      label: Center(
                          child: Text('Mobile No.',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      onSort: (_, __) => sortStudents('mobileNo'),
                    ),
                ],
                source: _StudentDataSource(
                    filteredStudents, visibleColumns, _showContextMenu),
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
                columnSpacing: 20,
                horizontalMargin: 10,
                minWidth: 600,
                border: TableBorder(
                  top: BorderSide(color: Colors.indigo.shade200),
                  bottom: BorderSide(color: Colors.indigo.shade200),
                  left: BorderSide(color: Colors.indigo.shade200),
                  right: BorderSide(color: Colors.indigo.shade200),
                  verticalInside: BorderSide(color: Colors.indigo.shade100),
                  horizontalInside: BorderSide(color: Colors.indigo.shade100),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        onPressed: () {
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
        },
        child: const Icon(Icons.filter_list),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _StudentDataSource extends DataTableSource {
  final List<User> _students;
  final Map<String, bool> _visibleColumns;
  final Function(BuildContext, User) _showContextMenu;

  _StudentDataSource(
      this._students, this._visibleColumns, this._showContextMenu);

  @override
  DataRow getRow(int index) {
    final student = _students[index];
    return DataRow2(
      cells: [
        if (_visibleColumns['id']!) DataCell(Text(student.id)),
        if (_visibleColumns['name']!) DataCell(Text(student.name)),
        if (_visibleColumns['fatherName']!) DataCell(Text(student.fatherName)),
        if (_visibleColumns['className']!) DataCell(Text(student.className)),
        if (_visibleColumns['mobileNo']!) DataCell(Text(student.mobileNo)),
      ],
      onTap: () {
        print('Tapped on ${student.name}');
      },
      onSecondaryTap: () {
        // _showContextMenu(event, student);
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
