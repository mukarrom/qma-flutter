import 'package:flutter/material.dart';
import 'package:qma/app/app_colors.dart';
import 'package:qma/features/common/ui/widgets/responsive_layout.dart';
import 'package:qma/features/students/ui/widgets/single_input_field_with_icon.dart';
import 'package:qma/features/students/ui/widgets/single_select_field_with_icon.dart';

class AddNewStudent extends StatefulWidget {
  const AddNewStudent({super.key});

  @override
  State<AddNewStudent> createState() => _AddNewStudentState();
}

class _AddNewStudentState extends State<AddNewStudent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _mobileNumber1Controller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("নতুন শিক্ষার্থী যোগ করুন"),
      ),
      body: ResponsiveLayout(
        desktop: _buildMobileLayout(),
        tablet: _buildMobileLayout(),
        mobile: _buildMobileLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LimitedBox(
                  maxWidth: 300,
                  maxHeight: 300,
                  child: Column(
                    children: [
                      SingleSelectFieldWithIcon(
                        icon: Icons.class_outlined,
                        dropdownItems: ["2025", "2024-25"],
                        hint: "শিক্ষাবর্ষ",
                      ),
                      SingleSelectFieldWithIcon(
                        hint: "ক্লাস",
                        dropdownItems: ["Class 1", "Class 2"],
                      ),
                      SingleSelectFieldWithIcon(
                        hint: "গ্রুপ",
                        dropdownItems: ["Group 1", "Group 2"],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: VerticalDivider(
                    thickness: 2,
                    color: AppColors.themeColor,
                  ),
                ),
                LimitedBox(
                  maxWidth: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Student Name
                      SingleInputFieldWithIcon(
                        icon: Icons.person_outline,
                        hint: "শিক্ষার্থীর নাম",
                      ),
                      SingleInputFieldWithIcon(
                        hint: "পিতার নাম",
                      ),
                      SingleInputFieldWithIcon(
                        hint: "মাতার নাম",
                      ),
                      SingleInputFieldWithIcon(
                        icon: Icons.phone_android_outlined,
                        hint: "মোবাইল নাম্বার",
                      ),
                      SingleInputFieldWithIcon(
                        hint: "মেবাইল নাম্বার",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: VerticalDivider(
                    thickness: 2,
                    color: AppColors.themeColor,
                  ),
                ),
                LimitedBox(
                  maxWidth: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleInputFieldWithIcon(
                        icon: Icons.email_outlined,
                        hint: "Email",
                      ),
                      SingleInputFieldWithIcon(
                        icon: Icons.date_range_outlined,
                        hint: "জন্ম তারিখ",
                      ),
                      SingleInputFieldWithIcon(
                        hint: "জন্ম নিবন্ধন নম্বর",
                      ),
                      SingleInputFieldWithIcon(
                        icon: Icons.house_outlined,
                        hint: "বর্তমান ঠিকানা",
                      ),
                      SingleInputFieldWithIcon(
                        hint: "স্থায়ী ঠিকানা",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          ElevatedButton(
            onPressed: () {
              // _onTapAddNewStudent();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.themeColor),
            ),
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Row(
            //   spacing: 8,
            //   children: [
            //     Icon(Icons.person_outline),
            //     Expanded(
            //       child: FormInputWidget(
            //         hintText: "শিক্ষার্থীর নাম",
            //       ),
            //     ),
            //     Expanded(
            //       child: FormInputWidget(
            //         hintText: "পিতার নাম",
            //       ),
            //     ),
            //     Expanded(
            //       child: FormInputWidget(
            //         hintText: "মাতার নাম",
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   spacing: 8,
            //   children: [
            //     Text("Mobile No:"),
            //     FormInputWidget(
            //       hintText: "মোবাইল নাম্বার ১",
            //     ),
            //     FormInputWidget(
            //       hintText: "মোবাইল নাম্বার ২",
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  // void _onTapAddNewStudent() {
  //   Get.defaultDialog(
  //     title: "Add New Student",
  //     content: LimitedBox(
  //       maxHeight: 400,
  //       child: SingleChildScrollView(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             SingleSelectFieldWithIcon(
  //               icon: Icons.class_outlined,
  //               dropdownItems: ["2025", "2024-25"],
  //               hint: "শিক্ষাবর্ষ",
  //             ),
  //             SingleSelectFieldWithIcon(
  //               hint: "ক্লাস",
  //               dropdownItems: ["Class 1", "Class 2"],
  //             ),
  //             SingleSelectFieldWithIcon(
  //               hint: "গ্রুপ",
  //               dropdownItems: ["Group 1", "Group 2"],
  //             ),
  //             // Student Name
  //             SingleInputFieldWithIcon(
  //               icon: Icons.person_outline,
  //               hint: "শিক্ষার্থীর নাম",
  //             ),
  //             SingleInputFieldWithIcon(
  //               hint: "পিতার নাম",
  //             ),
  //             SingleInputFieldWithIcon(
  //               hint: "মাতার নাম",
  //             ),
  //             SingleInputFieldWithIcon(
  //               icon: Icons.phone_android_outlined,
  //               hint: "মোবাইল নাম্বার",
  //             ),
  //             SingleInputFieldWithIcon(
  //               hint: "মেবাইল নাম্বার",
  //             ),
  //             SingleInputFieldWithIcon(
  //               icon: Icons.email_outlined,
  //               hint: "Email",
  //             ),
  //             SingleInputFieldWithIcon(
  //               icon: Icons.date_range_outlined,
  //               hint: "জন্ম তারিখ",
  //             ),
  //             SingleInputFieldWithIcon(
  //               hint: "জন্ম নিবন্ধন নম্বর",
  //             ),
  //             SingleInputFieldWithIcon(
  //               icon: Icons.house_outlined,
  //               hint: "বর্তমান ঠিকানা",
  //             ),
  //             SingleInputFieldWithIcon(
  //               hint: "স্থায়ী ঠিকানা",
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //     confirm: IconButton(
  //       onPressed: () {
  //         Get.back();
  //       },
  //       icon: Icon(Icons.add_circle_outline),
  //     ),
  //     cancel: IconButton(
  //       onPressed: () {
  //         Get.back();
  //       },
  //       icon: Icon(Icons.cancel_outlined),
  //     ),
  //   );
  // }
}
