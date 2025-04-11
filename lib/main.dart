import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qma/app/app.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // ensure flutter widgets are initialized before sqflite
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
  }
  // Change the default factory. On iOS/Android, if not using `sqlite_flutter_lib` you can forget
  // this step, it will use the sqlite version available on the system.
  databaseFactory = databaseFactoryFfi;
  runApp(QmaApp());
}
