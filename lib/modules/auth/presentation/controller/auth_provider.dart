import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/helpers/preferences/pref_manager.dart';
import 'package:todo_app/modules/auth/domain/entities/user.dart';
import 'package:todo_app/modules/auth/domain/usecase/login_use_case.dart';
import 'package:todo_app/modules/auth/domain/usecase/logout_use_case.dart';
import 'package:todo_app/modules/auth/domain/usecase/profile_use_case.dart';
import 'package:todo_app/modules/auth/domain/usecase/refresh_token_use_case.dart';
import 'package:todo_app/modules/auth/domain/usecase/register_use_case.dart';
import 'package:todo_app/modules/auth/presentation/screens/profile/profile_view.dart';
import 'package:todo_app/modules/todo/presentation/screens/home/home_view.dart';

import '../../../../core/services/enums.dart';
import '../../../../helpers/navigator.dart';
import '../../../../helpers/preferences/pref_manager_constants.dart';
import '../../../../helpers/utils.dart';
import '../screens/splash/splash_view.dart';

class AuthProvider extends ChangeNotifier {
  static AuthProvider of(BuildContext context, {bool isListen = true}) {
    return Provider.of<AuthProvider>(context, listen: isListen);
  }

  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final RegisterUseCase registerUseCase;
  final RefreshTokenUseCase refreshTokenUseCase;
  final ProfileUseCase profileUseCase;
  String countryCode = '+20';
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController yearsOfExperienceCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  ExperienceLevel? selectedLevel;
  User? userProfile;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  AuthProvider(this.loginUseCase, this.logoutUseCase, this.registerUseCase,
      this.refreshTokenUseCase, this.profileUseCase);

  void loginUser({
    required String phone,
    required String password,
  }) async {
    await EasyLoading.show();
    final result = await loginUseCase(phone, password);
    result.fold(
      (l) {
        EasyLoading.showError(l.errorMessageModel.message ?? "");
      },
      (r) {
        phoneCtrl.clear();
        passwordCtrl.clear();
        PrefManager.setToken(r.accessToken);
        PrefManager.setRefreshToken(r.refreshToken);
        EasyLoading.showSuccess("hello ${r.displayName}");
        popALlAndPushPage(navigatorKey.currentContext!, const HomeView());
      },
    );
  }

  void register(
      {required String phone,
      required String password,
      required String displayName,
      required int experienceYears,
      required String address,
      required String level}) async {
    await EasyLoading.show();

    final result = await registerUseCase(
        phone: phone,
        password: password,
        level: level,
        address: address,
        experienceYears: experienceYears,
        displayName: displayName);
    result.fold(
      (l) {
        EasyLoading.showError(l.errorMessageModel.message ?? "");
      },
      (r) {
        phoneCtrl.clear();
        passwordCtrl.clear();
        addressCtrl.clear();
        yearsOfExperienceCtrl.clear();
        nameCtrl.clear();
        selectedLevel = null;
        PrefManager.setToken(r.accessToken);
        PrefManager.setRefreshToken(r.refreshToken);
        EasyLoading.showSuccess("hello ${r.displayName}");
        popALlAndPushPage(navigatorKey.currentContext!, const HomeView());
      },
    );
  }

  Future<void> logoutUser() async {
    final result = await logoutUseCase();
    result.fold(
      (l) async {
        if (l.errorMessageModel.statusCode == 401) {
          await refreshToken().then((onValue) {
            logoutUser();
          });
        }
      },
      (r) async {
        await PrefManager.clearAllPreferencesExcept(
            [PrefManagerConstants.firstLaunchKey]);
        popALlAndPushPage(navigatorKey.currentContext!, const SplashView());
      },
    );
  }

  Future<void> refreshToken() async {
    final result = await refreshTokenUseCase();
    result.fold(
      (l) async {
        await PrefManager.clearAllPreferencesExcept(
            [PrefManagerConstants.firstLaunchKey]);
        popALlAndPushPage(navigatorKey.currentContext!, const SplashView());
        EasyLoading.dismiss();
      },
      (r) {
        PrefManager.setToken(r.accessToken);
      },
    );
  }

  void profileUser() async {
    final result = await profileUseCase();
    result.fold(
      (l) {
        if (l.errorMessageModel.statusCode == 401) {
          refreshToken().then((onValue) {
            profileUser();
            EasyLoading.dismiss();
          });
        } else {
          EasyLoading.showError(l.errorMessageModel.message ?? "");
        }
      },
      (r) {
        userProfile = r;
        if (userProfile != null) {
          pushView(
              navigatorKey.currentContext!,
              ProfileView(
                userProfile: userProfile!,
              ));
        }
      },
    );
  }

  void setCountryCode(value) {
    countryCode = value;
    notifyListeners();
  }

  void setLevel(value) {
    selectedLevel = value;
    notifyListeners();
  }

  String getExperienceLevelString(ExperienceLevel level) {
    switch (level) {
      case ExperienceLevel.fresh:
        return 'Fresh';
      case ExperienceLevel.junior:
        return 'Junior';
      case ExperienceLevel.midLevel:
        return 'Mid Level';
      case ExperienceLevel.senior:
        return 'Senior';
      default:
        return '';
    }
  }
}
