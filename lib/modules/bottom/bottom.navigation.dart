import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';

import '../get.hornors/screen/get.hornors.screen.dart';
import '../home/screen/home.screen.dart';
import '../setting/screen/setting.screen.dart';
import '../set.hornors/screen/set.hornors.screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key, required this.nameWorkspace});
  final String nameWorkspace;

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
      BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Thống kê'),
      BottomNavigationBarItem(
          icon: Icon(Icons.account_circle), label: 'Thông tin'),
    ];

    getPage() {
      switch (_selectedIndex) {
        case 0:
          {
            return  HomeScreen(nameWorkspace: widget.nameWorkspace,);
          }
        case 1:
          {
            return  GetHornorsScreen(nameWorkspace: widget.nameWorkspace);
          }
        case 2:
          {
            return  SetHornorsScreen(nameWorkspace: widget.nameWorkspace);
          }
        case 3:
          {
            return const Center(
              child: Text('Thống kê'),
            );
          }
        case 4:
          {
            return const ProfileScreen();
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
