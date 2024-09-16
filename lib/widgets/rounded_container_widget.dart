import 'package:flutter/material.dart';



class RoundedContainer extends StatelessWidget {

  final Widget child;
  final double outerPaddingVertical;
  final double outerPaddingHorizontal;
  final double internalPaddingVertical;
  final double internalPaddingHorizontal;
  final double height;

  const RoundedContainer({
    Key? key,
    required this.child,
    this.outerPaddingVertical = 10,
    this.outerPaddingHorizontal = 16,
    this.internalPaddingVertical = 22,
    this.internalPaddingHorizontal = 11,
    this.height = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: outerPaddingVertical, horizontal: outerPaddingHorizontal),
      child: Container(
        height: height == 0 ? MediaQuery.of(context).size.height : height,
        padding: EdgeInsets.symmetric(vertical: internalPaddingVertical, horizontal: internalPaddingHorizontal),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: child,
      ),
    );
  }
}
