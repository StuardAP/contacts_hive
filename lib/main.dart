import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/services/packages.main.dart' as di;
import 'features/contact/presentation/observers/contact_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  Bloc.observer = ContactBlocObserver();
  runApp(const App());
}
