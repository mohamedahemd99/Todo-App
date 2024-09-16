import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:todo_app/core/network/api_path.dart';
import 'package:todo_app/helpers/app_image_paths.dart';
import 'package:todo_app/modules/todo/domain/entities/todo.dart';
import 'package:todo_app/modules/todo/presentation/component/popup_menu_widget.dart';
import 'package:todo_app/modules/todo/presentation/provider/home_provider.dart';
import 'package:todo_app/widgets/app_size_boxes.dart';
import 'package:todo_app/widgets/form_fields/app_input_text_field.dart';

import '../../../../../helpers/custom_colors.dart';
import '../../../../../widgets/scaffold_widget.dart';

class TodoDetailsView extends StatelessWidget {
  const TodoDetailsView({super.key, required this.todoDetails});

  final Todo todoDetails;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: "Task Details",
      actions: [
        PopupMenuWidget(todoDetails: todoDetails),
      ],
      body: ListView(
        children: [
          Image.network(
            AppApiPaths.setImageUrl(todoDetails.image),
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AppImages.testImage,
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ),
          16.heightBox,
          Text(todoDetails.title,
              style: Theme.of(context).primaryTextTheme.headlineLarge),
          16.heightBox,
          Text(
            todoDetails.desc,
            style: Theme.of(context).primaryTextTheme.headlineSmall!.copyWith(
                fontSize: 14,
                color: CustomColors.titleColor.withOpacity(0.6),
                height: 2),
          ),
          16.heightBox,
          AppTextInputField(
            enabled: false,
            suffix: const Icon(
              Icons.arrow_drop_down,
              color: CustomColors.primaryColor,
            ),
            controller: HomeProvider.of(context).statusController,
            fillColor: CustomColors.lighterPrimaryColor,
            borderColor: Colors.transparent,
            style: Theme.of(context)
                .primaryTextTheme
                .headlineLarge!
                .copyWith(color: CustomColors.primaryColor, fontSize: 16),
          ),
          8.heightBox,
          AppTextInputField(
            controller: HomeProvider.of(context).priorityController,
            fillColor: CustomColors.lighterPrimaryColor,
            borderColor: Colors.transparent,
            enabled: false,
            prefix: const Icon(
              Icons.flag_outlined,
              color: CustomColors.primaryColor,
            ),
            suffix: const Icon(
              Icons.arrow_drop_down,
              color: CustomColors.primaryColor,
            ),
            style: Theme.of(context)
                .primaryTextTheme
                .headlineLarge!
                .copyWith(color: CustomColors.primaryColor, fontSize: 16),
          ),
          16.heightBox,
          QrImageView(
            data: todoDetails.id,
            version: QrVersions.auto,
            size: 400,
          ),
        ],
      ),
    );
  }
}
