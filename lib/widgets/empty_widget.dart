import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String text;
  final bool expanded;

  const EmptyWidget({
    Key? key,
    this.text = 'no_results_found',
    this.expanded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return expanded
        ? Expanded(
            child: _buildTextWidget(context),
          )
        : _buildTextWidget(context);
  }

  SizedBox _buildTextWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.8,
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
