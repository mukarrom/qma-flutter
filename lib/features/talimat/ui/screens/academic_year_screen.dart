import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qma/app/app_colors.dart';
import 'package:qma/features/common/ui/widgets/delete_alert_dialog.dart';
import 'package:qma/features/common/ui/widgets/qms_input_field.dart';
import 'package:qma/features/common/ui/widgets/qms_select_widget.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  Offset _tapPosition = Offset.zero;

  List<int> selectedRows = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeaderAppBar(),
      body: GestureDetector(
        onTapDown: (details) {
          setState(() {
            _tapPosition = details.globalPosition;
          });
        },
        child: DataTable2(
          minWidth: 650,
          columnSpacing: 0,
          headingRowColor: const WidgetStatePropertyAll(
            AppColors.themeColor,
          ),
          headingTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          border: TableBorder(
            horizontalInside: _buildBorderSide(),
            verticalInside: _buildBorderSide(),
            left: _buildBorderSide(),
            right: _buildBorderSide(),
          ),
          columns: _buildDataColumns(),
          rows: _buildDataRows(),
        ),
      ),
    );
  }

  BorderSide _buildBorderSide() {
    return const BorderSide(
      color: AppColors.themeColor,
      width: 1,
    );
  }

  /// Build Header AppBar
  AppBar _buildHeaderAppBar() {
    return AppBar(
      leading: IconButton.outlined(
        hoverColor: Colors.white,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => _buildAddOrEditDialog(context));
        },
        icon: const Icon(
          Icons.add_circle,
        ),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.grey.shade200),
          foregroundColor: const WidgetStatePropertyAll(AppColors.themeColor),
        ),
        tooltip: "Add New Session",
      ),
      backgroundColor: Colors.grey.shade200,
      elevation: 10,
      title: const Text(
        "Sessions",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.settings,
            color: AppColors.themeColor,
          ),
          tooltip: "Settings",
        )
      ],
    );
  }

  /// Build DataTable2 Columns
  List<DataColumn2> _buildDataColumns() {
    return [
      DataColumn2(
        // fixedWidth: 100,
        size: ColumnSize.M,
        label: const Center(child: Text("id")),
        onSort: (columnIndex, ascending) {
          // do something
        },
      ),
      DataColumn2(
        // fixedWidth: 100,
        label: const Center(child: Text("Session")),
        onSort: (columnIndex, ascending) {
          // do something
        },
      ),
      DataColumn2(
        // fixedWidth: 100,
        label: const Center(child: Text("Start Month")),
        onSort: (columnIndex, ascending) {
          // do something
        },
      ),
      DataColumn2(
        // fixedWidth: 100,
        label: const Center(child: Text("End Month")),
        onSort: (columnIndex, ascending) {
          // do something
        },
      ),
      DataColumn2(
        // fixedWidth: 100,
        label: const Center(child: Text("Status")),
        onSort: (columnIndex, ascending) {
          // do something
        },
      ),
    ];
  }

  /// Build DataTable2 Rows
  List<DataRow2> _buildDataRows() {
    return List<DataRow2>.generate(
      100,
      (int index) => DataRow2(
        color: index % 2 == 0
            ? WidgetStatePropertyAll(Colors.grey.shade200)
            : null,
        selected: selectedRows.contains(index),
        onSelectChanged: (value) {
          setState(() {
            if (selectedRows.contains(index)) {
              selectedRows.remove(index);
            } else {
              selectedRows.add(index);
            }
          });
        },
        onSecondaryTapDown: (details) {
          setState(() {
            _tapPosition = details.globalPosition;
          });
          _onSecondaryTapShowPopupMenu(
            context,
            index,
          );
        },
        onLongPress: () {},
        cells: [
          DataCell(Center(child: Text("session${index + 1}"))),
          DataCell(Center(child: Text((2024 + index).toString()))),
          const DataCell(Center(child: Text("January"))),
          const DataCell(Center(child: Text("December"))),
          const DataCell(Center(child: Text("Active"))),
        ],
      ),
    );
  }

  /// Show PopupMenu
  void _onSecondaryTapShowPopupMenu(
    BuildContext context, [
    int index = 0,
  ]) {
    Map<String, dynamic> currentSession = {
      "session": "session${2024 + index}",
      "start_month": "January",
      "end_month": "December",
      "status": "Active",
    };
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          _tapPosition.dx, // X position of the tap
          _tapPosition.dy, // Y position of the tap
          _tapPosition.dx, // X position of the tap
          _tapPosition.dy // Y position of the tap
          ),
      items: [
        /// View Details
        PopupMenuItem(
          onTap: () {},
          value: 'view',
          child: const Row(
            children: [
              Icon(Icons.view_list_rounded),
              SizedBox(
                width: 10,
              ),
              Text('View Details'),
            ],
          ),
        ),

        /// Edit
        PopupMenuItem(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => _buildAddOrEditDialog(
                context,
                currentSession: currentSession,
              ),
            );
          },
          value: 'Edit',
          child: const Row(
            children: [
              Icon(Icons.edit),
              SizedBox(
                width: 10,
              ),
              Text('Edit'),
            ],
          ),
        ),

        /// Change Status
        PopupMenuItem(
          // onTap: () {
          //   showDialog(
          //     context: context,
          //     builder: (context) => const ChangeAlertDialog(
          //       title: 'Status',
          //       data: {},
          //     ),
          //   );
          // },
          value: 'change_status',
          child: const Row(
            children: [
              Icon(Icons.sync),
              SizedBox(
                width: 10,
              ),
              Text('Change Status'),
            ],
          ),
        ),

        /// Delete
        PopupMenuItem(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => const DeleteAlertDialog(
                title: 'Session',
              ),
            );
          },
          value: 'delete',
          child: const Row(
            children: [
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Delete', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    );
  }
}

Widget _buildAddOrEditDialog(BuildContext context,
    {Map<String, dynamic>? currentSession}) {
  const months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  TextEditingController sessionTEC = TextEditingController(
    text: currentSession == null ? null : currentSession["session"],
  );

  return Dialog(
    child: Container(
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(
        maxWidth: 300,
        // maxHeight: 600,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          currentSession == null ? "Add New Session" : "Edit Session",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(10),
        QmmaInputField(
          labelText: "Session",
          inputTEC: sessionTEC,
        ),
        const Gap(10),
        SelectWidget(
          labelText: "Select Start Month",
          dropdownItems: months,
          selectedValue:
              currentSession == null ? null : currentSession["start_month"],
          onChangeSelectItem: (value) {
            print(value);
          },
        ),
        const Gap(10),
        SelectWidget(
          labelText: "Select End Month",
          dropdownItems: months,
          selectedValue:
              currentSession == null ? null : currentSession["end_month"],
          onChangeSelectItem: (value) {},
        ),
        const Gap(10),
        SelectWidget(
          labelText: "Status",
          dropdownItems: const ["Active", "Inactive"],
          selectedValue:
              currentSession == null ? null : currentSession["status"],
          onChangeSelectItem: (value) {},
        ),
        const Gap(10),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
          ),
          child: const Text("Save"),
        ),
      ]),
    ),
  );
}
