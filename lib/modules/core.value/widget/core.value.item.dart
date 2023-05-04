import 'package:flutter/material.dart';
import 'package:honors_app/models/core.value.dart';

class CoreValueItem extends StatelessWidget {
  const CoreValueItem({super.key, required this.item});

  final CoreValue item;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title ?? ""),
      subtitle: Text(item.content ?? ""),
    );
  }
}
