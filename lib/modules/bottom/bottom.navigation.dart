import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/modules/stats/screen/stats.screen.dart';

import '../get.hornors/screen/get.hornors.screen.dart';
import '../home/screen/home.screen.dart';
import '../information/screen/information.screen.dart';
import '../set.hornors/screen/set.hornors.screen.dart';

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
      BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Thống kê'),
      BottomNavigationBarItem(
          icon: Icon(Icons.account_circle), label: 'Thông tin'),
    ];

    getPage() {
      switch (_selectedIndex) {
        case 0:
          {
            return const HomeScreen();
          }
        case 1:
          {
            return const GetHornorsScreen();
          }
        case 2:
          {
            return const SetHornorsScreen();
          }
        case 3:
          {
            return const StatsScreen();
          }
        case 4:
          {
            return const InformationScreen();
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
