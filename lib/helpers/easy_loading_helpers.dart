import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'utils.dart';

class EasyLoadingHelpers {
  static void setup(BuildContext context) {
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.instance.indicatorColor =
        Theme.of(navigatorKey.currentContext!).primaryColor;
    EasyLoading.instance.progressColor =
        Theme.of(navigatorKey.currentContext!).primaryColor;
    EasyLoading.instance.backgroundColor =
        Theme.of(navigatorKey.currentContext!).cardColor;
    EasyLoading.instance.textStyle =
        Theme.of(navigatorKey.currentContext!).textTheme.bodyLarge;
    EasyLoading.instance.textColor =
        Theme.of(navigatorKey.currentContext!).textTheme.bodyLarge!.color;
    EasyLoading.instance.dismissOnTap = true;
    EasyLoading.instance.indicatorColor =
        Theme.of(navigatorKey.currentContext!).focusColor;
  }
}
