import 'package:flutter/material.dart';
import 'package:honors_app/modules/get.hornors/provider/get.hornors.provider.dart';
import 'package:provider/provider.dart';

import '../../../../common/values/app.colors.dart';
import '../../../common/widgets/hornors.item.dart';
import '../../../common/widgets/show.score.dart';
import '../../home/widget/hornors.dart';

class GetHornorsScreen extends StatefulWidget {
  const GetHornorsScreen({super.key, required this.nameWorkspace});
  final String nameWorkspace;
  @override
  State<GetHornorsScreen> createState() => _GetHornorsScreenState();
}

class _GetHornorsScreenState extends State<GetHornorsScreen> {
  GetHornorsProvider model = GetHornorsProvider();

  @override
  void initState() {
    super.initState();
    model.getSetHornors(widget.nameWorkspace);
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
                      ShowScore(
                        score: model.score,
                        number: model.listHornors.length,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.listHornors.length,
                      itemBuilder: (BuildContext context, index) => InkWell(
                            onTap: () {
                              onTap(model.listHornors[index].userSet ?? '');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: HonorsItems(
                                isHome: false,
                                isGet: true,
                                hornors: model.listHornors[index],
                              ),
                            ),
                          )),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  void onTap(String userGet) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => Hornors(
            name: userGet,
            coreValue: model.listCoreValue,
            setScore: model.setScore,
            setCoreValue: model.setCoreValue,
            controller: model.contentHornors,
            createHornors: model.createHornors));
  }
}
