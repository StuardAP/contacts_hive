import 'dart:developer';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

abstract interface class HiveServiceStorage {
  Future<void> init();
  void registerAdapter<T>(TypeAdapter<T> adapter);
  Future<Box<T>> openBox<T>(String boxName);
  Box<T> box<T>(String boxName);
  Future<void> close();
}

class HiveServiceStorageImpl implements HiveServiceStorage {
  @override
  Future<void> init() async {
    final Directory directory = await getApplicationDocumentsDirectory();
     Hive.init(directory.path);
  }

  @override
  void registerAdapter<T>(TypeAdapter<T> adapter) {
    Hive.registerAdapter(adapter);
  }

  @override
  Future<Box<T>> openBox<T>(String boxName) async {
    try {
    return await Hive.openBox<T>(boxName);
    } catch (e) {
    log('ERROR OPENING BOX $boxName: $e');
    rethrow;
    }
  }

  @override
  Box<T> box<T>(String boxName) {
    return Hive.box<T>(boxName);
  }

  @override
  Future<void> close() async {
    await Hive.close();
  }
}
