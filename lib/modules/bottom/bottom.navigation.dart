import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> listBottom = const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite), label: 'Được vinh danh'),
      BottomNavigationBarItem(
          icon: Icon(Icons.insert_emoticon_sharp), label: 'Đã vinh danh'),
      BottomNavigationBarItem(
          icon: Icon(Icons.account_circle), label: 'Cá nhân'),
    ];

    getPage() {
      switch (_selectedIndex) {
        case 0:
          {
            return const Text('1');
          }
        case 1:
          {
            return const Text('2');
          }
        case 2:
          {
            return const Text('3');
          }
        case 3:
          {
            return const Text('4');
          }
      }
    }

    return Scaffold(
      body: getPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.black,
        backgroundColor: AppColor.secondary,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: listBottom,
      ),
    );
  }
}
