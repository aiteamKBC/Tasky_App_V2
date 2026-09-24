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

        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/home.svg", 0),

            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/to do.svg", 1),
            label: "To Do",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/complete.svg", 2),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/profile.svg", 3),

            label: "Profile",
          ),
        ],
      ),

      body: SafeArea(child: _screen[_currentIndex]),
    );
  }

  SvgPicture _buildSvgPicture(String path, int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        _currentIndex == index ? Color(0xff15B86C) : Color(0xffC6C6C6),
        BlendMode.srcIn,
      ),
    );
  }
}
