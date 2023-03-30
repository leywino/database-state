// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore_for_file: non_constant_identifier_names, duplicate_ignore

import 'package:database/db/functions/db_functions.dart';
import 'package:database/db/model/data_model.dart';
import 'package:database/screens/students_nav.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentsWidget extends StatefulWidget {
  const AddStudentsWidget({super.key});

  @override
  State<AddStudentsWidget> createState() => _AddStudentsWidgetState();
}

// ignore: duplicate_ignore, duplicate_ignore
class _AddStudentsWidgetState extends State<AddStudentsWidget> {
  String? path;

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _placeController = TextEditingController();

  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'Add Students',
                    style: TextStyle(fontSize: 30),
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
                      hintText: 'Name',
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
                      hintText: 'Age',
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
                      hintText: 'Place',
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
                      hintText: 'Phone Number',
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
                      AddButton(context);
                    },
                    label: const Text('Add'),
                    icon: const Icon(Icons.add),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  AddButton(BuildContext ctx) {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final place = _placeController.text.trim();
    final phone = _phoneController.text.trim();
    final key = DateTime.now().toString();
    final image = path;
    String? field;

    // ignore: non_constant_identifier_names
    ErrorMessage() {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[300],
          content: Row(
            children: [
              const Icon(Icons.error),
              Text('$field is empty'),
            ],
          ),
        ),
      );
    }

    if (name.isEmpty &&
        age.isEmpty &&
        place.isEmpty &&
        phone.isEmpty &&
        image!.isEmpty) {
      field = 'Every field';
      ErrorMessage();
    } else if (name.isEmpty) {
      field = 'Name';
      ErrorMessage();
    } else if (age.isEmpty) {
      field = 'Age';
      ErrorMessage();
    } else if (place.isEmpty) {
      field = 'Place';
      ErrorMessage();
    } else if (phone.isEmpty) {
      field = 'Phone number';
      ErrorMessage();
    } else if (image == null) {
      field = 'Image';
      ErrorMessage();
    } else {
      final student = StudentModel(
        name: name,
        age: age,
        place: place,
        phone: phone,
        key: key,
        image: image,
      );
      addStudent(student);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const StudentsNav(),
        ),
      );

      _nameController.clear();
      _ageController.clear();
      _placeController.clear();
      _phoneController.clear();
    }
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

alertDelete(BuildContext ctx, index) {
  showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          // title: Text('Delete'),
          content: const Text('Do you want to delete this?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (index != null) {
                  deleteStudent(index);
                  Navigator.pop(ctx);
                } else {
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      });
}
