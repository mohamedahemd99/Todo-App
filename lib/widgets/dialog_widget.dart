import 'package:flutter/material.dart';

roundedDialogWidget(Widget child) => Dialog(
    insetPadding: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: child,
    ));
