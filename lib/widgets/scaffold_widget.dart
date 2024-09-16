import 'package:flutter/material.dart';
import 'package:todo_app/helpers/size_extension.dart';

import 'app_bar_widget.dart';

class ScaffoldWidget extends StatelessWidget {
  final Widget? body, titleWidget;
  final String title;
  final bool withAppBar;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar, drawer, bottomSheet;
  final Widget? leading;
  final Widget? floatingActionButton;
  final double paddingH;
  final bool isRootScreen;

  const ScaffoldWidget(
      {Key? key,
      required this.body,
      this.title = '',
      this.withAppBar = true,
      this.drawer,
      this.leading,
      this.floatingActionButton,
      this.paddingH = 20,
      this.backgroundColor,
      this.bottomNavigationBar,
      this.bottomSheet,
      this.titleWidget,
      this.isRootScreen = false,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: withAppBar
          ? AppBarWidget(context,
                  leading: leading,
                  isRootScreen: isRootScreen,
                  title: title,
                  titleWidget: titleWidget,
                  actions: actions)
              .build()
          : null,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingH.w),
        child: body!,
      )),
      drawerEnableOpenDragGesture: false,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      bottomSheet: bottomSheet,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
