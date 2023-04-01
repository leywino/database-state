import 'package:database/db/model/data_model.dart';
import 'package:database/screens/widgets/details.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// ignore: must_be_immutable
class ShowDetails2 extends StatelessWidget {
  StudentModel? studentList;

  ShowDetails2({super.key, required this.studentList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Student Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            children: [
              const SizedBox(height: 30),
              Center(
                child: CircleAvatar(
                  backgroundImage: FileImage(File(studentList!.image)),
                  radius: 60,
                ),
              ),
              const SizedBox(height: 30),
              Details(
                labeltext: 'Name : ${studentList!.name}',
              ),
              Details(
                labeltext: 'Age : ${studentList!.age}',
              ),
              Details(
                labeltext: 'Email : ${studentList!.place}',
              ),
              Details(
                labeltext: 'Ph : ${studentList!.phone}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
