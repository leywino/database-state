import 'package:database/db/model/data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box<StudentModel> getStudents() =>
      Hive.box<StudentModel>('student_db');
}