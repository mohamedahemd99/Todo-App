import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final double thickness;
  final Color? color;
  final bool isExpanded;

  const DividerWidget({
    Key? key,
    this.thickness = 1,
    this.color,
    this.isExpanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Expanded(child: _buildDividerWidget(context))
        : _buildDividerWidget(context);
  }

  Divider _buildDividerWidget(BuildContext context) {
    return Divider(
      color: color ?? Theme.of(context).dividerColor,
      height: 0,
      thickness: thickness,
    );
  }
}
