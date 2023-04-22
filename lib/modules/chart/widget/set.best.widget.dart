import 'package:flutter/material.dart';
import 'package:honors_app/models/set.best.dart';
import 'package:honors_app/modules/chart/provider/set.best.provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../common/values/app.colors.dart';

class SetBestWidget extends StatefulWidget {
  const SetBestWidget({
    super.key,
    required this.height,
    required this.range,
  });
  final double height;
  final String range;
  @override
  State<SetBestWidget> createState() => _SetBestWidgetState();
}

class _SetBestWidgetState extends State<SetBestWidget> {
  final TooltipBehavior _tooltip = TooltipBehavior(enable: true);
  SetBestProvider provider = SetBestProvider();

  @override
  void initState() {
    super.initState();
    provider.init(widget.range);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SetBestProvider>(
      create: ((context) => provider),
      builder: ((context, child) {
        return Consumer<SetBestProvider>(builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: widget.height * 0.7,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  model.setBest.isEmpty
                      ? const Text('Chưa có dữ liệu!')
                      : Container(),
                  SfCircularChart(
                      title: ChartTitle(
                          text: 'Người vinh danh nhiều nhất\n(${widget.range})',
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black)),
                      legend: Legend(
                        textStyle: const TextStyle(fontSize: 20),
                        position: LegendPosition.bottom,
                        overflowMode: LegendItemOverflowMode.wrap,
                        isVisible: true,
                      ),
                      tooltipBehavior: _tooltip,
                      series: <CircularSeries>[
                        DoughnutSeries<SetBest, String>(
                            dataSource: model.setBest,
                            xValueMapper: (SetBest data, _) => data.name,
                            yValueMapper: (SetBest data, _) => data.total,
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
