import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database/db/functions/boxes.dart';
import 'package:database/db/model/data_model.dart';
import 'package:equatable/equatable.dart';
part 'students_event.dart';
part 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  StudentsBloc() : super(const StudentsInitial()) {
    on<GetAllData>((event, emit) {
      try {
        final boxStudents = Boxes.getStudents();
        final studentList = boxStudents.values.toList();
        emit(DisplayAllStudents(studentModel: studentList));
      } catch (e) {
        log('$e');
      }
    });

    on<AddData>(
      (event, emit) async {
        try {
          final boxStudents = Boxes.getStudents();
          boxStudents.add(event.studentModel);
          add(const GetAllData());
          // print("dsjfhasdhfjsadhfsadhfuasdf ${boxStudents.values.toList()}");
        } catch (e) {
          log("$e");
        }
      },
    );

    on<EditStudent>((event, emit) {
      try {
        final boxStudents = Boxes.getStudents();
        boxStudents.putAt(event.index, event.studentModel);
        add(const GetAllData());
      } catch (e) {
        log('$e');
      }
    });

    on<DeleteStudent>((event, emit) {
      try {
        final boxStudents = Boxes.getStudents();
        boxStudents.deleteAt(event.index!);
        add(const GetAllData());
      } catch (e) {
        log('$e');
      }
    });
  }
}
