import 'package:flutter/material.dart';
import 'package:honors_app/modules/home/provider/home.provider.dart';
import 'package:honors_app/modules/home/widget/drawer.dart';
import 'package:honors_app/modules/home/widget/search.item.dart';
import 'package:provider/provider.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/widgets/hornors.item.dart';

import '../widget/search.field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.nameWorkspace});
  final String nameWorkspace;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearch = false;

  final HomeProvider provider = HomeProvider();

  @override
  void initState() {
    super.initState();
    provider.init(widget.nameWorkspace);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: ((context) => provider),
      builder: (context, child) {
        return Consumer<HomeProvider>(builder: (context, model, child) {
          return Scaffold(
              backgroundColor: AppColor.secondary,
              appBar: AppBar(
                backgroundColor: AppColor.primary,
                centerTitle: true,
                title: isSearch
                    ? SearchField(
                        controller: model.searchCTL,
                        label: 'Tìm kiếm',
                        onChange: model.onSearch,
                      )
                    : Text(widget.nameWorkspace),
                actions: [
                  IconButton(
                      onPressed: showSearch,
                      icon: isSearch
                          ? const Icon(Icons.cancel)
                          : const Icon(Icons.search))
                ],
              ),
              drawer: DrawerHome(
                nameWorkspace: widget.nameWorkspace,
              ),
              body: _body(context, model));
        });
      },
    );
  }

  Widget _body(BuildContext context, HomeProvider model) {
    return !isSearch
        ? (model.listHornors.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.listHornors.length,
                    itemBuilder: (BuildContext context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HonorsItems(
                          hornors: model.listHornors[index],
                        ))),
              )
            : Center(
                child: Container(),
              ))
        : SearchItem(
            users: model.listUser,
            model: model,
            workspace: widget.nameWorkspace,
          );
  }

  void showSearch() {
    setState(() {
      isSearch = !isSearch;
    });
    provider.init(widget.nameWorkspace);
  }
}
