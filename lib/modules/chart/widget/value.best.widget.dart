import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../common/values/app.colors.dart';
import '../../../models/value.best.dart';
import '../provider/value.best.provider.dart';

class ValueBestWidget extends StatefulWidget {
  const ValueBestWidget({
    super.key,
    required this.height,
    required this.range,
  });
  final double height;
  final String range;

  @override
  State<ValueBestWidget> createState() => _ValueBestWidgetState();
}

class _ValueBestWidgetState extends State<ValueBestWidget> {
  final TooltipBehavior _tooltip = TooltipBehavior(enable: true);
  ValueBestProvider provider = ValueBestProvider();

  @override
  void initState() {
    super.initState();
    provider.init(widget.range);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueBestProvider>(
      create: ((context) => provider),
      builder: ((context, child) {
        return Consumer<ValueBestProvider>(builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: widget.height * 0.7,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  model.valueBest.isEmpty
                      ? const Text('Chưa có dữ liệu!')
                      : Container(),
                  SfCircularChart(
                      title: ChartTitle(
                          text: 'Thống kê giá trị cốt lõi\n(${widget.range})',
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black)),
                      tooltipBehavior: _tooltip,
                      legend: Legend(
                        textStyle: const TextStyle(fontSize: 20),
                        position: LegendPosition.bottom,
                        overflowMode: LegendItemOverflowMode.wrap,
                        isVisible: true,
                      ),
                      series: <CircularSeries>[
                        DoughnutSeries<ValueBest, String>(
                            dataSource: model.valueBest,
                            pointColorMapper: (ValueBest data, _) => data.color,
                            xValueMapper: (ValueBest data, _) => data.title,
                            yValueMapper: (ValueBest data, _) => data.total,
                            dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                textStyle: TextStyle(fontSize: 20)))
                      ]),
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}
