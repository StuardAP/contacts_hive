import 'dart:developer';


import 'package:hive/hive.dart';

import '../../../features/contact/data/models/contact_model.dart';
import 'hive_storage_service.dart';

class HiveStorageManager {
  late HiveServiceStorage hiveService;
  static const String contactBoxName = 'contacts';

  HiveStorageManager({required this.hiveService});

  Future<void> init() async {
    await hiveService.init();
    log('*** Hive Initialized ****');

    await Hive.deleteBoxFromDisk(contactBoxName);
    hiveService.registerAdapter(ContactModelAdapter());
    await hiveService.openBox<ContactModel>(contactBoxName);
  }

  Box<ContactModel> get contactBox =>
      hiveService.box<ContactModel>(contactBoxName);

  Future<void> close() async {
    await hiveService.close();
  }
}
