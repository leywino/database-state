import 'package:database/db/functions/db_functions.dart';
import 'package:database/db/model/data_model.dart';
import 'package:database/screens/student_details.dart';
import 'package:database/screens/widgets/add_students.dart';
import 'package:database/screens/widgets/edit_students.dart';
import 'package:database/screens/widgets/search_students.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class StudentsNav extends StatelessWidget {
  const StudentsNav({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Student List'),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const SearchScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              final data = studentList[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(
                    File(data.image),
                  ),
                ),
                title: Text(data.name),
                subtitle: Text(data.place),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) {
                        return ShowDetails(data: data);
                      }),
                    ),
                  );
                },
                trailing: Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        // ignore: unnecessary_null_comparison
                        if (data.key != null) {
                          alertDelete(ctx, index);
                        } else {
                        }
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditStudents(index: index, data: data),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
