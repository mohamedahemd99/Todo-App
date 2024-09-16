import 'package:flutter/material.dart';
import 'package:todo_app/core/network/api_path.dart';
import 'package:todo_app/helpers/app_image_paths.dart';
import 'package:todo_app/helpers/custom_colors.dart';
import 'package:todo_app/helpers/size_extension.dart';
import 'package:todo_app/modules/todo/presentation/provider/home_provider.dart';
import 'package:todo_app/widgets/app_size_boxes.dart';

import '../../domain/entities/todo.dart';
import 'popup_menu_widget.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HomeProvider.of(context, isListen: false).getTodoDetails(todo.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image on the left
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                AppApiPaths.setImageUrl(todo.image),
                width: 64.w,
                height: 64.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppImages.testImage,
                    width: 64.w,
                    height: 64.h,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            12.widthBox,

            // Column in the middle with title, subtitle, and status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Status in Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          todo.title,
                          style:
                              Theme.of(context).primaryTextTheme.headlineLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: getStatusBackgroundColor(
                                todo.status.toLowerCase())),
                        child: Text(todo.status,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headlineMedium!
                                .copyWith(
                                    fontSize: 12,
                                    color: getStatusTextColor(
                                        todo.status.toLowerCase()))),
                      )
                    ],
                  ),
                  8.heightBox, // Space between rows
                  Text(
                    todo.desc,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodySmall!
                        .copyWith(
                            fontSize: 14, color: CustomColors.subTitleColor),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.flag_outlined,
                        color: getPriorityColor(todo.priority),
                      ),
                      Text(todo.priority,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headlineMedium!
                              .copyWith(
                                  fontSize: 12,
                                  color: getPriorityColor(todo.priority))),
                    ],
                  ),
                ],
              ),
            ),

            PopupMenuWidget(todoDetails: todo),
          ],
        ),
      ),
    );
  }
}

Color getStatusTextColor(String status) {
  switch (status) {
    case 'inprogress':
      return CustomColors.primaryColor;
    case 'waiting':
      return CustomColors.waitingHighColor;
    case 'finished':
      return CustomColors.finishedLowColor;
    default:
      return CustomColors.finishedLowColor;
  }
}

Color getStatusBackgroundColor(String status) {
  switch (status) {
    case 'inprogress':
      return CustomColors.lighterPrimaryColor;
    case 'waiting':
      return CustomColors.lighterWaitingHighColor;
    case 'finished':
      return CustomColors.lighterFinishedLowColor;
    default:
      return CustomColors.lighterFinishedLowColor;
  }
}

Color getPriorityColor(String priority) {
  switch (priority) {
    case 'low':
      return CustomColors.finishedLowColor;
    case 'medium':
      return CustomColors.primaryColor;
    case 'high':
      return CustomColors.waitingHighColor;
    default:
      return CustomColors.finishedLowColor;
  }
}
