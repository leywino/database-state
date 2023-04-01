import 'package:database/screens/home_nav.dart';
import 'package:database/screens/students_nav.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  ValueNotifier<int> currentSelectedIndex = ValueNotifier(0);

  final _pages = [
    const HomeNav(),
    const StudentsNav(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentSelectedIndex,
      builder: (context, currentValue, child) {
        return Scaffold(
          body: _pages[currentValue],
          // ignore: prefer_const_literals_to_create_immutables
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentValue,
              onTap: (newIndex) {
                currentSelectedIndex.value = newIndex;
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'students',
                ),
              ]),
        );
      },
    );
  }
}
