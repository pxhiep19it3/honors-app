import 'package:flutter/material.dart';

import '../../../common/values/app.colors.dart';

class UpdateProScreen extends StatefulWidget {
  const UpdateProScreen({super.key});

  @override
  State<UpdateProScreen> createState() => _UpdateProScreenState();
}

class _UpdateProScreenState extends State<UpdateProScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: const Text('Nâng cấp gói'),
      ),
    );
  }
}
