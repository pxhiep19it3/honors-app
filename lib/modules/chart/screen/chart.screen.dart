import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:honors_app/modules/chart/widget/value.best.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import '../../../common/values/app.colors.dart';
import '../../../service/admob.repo.dart';
import '../widget/navigator.dart';
import '../widget/set.best.widget.dart';
import '../widget/get.best.widget.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  int index = 0;
  String _range = '';
  BannerAd? bannerAd;
  bool isAdLoad = false;
  bool selectTime = false;
  String nameWorkspace = '';
  String start = DateTime.now()
      .subtract(const Duration(days: 30))
      .toString()
      .substring(0, 10)
      .replaceAll(RegExp('-'), '/')
      .split('/')
      .reversed
      .join('/');
  String end = DateTime.now()
      .toString()
      .substring(0, 10)
      .replaceAll(RegExp('-'), '/')
      .split('/')
      .reversed
      .join('/');

  @override
  void initState() {
    init();
    initBannnerAd();
    setState(() {
      _range = '$start - $end';
    });
    super.initState();
  }

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameWorkspace = prefs.getString('nameWorkspace')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColor.secondary,
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          centerTitle: true,
          title: const Text('Thống kê'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    selectTime = !selectTime;
                  });
                },
                icon: selectTime
                    ? const Icon(Icons.filter_alt_off)
                    : const Icon(Icons.filter_alt))
          ],
        ),
        drawer: Drawer(
          backgroundColor: AppColor.primary,
          child: NavigationItem(
            nameWorkspace: nameWorkspace,
            onTap: onTap,
          ),
        ),
        bottomNavigationBar: isAdLoad
            ? SizedBox(
                height: bannerAd!.size.height.toDouble(),
                width: double.infinity,
                child: AdWidget(ad: bannerAd!),
              )
            : null,
        body: main(height, width));
  }

  Widget main(double height, double width) {
    if (selectTime == true) {
      return Stack(
        alignment: Alignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                selectTime = false;
              });
            },
            child: Container(),
          ),
          _selectTime(height, width)
        ],
      );
    } else {
      return index == 0
          ? ValueBestWidget(
              height: height,
              range: _range,
            )
          : index == 1
              ? SetBestWidget(
                  height: height,
                  range: _range,
                )
              : GetBestWidget(
                  height: height,
                  range: _range,
                );
    }
  }

  onTap(int i) {
    setState(() {
      index = i;
    });
  }

  Widget _selectTime(double height, double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      child: Container(
        height: height * 0.6,
        width: width * 0.8,
        decoration: BoxDecoration(border: Border.all(color: AppColor.primary)),
        child: SfDateRangePicker(
          showActionButtons: true,
          confirmText: 'Chọn',
          cancelText: 'Thoát',
          onSubmit: (
            dynamic t,
          ) {
            setState(() {
              selectTime = false;
            });
          },
          onCancel: () {
            setState(() {
              selectTime = false;
            });
          },
          onSelectionChanged: _onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,
          initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 30)),
              DateTime.now()),
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      }
    });
  }

  initBannnerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdMobRepo.adUnitIdJoin!,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isAdLoad = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }),
        request: const AdRequest());
    bannerAd!.load();
  }
}
