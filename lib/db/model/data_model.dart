import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String key;
  @HiveField(1)
  late final String name;
  @HiveField(2)
  late final String age;
  @HiveField(3)
  late final String place;
  @HiveField(4)
  late final String phone;
  @HiveField(5)
  late final String image;

  StudentModel({
    required this.name,
    required this.age,
    required this.place,
    required this.phone,
    required this.key,
    required this.image,
  });

}
