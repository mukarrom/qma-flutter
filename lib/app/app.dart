import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qma/app/app_theme_data.dart';
import 'package:qma/app/controller_binder.dart';
import 'package:qma/features/common/ui/screens/main_layout.dart';

class QmaApp extends StatelessWidget {
  const QmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinder(),
      home: const MainLayout(),
      theme: AppThemeData.lightThemeData,
    );
  }
}
