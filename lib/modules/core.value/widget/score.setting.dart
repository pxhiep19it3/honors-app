import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/modules/core.value/provider/corevalue.provider.dart';

import '../../../common/values/app.text.dart';

class ScoreSetting extends StatefulWidget {
  const ScoreSetting({super.key, required this.model});
  final CoreValueProvider model;

  @override
  State<ScoreSetting> createState() => _ScoreSettingState();
}

class _ScoreSettingState extends State<ScoreSetting> {
  double? end = 10;
  RangeValues? _currentRangeValues;

  @override
  void initState() {
    super.initState();
    setState(() {
      end = widget.model.listCore[0].score!.toDouble();
      _currentRangeValues = RangeValues(1, end!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.gray,
      title: const Center(
          child: Text(AppText.titleScore,
              style: TextStyle(color: AppColor.primary))),
      content: SizedBox(
        height: 100,
        child: RangeSlider(
          activeColor: Colors.red,
          inactiveColor: AppColor.primary,
          values: _currentRangeValues!,
          min: 1,
          max: 10,
          divisions: 9,
          labels: RangeLabels(
            _currentRangeValues!.start.round().toString(),
            _currentRangeValues!.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Thoát'),
          child: const Text('Thoát', style: TextStyle(color: AppColor.primary)),
        ),
        TextButton(
          onPressed: () {
            widget.model.updateScore(
                int.parse(_currentRangeValues!.end.round().toString()));
            Navigator.pop(context, 'Chọn');
          },
          child: const Text('Chọn', style: TextStyle(color: AppColor.primary)),
        ),
      ],
    );
  }
}
