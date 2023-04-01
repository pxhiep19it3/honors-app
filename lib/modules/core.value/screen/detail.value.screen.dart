import 'package:flutter/material.dart';
import 'package:honors_app/models/core.value.dart';
import 'package:honors_app/modules/core.value/provider/corevalue.provider.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/values/app.text.dart';
import '../../../common/widgets/basic.button.dart';
import '../../../common/widgets/basic.text.dart';
import '../widget/delete.core.value.dart';

class DetailCoreValue extends StatelessWidget {
  const DetailCoreValue({super.key, required this.item, required this.model});
  final CoreValue item;
  final CoreValueProvider model;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: Text(item.title ?? ''),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                delete(context, model, item);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BasicText(
                controller: model.titleCtl,
                isContent: false,
                isDetail: true,
              ),
              const SizedBox(
                height: 20,
              ),
              BasicText(
                controller: model.contentCtl,
                height: height * 0.4,
                isContent: true,
                isDetail: true,
              ),
              const SizedBox(
                height: 50,
              ),
              BacsicButton(
                  onPressed: () {
                    model.update(item.id ?? '');
                  },
                  label: AppText.btUpdate,
                  width: width,
                  primary: false),
            ],
          ),
        ),
      ),
    );
  }

  void delete(BuildContext context, CoreValueProvider model, CoreValue item) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            DeleteCoreValue(item: item, model: model));
  }
}
