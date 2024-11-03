import 'package:get_it/get_it.dart';

import '../../features/contact/data/datasources/local/contact_local_datasource.dart';
import '../../features/contact/data/repositories/contact_repository_impl.dart';
import '../../features/contact/domain/repositories/contact_repository.dart';
import '../../features/contact/domain/usecases/add_contact_usecase.dart';
import '../../features/contact/domain/usecases/delete_contact_usecase.dart';
import '../../features/contact/domain/usecases/get_contacts.dart';
import '../../features/contact/domain/usecases/update_contact_usecase.dart';
import '../../features/contact/presentation/bloc/contact_bloc.dart';
import '../database/hive/hive_storage_manager.dart';
import '../database/hive/hive_storage_service.dart';

part 'service_locator.dart';
