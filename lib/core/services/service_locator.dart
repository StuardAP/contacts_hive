part of 'packages.main.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Contact
  //Bloc
  sl.registerLazySingleton<ContactBloc>(() => ContactBloc(
        addContact: sl(),
        getContacts: sl(),
        deleteContact: sl(),
        updateContact: sl(),
      ));
  //UseCase
  sl.registerLazySingleton<AddContactUsecase>(
    () => AddContactUsecase(repository: sl()),
  );
  sl.registerLazySingleton<GetContactsUseCase>(
    () => GetContactsUseCase(repository: sl()),
  );
  sl.registerLazySingleton<DeleteContactUseCase>(
    () => DeleteContactUseCase(repository: sl()),
  );
  sl.registerLazySingleton<UpdateContactUseCase>(
    () => UpdateContactUseCase(repository: sl()),
  );
  //Repository
  sl.registerLazySingleton<ContactRepository>(() => ContactRepositoryImpl(
        localDataSource: sl(),
      ));
  //Data Sources
  sl.registerLazySingleton<ContactLocalDataSource>(
    () => ContactLocalDataSourceImpl(
      hiveStorageManager: sl(),
    ),
  );
  // Core
  sl.registerLazySingleton<HiveServiceStorage>(() => HiveServiceStorageImpl());
  sl.registerLazySingleton<HiveStorageManager>(() => HiveStorageManager(
        hiveService: sl(),
      ));
  _initHive();
  // External
}

Future<void> _initHive() async {
 final hiveStorageManager = sl<HiveStorageManager>();
  await hiveStorageManager.init();

}
