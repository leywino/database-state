import 'package:database/screens/widgets/details.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// ignore: must_be_immutable
class ShowDetails extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var data;
  // ignore: prefer_typing_uninitialized_variables
  var student;

  ShowDetails({super.key, this.data});

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
                  backgroundImage: FileImage(File(data.image)),
                  radius: 60,
                ),
              ),
              const SizedBox(height: 30),
              Details(
                labeltext: 'Name : ${data.name}',
              ),
              Details(
                labeltext: 'Age : ${data.age}',
              ),
              Details(
                labeltext: 'Email : ${data.place}',
              ),
              Details(
                labeltext: 'Ph : ${data.phone}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
