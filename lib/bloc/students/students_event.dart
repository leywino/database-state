part of 'students_bloc.dart';

abstract class StudentsEvent extends Equatable {
  const StudentsEvent();

  @override
  List<Object> get props => [];
}

class GetAllData extends StudentsEvent {
  const GetAllData();
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class DeleteStudent extends StudentsEvent {
  final List<StudentModel> studentModel;
  int? index;
  DeleteStudent({required this.studentModel, required this.index});
  @override
  List<Object> get props => [studentModel];
}

class EditStudent extends StudentsEvent {
  final StudentModel studentModel;
  final int index;


  const EditStudent({
    required this.index,
    required this.studentModel,

  });
  @override
  List<Object> get props => [studentModel,index];
}

class AddData extends StudentsEvent {
  final StudentModel studentModel;
  const AddData({required this.studentModel});
  @override
  List<Object> get props => [studentModel];
}