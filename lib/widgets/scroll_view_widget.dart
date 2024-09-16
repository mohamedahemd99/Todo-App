import 'package:flutter/material.dart';

class ScrollViewWidget extends StatelessWidget {

  final Widget child;

  const ScrollViewWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(),
        child: SafeArea(
          child: child,
        ),
      ),
    );
  }
}
