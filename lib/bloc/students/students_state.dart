part of 'students_bloc.dart';

abstract class StudentsState extends Equatable {
  const StudentsState();
  @override
  List<Object> get props => [];
}

class StudentsInitial extends StudentsState {
  const StudentsInitial();
  @override
  List<Object> get props => [];
}

class DisplayAllStudents extends StudentsState {
  final List<StudentModel> studentModel;
  const DisplayAllStudents({required this.studentModel});
  @override
  List<Object> get props => [studentModel];
}