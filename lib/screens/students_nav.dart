import 'package:database/bloc/students/students_bloc.dart';
import 'package:database/screens/home_nav.dart';
import 'package:database/screens/student_details.dart';
import 'package:database/screens/widgets/edit_students.dart';
import 'package:database/screens/widgets/search_students.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsNav extends StatelessWidget {
  const StudentsNav({super.key});

  @override
  Widget build(BuildContext context) {
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
                    builder: (ctx) => SearchScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
      ),
      body: BlocBuilder<StudentsBloc, StudentsState>(
        builder: (ctx, state) {
          if (state is StudentsInitial) {
            ctx.read<StudentsBloc>().add(const GetAllData());
          }
          if (state is DisplayAllStudents) {
            return state.studentModel.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.studentModel.length,
                    itemBuilder: (context, index) {
                      final data = state.studentModel[index];
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
                                  alertDelete(
                                      context, index, state.studentModel);
                                } else {}
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
                  )
                : const Center(
                    child: Text(
                      "List is empty",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
          } else {
            return const Center(
              child: Text(
                "Something is wrong",
                style: TextStyle(fontSize: 20),
              ),
            );
          }
        },
      ),
    );
  }
}
