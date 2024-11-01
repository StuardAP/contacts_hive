import 'dart:developer';
import 'dart:io';

import 'package:contacts_hive/app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'models/contact_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory directory = await getApplicationDocumentsDirectory();

  log(directory.path);
  Hive.init(directory.path);
  Hive.registerAdapter(ContactModelAdapter());

  await listHiveFiles();
  runApp(const App());
}

Future<void> listHiveFiles() async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final hiveDirectory = Directory(directory.path);
  final List<FileSystemEntity> files = hiveDirectory.listSync();

  for (var file in files) {
    log('Archivo: ${file.path}');
  }
}
