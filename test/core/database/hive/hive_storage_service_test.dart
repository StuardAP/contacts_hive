import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/mocks/core/database/hive/hive_storage_service_generate.mocks.dart';


void main() {
  late MockHiveServiceStorage mockHiveServiceStorage;

  setUp(() {
    mockHiveServiceStorage = MockHiveServiceStorage();
  });

  group('HiveServiceStorage', () {
    test('INITFLUTTER SHOULD INITIALIZE HIVE', () async {
      when(mockHiveServiceStorage.init()).thenAnswer((_) async => Future.value());

      await mockHiveServiceStorage.init();

      verify(mockHiveServiceStorage.init()).called(1);
    });

    test('REGISTER ADAPTER SHOULD REGISTER A TYPEADAPTER', () {
      final adapter = MockTypeAdapter<Object>();

      mockHiveServiceStorage.registerAdapter(adapter);

      verify(mockHiveServiceStorage.registerAdapter(adapter)).called(1);
    });

    test('OPENBOX SHOULD OPEN A HIVE BOX', () async {

      const boxName = 'testBox';
      final box = MockBox<Object>();

      when(mockHiveServiceStorage.openBox<Object>(boxName)).thenAnswer((_) async => box);

      final result = await mockHiveServiceStorage.openBox<Object>(boxName);

      expect(result, box);
      verify(mockHiveServiceStorage.openBox<Object>(boxName)).called(1);
    });

    test('BOX SHOULD RETURN A HIVE BOX', () {
      const boxName = 'testBox';
      final box = MockBox<Object>();

      when(mockHiveServiceStorage.box<Object>(boxName)).thenReturn(box);

      final result = mockHiveServiceStorage.box<Object>(boxName);

      expect(result, box);
      verify(mockHiveServiceStorage.box<Object>(boxName)).called(1);
    });

    test('CLOSE SHOULD CLOSE HIVE', () async {
      when(mockHiveServiceStorage.close()).thenAnswer((_) async => Future.value());

      await mockHiveServiceStorage.close();

      verify(mockHiveServiceStorage.close()).called(1);
    });
  });
}
