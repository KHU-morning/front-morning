import 'package:flutter/material.dart';
import '../morning_call/morning_call_list_page.dart';
import '../morning_room/morning_room_page.dart';
import '../mypage/my_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MorningCallListPage(),
    const MorningRoomPage(),
    const MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFFFCFCFC),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.alarm), label: '모닝콜'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: '모닝방'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFFBC15B),
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}
