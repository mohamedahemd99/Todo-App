import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/network/dio_helper.dart';
import 'package:todo_app/helpers/preferences/pref_manager.dart';
import 'package:todo_app/widgets/theme_widget.dart';

import 'core/app_provider/app_main_providers.dart';
import 'core/services/service_locator.dart';
import 'helpers/constants.dart';
import 'helpers/utils.dart';
import 'modules/auth/presentation/screens/splash/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefManager.setupSharedPreferences();
  await ScreenUtil.ensureScreenSize();

  DioHelper.init();
  ServiceLocator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
      statusBarIconBrightness: Brightness.dark,
    ));

    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => AppMainProvider(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              title: Constants.appName,
              theme: ThemeWidget().lightBuild(),
              builder: EasyLoading.init(
                builder: (context, child) => Scaffold(
                  body: GestureDetector(
                    onTap: () => clearFocus(context),
                    child: child,
                  ),
                ),
              ),
              home: const SplashView())),
    );
  }
}
