import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

bool get isInLandscape {
  return MediaQuery.of(navigatorKey.currentContext!).orientation ==
      Orientation.landscape;
}

String get currentLanguageCode {
  return Localizations.localeOf(navigatorKey.currentContext!).toString();
}

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

Future<bool> isTablet(BuildContext context) async {
  if (Platform.isIOS) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    return iosInfo.model.toLowerCase() == 'ipad';
  } else {
    // The equivalent of the 'smallestWidth' qualifier on Android.
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    // Determine if we should use mobile layout or not, 600 here is
    // a common breakpoint for a typical 7-inch tablet.
    return shortestSide > 600;
  }
}

Future<String> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

Future<Map> getDeviceDataParams({bool forContactUs = false}) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String id = '';
  int typeId = 0;
  String info = '';
  String version = packageInfo.version;

  if (Platform.isAndroid) {
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final data = androidInfo.data;
    GooglePlayServicesAvailability googlePlayServicesAvailability =
        await GoogleApiAvailability.instance
            .checkGooglePlayServicesAvailability();

    data["platform"] = "Android";
    info = json.encode(data);
    typeId =
        googlePlayServicesAvailability == GooglePlayServicesAvailability.success
            ? 1
            : 3;
    id = androidInfo.id.toString();
  } else {
    final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    final data = iosInfo.toMap();
    data["platform"] = "iOS";
    info = json.encode(data);
    typeId = 2;
    id = iosInfo.identifierForVendor ?? '';
  }

  Map<String, String> params;

  if (forContactUs) {
    params = {
      "dvsId": id,
      "dvsTyp": typeId.toString(),
      "dvsInfo": info,
      "dvcVrsn": version
    };
  } else {
    params = {
      "id": id,
      "typeId": typeId.toString(),
      "info": info,
      "version": version
    };
  }
  debugPrint(params.toString());
  logger.d(params);
  return params;
}

void openScreen(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
}

void pushScreen(BuildContext context, Widget screen) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => screen), (route) => false);
}

Future<bool> isConnectedToNetwork() async {
  try {
    final result = await InternetAddress.lookup('google.com')
        .timeout(const Duration(seconds: 30));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      logger.d('connected to network');
      return true;
    }
  } on SocketException catch (_) {}
  logger.w('not connected to the network');
  return false;
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
