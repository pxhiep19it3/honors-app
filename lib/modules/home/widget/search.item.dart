import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import '../../../models/user.dart';
import '../../profile/screen/profile.screen.dart';
import '../provider/home.provider.dart';
import '../../../common/widgets/hornors.dart';

class SearchItem extends StatelessWidget {
  const SearchItem(
      {super.key,
      required this.users,
      required this.model,
      required this.workspace});
  final List<Users> users;
  final HomeProvider model;
  final String workspace;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: users.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  onTap(context, users[index].displayName ?? '', model);
                },
                title: Text(users[index].displayName ?? ''),
                trailing: IconButton(
                  onPressed: () {
                    view(context, users[index], workspace);
                  },
                  icon: const Icon(
                    Icons.view_array,
                    color: AppColor.primary,
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

  void onTap(BuildContext context, String name, HomeProvider model) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => Hornors(
            name: name,
            coreValue: model.listCoreValue,
            setScore: model.setScore,
            setCoreValue: model.setCoreValue,
            controller: model.contentHornors,
            createHornors: model.createHornors));
  }

  void view(BuildContext context, Users user, String workspace) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ProfileScreen(user: user, workspace: workspace)));
  }
}
