import 'package:flutter/material.dart';
import 'package:todo_app/helpers/utils.dart';

import '../../../../core/services/enums.dart';
import '../../../../helpers/custom_colors.dart';
import '../provider/home_provider.dart';

class SelectionRow extends StatelessWidget {
  const SelectionRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: Status.values.map((status) {
        String statusStr = status.name;
        return GestureDetector(
          onTap: () {
            HomeProvider.of(context, isListen: false).setStatus(statusStr);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: HomeProvider.of(context).selectedStatus == statusStr
                  ? CustomColors.primaryColor
                  : CustomColors.lighterPrimaryColor,
            ),
            child: Text(
              statusStr.capitalized,
              style: TextStyle(
                color: HomeProvider.of(context).selectedStatus == statusStr
                    ? Colors.white
                    : CustomColors.subTitleColor,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
