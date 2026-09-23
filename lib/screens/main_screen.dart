import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskyapp/screens/completed_task_screen.dart';
import 'package:taskyapp/screens/home_screen.dart';
import 'package:taskyapp/screens/profile_screen.dart';
import 'package:taskyapp/screens/tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screen = [
    HomeScreen(),
    TasksScreen(),
    CompletedTaskScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,

        onTap: (int? index) {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff181818),
        selectedItemColor: Color(0xff15B86C),
        unselectedItemColor: Color(0xffC6C6C6),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/home.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 0 ? Color(0xff15B86C) : Color(0xffC6C6C6),
                BlendMode.srcIn,
              ),
            ),

            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/to do.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 1 ? Color(0xff15B86C) : Color(0xffC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: "To Do",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/complete.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 2 ? Color(0xff15B86C) : Color(0xffC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/profile.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 3 ? Color(0xff15B86C) : Color(0xffC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: "Profile",
          ),
        ],
      ),

      body: SafeArea(child: _screen[_currentIndex]),
    );
  }
}
