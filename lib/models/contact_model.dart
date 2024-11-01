import 'package:hive/hive.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 0)
class ContactModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String phone;

  ContactModel({required this.name, required this.phone});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      name: json['name'],
      phone: json['phone'],
    );
  }

  @override
  String toString() {
    return 'ContactModel {name: $name, phone: $phone}';
  }
}
