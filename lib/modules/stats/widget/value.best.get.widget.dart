import 'package:flutter/material.dart';
import 'package:honors_app/models/value.best.get.dart';
import 'package:honors_app/modules/stats/provider/value.best.get.provider.dart';
import 'package:honors_app/modules/stats/widget/select.value.widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../common/values/app.colors.dart';

class ValueBestGetWidget extends StatefulWidget {
  const ValueBestGetWidget({
    super.key,
    required this.height,
    required this.range,
  });
  final double height;
  final String range;
  @override
  State<ValueBestGetWidget> createState() => _ValueBestGetWidgetState();
}

class _ValueBestGetWidgetState extends State<ValueBestGetWidget> {
  final TooltipBehavior _tooltip = TooltipBehavior(enable: true);
  ValueBestGetProvider provider = ValueBestGetProvider();
  @override
  void initState() {
    super.initState();
    provider.init(widget.range);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueBestGetProvider>(
      create: ((context) => provider),
      builder: ((context, child) {
        return Consumer<ValueBestGetProvider>(builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                        'Thống kê giá trị cốt lõi theo người được vinh danh\n(${widget.range})',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColor.black)),
                  ),
                ),
                model.name.isNotEmpty
                    ? SelectValue(
                        coreValue: model.name,
                        setCoreValue: (String value) {
                          model.setValue(value, widget.range);
                        })
                    : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
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
                            BarSeries<ValueBestGet, String>(
                                color: AppColor.primary,
                                dataSource: model.getBest,
                                name: 'Biểu đồ',
                                xValueMapper: (ValueBestGet data, _) =>
                                    data.name,
                                yValueMapper: (ValueBestGet data, _) =>
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
