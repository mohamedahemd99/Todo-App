import 'package:flutter/material.dart';
import 'package:todo_app/helpers/app_image_paths.dart';
import 'package:todo_app/helpers/size_extension.dart';

class AppBarWidget {
  final BuildContext context;
  final String title;
  final bool isPrimaryDark;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final Widget? leading;
  final bool isRootScreen;

  AppBarWidget(
    this.context, {
    this.title = '',
    this.actions,
    this.titleWidget,
    this.leading,
    this.isPrimaryDark = true,
    this.isRootScreen = false,
  });

  AppBar build() {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: false,
        title: titleWidget ??
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 16),
            ),
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leadingWidth: !isRootScreen ? 50.w : 20.w,
        actions: actions ?? const [],
        leading: Navigator.of(context).canPop() && !isRootScreen
            ? InkWell(
                child: Image.asset(AppImages.arrowLeft),
                onTap: () => Navigator.of(context).pop(),
              )
            : leading ?? const SizedBox.shrink());
  }
}
