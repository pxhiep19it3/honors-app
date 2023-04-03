import 'package:flutter/material.dart';
import '../../../models/core.value.dart';
import '../../../models/user.dart';
import '../provider/home.provider.dart';
import 'hornors.dart';

class SearchItem extends StatelessWidget {
  const SearchItem(
      {super.key,
      required this.onTap,
      required this.users,
      required this.model});
  final VoidCallback onTap;
  final List<Users> users;
  final HomeProvider model;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: users.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                onTap: onTap,
                title: Text(users[index].displayName ?? ''),
                trailing: IconButton(
                  onPressed: () {
                    favorite(context, model.listCoreValue,
                        users[index].displayName ?? '', model);
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
              const Divider(
                height: 2,
                thickness: 2,
              )
            ],
          );
        });
  }

  void favorite(BuildContext context, List<CoreValue> coreValue, String name,
      HomeProvider model) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => Hornors(
              name: name,
              coreValue: coreValue,
              setScore: model.setScore,
              setCoreValue: model.setCoreValue,
              controller: model.contentHornors,
              createHornors: model.createHornors
            ));
  }
}
