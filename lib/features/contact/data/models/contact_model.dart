import 'package:hive/hive.dart';

import '../../domain/entities/contact_entity.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 0)
class ContactModel extends Contact {
  @HiveField(0)
  final int? id;
  @override
  @HiveField(1)
  String get name => super.name;

  @override
  @HiveField(2)
  String get phone => super.phone;

   const ContactModel({
    this.id,
    required super.name,
    required super.phone,
  });

  ContactModel copyWith({
    int? id,
    String? name,
    String? phone,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

}
