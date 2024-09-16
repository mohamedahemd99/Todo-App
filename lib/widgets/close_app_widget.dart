import 'package:flutter/material.dart';

class CloseAppWidget extends StatelessWidget {
  final Widget? child;

  const CloseAppWidget(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPopCallback(context),
      child: child!,
    );
  }

  Future<bool> _willPopCallback(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Are you sure?',
            ),
            content: const Text(
              'الخروج من التطبيق',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'لا',
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'نعم',
                ),
              ),
            ],
          ),
        )) ??
        false; // return true if the route to be popped
  }
}
