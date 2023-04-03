import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';

class SelectScore extends StatefulWidget {
  const SelectScore({super.key, required this.score,required this.setScore});
  final double score;
  final Function(int)? setScore;

  @override
  State<SelectScore> createState() => _SelectScoreState();
}

class _SelectScoreState extends State<SelectScore> {
  double? end = 10;
  RangeValues? _currentRangeValues;
  int divisions = 10;
  @override
  void initState() {
    super.initState();
    setState(() {
      end = widget.score.toDouble();
      _currentRangeValues = RangeValues(1, end!);
      divisions = end!.toInt() - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      activeColor: Colors.blue,
      inactiveColor: AppColor.primary,
      values: _currentRangeValues!,
      min: 1,
      max: end!,
      divisions: divisions,
      labels: RangeLabels(
        _currentRangeValues!.start.round().toString(),
        _currentRangeValues!.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _currentRangeValues = values;
        });
        widget.setScore!(values.end.toInt());
      },
    );
  }
  

}
