import 'package:flutter/material.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/widgets/basic.text.dart';

class DetailSetHornorsScreen extends StatelessWidget {
  const DetailSetHornorsScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    TextEditingController cont = TextEditingController(text: 'Giá trị cốt lõi');
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
                isDetail: true,
              ),
              const SizedBox(
                height: 20,
              ),
              BasicText(
                controller: controller,
                height: height * 0.4,
                isContent: true,
                isDetail: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
