import 'package:flutter/material.dart';

import '../helpers/utils.dart';

class InputDecorationWidget {
  InputDecoration build({
    String hint = '',
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      filled: true,
      fillColor: hint != 'search'
          ? Theme.of(navigatorKey.currentContext!).scaffoldBackgroundColor
          : Theme.of(navigatorKey.currentContext!).shadowColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: hint != 'search'
              ? Theme.of(navigatorKey.currentContext!).primaryColor
              : Theme.of(navigatorKey.currentContext!).shadowColor,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(navigatorKey.currentContext!).primaryColor,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(navigatorKey.currentContext!).colorScheme.error,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(navigatorKey.currentContext!).colorScheme.error,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      alignLabelWithHint: true,
      hintText: hint,
      hintStyle: Theme.of(navigatorKey.currentContext!).textTheme.displaySmall,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
}
