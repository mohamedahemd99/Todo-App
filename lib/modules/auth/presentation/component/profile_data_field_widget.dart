import 'package:flutter/material.dart';
import 'package:todo_app/helpers/custom_colors.dart';
import 'package:todo_app/helpers/size_extension.dart';

class ProfileDataFieldWidget extends StatelessWidget {
  const ProfileDataFieldWidget(
      {super.key, required this.title, required this.data});

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
      decoration: BoxDecoration(
          color: CustomColors.backgroundProfileFieldColor,
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 12,
                color: CustomColors.titleProfileFieldColor.withOpacity(0.4)),
          ),
          Text(
            data,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 18,
                color: CustomColors.titleProfileFieldColor.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
