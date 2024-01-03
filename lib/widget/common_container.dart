import 'package:flutter/material.dart';
import 'package:todolist/utils/utils.dart';

class CommandContainer extends StatelessWidget {
  const CommandContainer({super.key, this.child, this.height});
  final Widget? child;
  final double? height;
  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    return Container(
        height: height,
        width: deviceSize.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colorScheme.primaryContainer,
        ),
        child: child);
  }
}
