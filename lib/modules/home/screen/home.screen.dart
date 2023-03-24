import 'package:flutter/material.dart';
import 'package:honors_app/modules/home/screen/detail.home.screen.dart';
import 'package:honors_app/modules/home/widget/drawer.dart';
import 'package:honors_app/modules/home/widget/search.item.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/widgets/detail.hornors.dart';
import '../../../common/widgets/hornors.item.dart';
import '../widget/hornors.dart';
import '../widget/search.field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearch = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondary,
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          centerTitle: true,
          title: isSearch
              ? SearchField(
                  controller: controller,
                  label: 'Tìm kiếm',
                )
              : const Text('Doit Solutions'),
          actions: [
            IconButton(
                onPressed: showSearch,
                icon: isSearch
                    ? const Icon(Icons.cancel)
                    : const Icon(Icons.search))
          ],
        ),
        drawer: const DrawerHome(),
        body: _body(context));
  }

  Widget _body(BuildContext context) {
    return !isSearch
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, index) =>
                    const HonorsItems()),
          )
        : SearchItem(
            onTap: () {
              onSearch(context);
            },
            favorite: favorite);
  }

  void showSearch() {
    setState(() {
      isSearch = !isSearch;
    });
  }

  void onTap(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const DetailHornorsScreen(
                  title: '',
                )));
  }

  void onSearch(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const DetailHomeScreen()));
  }

  void favorite() {
    showDialog<String>(
        context: context, builder: (BuildContext context) => const Hornors());
  }
}
