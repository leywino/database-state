import 'package:database/db/functions/boxes.dart';
import 'package:database/db/model/data_model.dart';
import 'package:database/screens/student_details2.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';

final studentBox = Boxes.getStudents();
final studentList = studentBox.values.toList();
ValueNotifier<List<StudentModel>> displayStudentNotifer =
    ValueNotifier(studentList);

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final _searchController = TextEditingController();

  final List<StudentModel> studentBoxList =
      Hive.box<StudentModel>('student_db').values.toList();

  late List<StudentModel> displayStudent =
      List<StudentModel>.from(studentBoxList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Students"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 7),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Search'),
                controller: _searchController,
                onChanged: (value) {
                  displayStudentNotifer.value = studentBoxList
                      .where(
                        (element) => element.name.toLowerCase().contains(
                              value.toLowerCase(),
                            ),
                      )
                      .toList();
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: displayStudentNotifer,
              builder: (context, displayStudent, child) {
                return Expanded(
                  child: displayStudent.isNotEmpty
                      ? ListView.separated(
                          itemBuilder: (context, index) {
                            File imageFile = File(displayStudent[index].image);
                            return ListTile(
                              onTap: () async {
                                goTo(index, context, displayStudent[index]);
                              },
                              leading: CircleAvatar(
                                backgroundImage: FileImage(imageFile),
                                radius: 20,
                              ),
                              title: Text(displayStudent[index].name),
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return const Divider();
                          },
                          itemCount: displayStudent.length,
                        )
                      : const Center(child: Text("The data is not Found")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  goTo(int index, BuildContext context, StudentModel studentList) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ShowDetails2(
        studentList: studentList,
      );
    }));
  }
}
