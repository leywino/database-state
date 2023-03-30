// ignore: duplicate_ignore
// ignore_for_file: non_constant_identifier_names

import 'package:database/db/functions/db_functions.dart';
import 'package:flutter/material.dart';
import 'package:database/db/model/data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// ignore: must_be_immutable
class EditStudents extends StatefulWidget {
  EditStudents({super.key, required this.index, required this.data});

  int index;
  StudentModel data;

  @override
  State<EditStudents> createState() => _EditStudentsState();
}

// ignore: duplicate_ignore
class _EditStudentsState extends State<EditStudents> {
  String? path;
  TextEditingController? _nameController;
  TextEditingController? _ageController;
  TextEditingController? _placeController;
  TextEditingController? _phoneController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.data.name);

    _ageController = TextEditingController(text: widget.data.age);

    _placeController = TextEditingController(text: widget.data.place);

    _phoneController = TextEditingController(text: widget.data.phone);

    path = widget.data.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Edit Students'),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  CircleAvatar(
                    radius: 90,
                    backgroundImage: FileImage(
                      File(widget.data.image),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.abc_rounded),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0), width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 119, 118, 118),
                            width: 3.0),
                      ),
                      hintText: widget.data.name,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // ignore: prefer_const_constructors
                  TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.numbers),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0), width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 119, 118, 118),
                            width: 3.0),
                      ),
                      hintText: widget.data.age,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: _placeController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_pin),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0), width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 119, 118, 118),
                            width: 3.0),
                      ),
                      hintText: widget.data.place,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0), width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 119, 118, 118),
                            width: 3.0),
                      ),
                      hintText: widget.data.phone,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      getImage();
                    },
                    label: const Text('+'),
                    icon: const Icon(Icons.photo),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Edit(widget.index);
                      Navigator.pop(context);
                    },
                    label: const Text('Save'),
                    icon: const Icon(Icons.save),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> Edit(int index) async {
    final name = _nameController!.text.trim();
    final age = _ageController!.text.trim();
    final place = _placeController!.text.trim();
    final phone = _phoneController!.text.trim();
    final key = DateTime.now().toString();
    final image = path!;
    final student = StudentModel(
        name: name,
        age: age,
        place: place,
        phone: phone,
        key: key,
        image: image);
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentDB.putAt(index, student);
    getAllStudents();
  }

  getImage() async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile == null) {
      return;
    } else {
      setState(() {
        path = PickedFile.path;
      });
    }
  }
}
