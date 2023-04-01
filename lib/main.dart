import 'package:database/bloc/students/students_bloc.dart';
import 'package:database/db/model/data_model.dart';
import 'package:database/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  await Hive.openBox<StudentModel>('student_db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        
        BlocProvider(
          create: (context) => StudentsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Student List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ScreenHome(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
