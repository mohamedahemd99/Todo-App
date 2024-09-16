import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenInit extends StatelessWidget {
  const ScreenInit({required this.builder});
  final Widget Function(BuildContext, Widget?) builder;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: builder,
    );
  }
}
