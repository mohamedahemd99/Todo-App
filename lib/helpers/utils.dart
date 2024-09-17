import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Logger logger = Logger(
  printer: PrettyPrinter(
    printTime: true,
    methodCount: 1,
    errorMethodCount: 2,
    colors: false,
  ),
);

void clearFocus(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

extension StringExtension on String {
  String get capitalized {
    return length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  }

  int get toInt {
    try {
      return int.parse(this);
    } catch (e) {
      logger.e(e.toString());
    }
    return 0;
  }

  double get toDouble {
    try {
      return double.parse(this);
    } catch (e) {
      logger.e(e.toString());
    }
    return 0;
  }

  Map<String, dynamic> get toJsonMap {
    try {
      if (isEmpty) {
        return {};
      } else {
        return jsonDecode(this);
      }
    } catch (e) {
      // logger.e(e);
      // logger.e(this);
      return {};
    }
  }
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
