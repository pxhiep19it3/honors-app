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
                        'Thống kê người được vinh danh theo giá trị\n(${widget.range})',
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
                    ? SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(
                            minimum: 0,
                            maximum: double.parse(model.total.toString()),
                            interval: 1),
                        tooltipBehavior: _tooltip,
                        legend: Legend(
                          textStyle: const TextStyle(fontSize: 20),
                          position: LegendPosition.bottom,
                          overflowMode: LegendItemOverflowMode.wrap,
                          isVisible: true,
                        ),
                        series: <ChartSeries>[
                            BarSeries<GetBestValue, String>(
                                color: AppColor.primary,
                                dataSource: model.getBest,
                                name: 'Biểu đồ',
                                xValueMapper: (GetBestValue data, _) =>
                                    data.name,
                                yValueMapper: (GetBestValue data, _) =>
                                    data.total,
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    color: AppColor.primary,
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
