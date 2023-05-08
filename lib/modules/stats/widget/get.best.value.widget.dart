import 'package:flutter/material.dart';
import 'package:honors_app/models/get.best.value.dart';
import 'package:honors_app/modules/stats/widget/select.value.widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../common/values/app.colors.dart';
import '../provider/get.best.value.provider.dart';

class GetBestValueWidget extends StatefulWidget {
  const GetBestValueWidget({
    super.key,
    required this.height,
    required this.range,
  });
  final double height;
  final String range;
  @override
  State<GetBestValueWidget> createState() => _GetBestValueWidgetState();
}

class _GetBestValueWidgetState extends State<GetBestValueWidget> {
  final TooltipBehavior _tooltip = TooltipBehavior(enable: true);
  GetBestValueProvider provider = GetBestValueProvider();
  @override
  void initState() {
    super.initState();
    provider.init(widget.range);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GetBestValueProvider>(
      create: ((context) => provider),
      builder: ((context, child) {
        return Consumer<GetBestValueProvider>(builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                        'Thống kê người được vinh danh nhiều nhất theo giá trị\n(${widget.range})',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColor.black)),
                  ),
                ),
                model.titleValue.isNotEmpty
                    ? SelectValue(
                        coreValue: model.titleValue,
                        setCoreValue: (String value) {
                          model.setCoreValue(value, widget.range);
                        })
                    : const SizedBox(),
                model.getBest.isNotEmpty
                    ? SfCircularChart(
                        tooltipBehavior: _tooltip,
                        legend: Legend(
                          textStyle: const TextStyle(fontSize: 20),
                          position: LegendPosition.bottom,
                          overflowMode: LegendItemOverflowMode.wrap,
                          isVisible: true,
                        ),
                        series: <CircularSeries>[
                            DoughnutSeries<GetBestValue, String>(
                                dataSource: model.getBest,
                                xValueMapper: (GetBestValue data, _) =>
                                    data.name,
                                yValueMapper: (GetBestValue data, _) =>
                                    data.total,
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    textStyle: TextStyle(fontSize: 20)))
                          ])
                    : const Center(child: Text('Chưa có dữ liệu!'))
              ],
            ),
          );
        });
      }),
    );
  }
}
