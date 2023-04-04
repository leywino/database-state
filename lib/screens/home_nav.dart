import 'package:database/bloc/students/students_bloc.dart';
import 'package:database/db/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

ValueNotifier<String> imagePathNotifer =
    ValueNotifier("");

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});
  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _placeController = TextEditingController();

  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: SafeArea(
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
                    ValueListenableBuilder(
                      valueListenable: imagePathNotifer,
                      builder: (context, value, child) {
                        return ElevatedButton.icon(
                          onPressed: () {
                            addButton(context, imagePathNotifer.value);
                          },
                          label: const Text('Add'),
                          icon: const Icon(Icons.add),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  addButton(BuildContext ctx, String image) async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final place = _placeController.text.trim();
    final phone = _phoneController.text.trim();
    final key = DateTime.now().toString();

    String? field;
    // final pickedFile =
    //       await ImagePicker().pickImage(source: ImageSource.gallery);
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
        image.isEmpty) {
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
      // ignore: unnecessary_null_comparison
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
      // addStudent(student);
      ctx.read<StudentsBloc>().add(AddData(studentModel: student));
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey,
          content: Row(
            children: [
              const Icon(Icons.done),
              Text("${student.name.toUpperCase()} added successfully"),
            ],
          ),
        ),
      );
      // Navigator.of(ctx).push(
      //   MaterialPageRoute(
      //     builder: (ctx) => const StudentsNav(),
      //   ),
      // );

      _nameController.clear();
      _ageController.clear();
      _placeController.clear();
      _phoneController.clear();
    }
  }

  getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    } else {
      imagePathNotifer.value = pickedFile.path;
    }
  }
}

alertDelete(BuildContext ctx, int index, List<StudentModel> studentList) {
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
                // ignore: unnecessary_null_comparison
                if (index != null) {
                  ctx.read<StudentsBloc>().add(
                      DeleteStudent(index: index, studentModel: studentList));
                  Navigator.pop(ctx);
                } else {}
              },
              child: const Text('Delete'),
            ),
          ],
        );
      });
}
