import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  const Contact({
    required this.name,
    required this.phone,
  });
  final String name;
  final String phone;

  @override
  List<Object> get props => [name, phone];
}
