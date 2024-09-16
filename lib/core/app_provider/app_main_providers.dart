import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/services/service_locator.dart';

import '../../modules/auth/presentation/controller/auth_provider.dart';
import '../../modules/todo/presentation/provider/home_provider.dart';

class AppMainProvider extends StatelessWidget {
  const AppMainProvider({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            sl(),
            sl(),
            sl(),
            sl(),
            sl(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(
            sl(),
            sl(),
            sl(),
            sl(),
            sl(),
            sl(),
          ),
        ),
      ],
      child: child!,
    );
  }
}
