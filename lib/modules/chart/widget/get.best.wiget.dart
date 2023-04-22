import 'package:flutter/material.dart';
import 'package:honors_app/models/get.best.dart';
import 'package:honors_app/modules/chart/provider/get.best.provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../common/values/app.colors.dart';

class GetBestWidget extends StatefulWidget {
  const GetBestWidget({
    super.key,
    required this.height,
    required this.range,
  });
  final double height;
  final String range;
  @override
  State<GetBestWidget> createState() => _GetBestWidgetState();
}

class _GetBestWidgetState extends State<GetBestWidget> {
  final TooltipBehavior _tooltip = TooltipBehavior(enable: true);
  GetBestProvider provider = GetBestProvider();

  @override
  void initState() {
    super.initState();
    provider.init(widget.range);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GetBestProvider>(
      create: ((context) => provider),
      builder: ((context, child) {
        return Consumer<GetBestProvider>(builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: widget.height * 0.7,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  model.getBest.isEmpty
                      ? const Text('Chưa có dữ liệu!')
                      : Container(),
                  SfCircularChart(
                      title: ChartTitle(
                          text:
                              'Người được vinh danh nhiều nhất\n(${widget.range})',
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
                        DoughnutSeries<GetBest, String>(
                            dataSource: model.getBest,
                            xValueMapper: (GetBest data, _) => data.name,
                            yValueMapper: (GetBest data, _) => data.total,
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
