import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qma/app/app.dart';

void main() {
  // platform check
  if (Platform.isAndroid) {
    print("Android");
    runApp(const QmaApp());
  } else if (Platform.isIOS) {
    print("IOS");
    runApp(const QmaApp());
  } else if (Platform.isWindows) {
    print("Windows");
    runApp(const QmaWindowsApp());
  } else if (Platform.isLinux) {
    print("Linux");
    runApp(const QmaApp());
  } else if (Platform.isMacOS) {
    print("MacOS");
    runApp(const QmaApp());
  }
}
