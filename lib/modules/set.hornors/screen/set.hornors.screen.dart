import 'package:flutter/material.dart';
import 'package:honors_app/models/user.dart';
import 'package:honors_app/modules/set.hornors/provider/set.hornors.provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/values/app.colors.dart';
import '../../../common/widgets/hornors.item.dart';
import '../../profile/screen/profile.screen.dart';

class SetHornorsScreen extends StatefulWidget {
  const SetHornorsScreen({super.key});

  @override
  State<SetHornorsScreen> createState() => _SetHornorsScreenState();
}

class _SetHornorsScreenState extends State<SetHornorsScreen> {
  SetHornorsProvider provider = SetHornorsProvider();
   String? nameWorkspace;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameWorkspace = prefs.getString('nameWorkspace');
    });
    provider.init(nameWorkspace!);
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SetHornorsProvider>(
      create: ((context) => provider),
      builder: (context, child) {
        return Consumer<SetHornorsProvider>(builder: (context, model, child) {
          return Scaffold(
              backgroundColor: AppColor.secondary,
              appBar: AppBar(
                backgroundColor: AppColor.primary,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: const Text('Đã vinh danh'),
              ),
              body: model.listHornors.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: model.listHornors.length,
                          itemBuilder: (BuildContext context, index) => InkWell(
                                onTap: () async {
                                  Users u = await model.getUser(
                                      model.listHornors[index].userGet ?? '');
                                  onTap(u, model);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: HonorsItems(
                                      hornors: model.listHornors[index],
                                      isHome: false,
                                    )),
                              )),
                    )
                  : const Center(child: Text('Chưa có dữ liệu!'),));
        });
      },
    );
  }

  void onTap(Users u, SetHornorsProvider model) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ProfileScreen(user: u, workspace: nameWorkspace ?? '')));
  }
}
