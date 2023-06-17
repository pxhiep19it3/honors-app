import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.images.dart';
import 'package:honors_app/modules/sponsors/sponsors.item.screen.dart';

import '../../common/values/app.colors.dart';

class SponsorsScreen extends StatelessWidget {
  const SponsorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColor.primary,
            centerTitle: true,
            title: const Text('Các nhà bảo trợ'),
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios))),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SponsorsItemScreen(
                                title: 'DOIT SOLUTIONS',
                                link: 'https://doitsolutions.vn/')));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: Image.asset(
                          AppImage.logoDoit,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'CÔNG TY TNHH DOIT SOLUTIONS',
                        style: TextStyle(
                            color: AppColor.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SponsorsItemScreen(
                                title: 'UDOO', link: 'https://udoo.live/')));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: Image.asset(
                          AppImage.logoUdoo,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'CÔNG TY TNHH UDOO',
                        style: TextStyle(
                            color: AppColor.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SponsorsItemScreen(
                                title: 'VÙNG KIẾM TIỀN',
                                link: 'https://vungkiemtien.com/')));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        child: Image.asset(
                          width: double.infinity,
                          height: 60,
                          AppImage.logoVKT2,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'VÙNG KIẾM TIỀN',
                        style: TextStyle(
                            color: AppColor.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
