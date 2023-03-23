import 'package:flutter/material.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/values/app.text.dart';
import '../../../common/widgets/basic.button.dart';
import '../../../common/widgets/basic.text.dart';

class DetailCoreValue extends StatelessWidget {
  const DetailCoreValue({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextEditingController cont = TextEditingController(text: 'Tiêu đề');
    TextEditingController controller = TextEditingController(
        text:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.');
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BasicText(
                controller: cont,
                isContent: false,
              ),
              const SizedBox(
                height: 20,
              ),
              BasicText(
                controller: controller,
                height: height * 0.4,
                isContent: true,
              ),
              const SizedBox(
                height: 50,
              ),
              BacsicButton(
                  onPressed: () {},
                  label: AppText.btUpdate,
                  width: width,
                  primary: false),
            ],
          ),
        ),
      ),
    );
  }
}
