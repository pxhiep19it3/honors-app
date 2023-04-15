import 'package:flutter/material.dart';
import 'package:honors_app/modules/get.hornors/provider/get.hornors.provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/values/app.colors.dart';
import '../../../common/widgets/hornors.item.dart';
import '../../../common/widgets/show.score.dart';
import '../../../models/user.dart';
import '../../profile/screen/profile.screen.dart';

class GetHornorsScreen extends StatefulWidget {
  const GetHornorsScreen({super.key});

  @override
  State<GetHornorsScreen> createState() => _GetHornorsScreenState();
}

class _GetHornorsScreenState extends State<GetHornorsScreen> {
  GetHornorsProvider model = GetHornorsProvider();
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
    model.init(nameWorkspace!);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider<GetHornorsProvider>(
      create: ((context) => model),
      builder: (context, child) {
        return Consumer<GetHornorsProvider>(builder: (context, model, child) {
          return Scaffold(
            backgroundColor: AppColor.secondary,
            appBar: AppBar(
              backgroundColor: AppColor.primary,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text('Được vinh danh'),
            ),
            body: Column(
              children: [
                Container(
                  height: height * 0.35,
                  width: double.infinity,
                  color: AppColor.primary,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      model.photoURL != null
                          ? SizedBox(
                              height: 120,
                              width: 120,
                              child: CircleAvatar(
                                radius: 110,
                                backgroundImage:
                                    NetworkImage(model.photoURL ?? ''),
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        model.userLogined ?? '',
                        style: const TextStyle(
                            fontSize: 25,
                            color: AppColor.secondary,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        model.emailLogin ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16,
                            color: AppColor.secondary,
                            fontWeight: FontWeight.w100),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      model.photoURL != null
                          ? ShowScore(
                              score: model.score,
                              number: model.listHornors.length,
                            )
                          : Container()
                    ],
                  ),
                ),
                Expanded(
                    child: model.listHornors.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.listHornors.length,
                            itemBuilder: (BuildContext context, index) =>
                                InkWell(
                                  onTap: () async {
                                    Users u = await model.getUser(
                                        model.listHornors[index].userSet ?? '');
                                    onTap(u, model);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: HonorsItems(
                                      isHome: false,
                                      isGet: true,
                                      hornors: model.listHornors[index],
                                    ),
                                  ),
                                ))
                        : const Center(child: Text('Chưa có dữ liệu!'),)),
              ],
            ),
          );
        });
      },
    );
  }

  void onTap(Users u, GetHornorsProvider model) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                ProfileScreen(user: u, workspace: nameWorkspace ?? '')));
  }
}
