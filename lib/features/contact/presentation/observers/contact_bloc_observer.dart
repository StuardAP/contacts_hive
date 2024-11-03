import 'dart:developer';

import 'package:bloc/bloc.dart';

class ContactBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic,dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    log('Event: $event in Bloc: $bloc');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('Change: $change in Bloc: $bloc');
  }

  @override
  void onTransition(Bloc<dynamic,dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    log('Transition: $transition in Bloc: $bloc');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('Error: $error in Bloc: $bloc');
  }
}


