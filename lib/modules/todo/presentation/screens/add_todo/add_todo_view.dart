import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/services/enums.dart';
import 'package:todo_app/helpers/app_image_paths.dart';
import 'package:todo_app/helpers/custom_colors.dart';
import 'package:todo_app/helpers/size_extension.dart';
import 'package:todo_app/modules/todo/domain/entities/todo.dart';
import 'package:todo_app/modules/todo/presentation/provider/home_provider.dart';
import 'package:todo_app/widgets/app_size_boxes.dart';
import 'package:todo_app/widgets/form_fields/app_input_text_field.dart';

import '../../../../../core/network/api_path.dart';
import '../../../../../widgets/app_dropdown.dart';
import '../../../../../widgets/app_main_button.dart';
import '../../../../../widgets/scaffold_widget.dart';

class AddTodoView extends StatefulWidget {
  const AddTodoView({super.key, this.todoDetails});

  final Todo? todoDetails;

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  late HomeProvider homeProvider;

  @override
  void initState() {
    super.initState();
    homeProvider = HomeProvider.of(context, isListen: false);

    if (widget.todoDetails != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        homeProvider.setControllers(widget.todoDetails!);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeProvider.resetForm();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: "Add new task",
      body: Form(
        key: HomeProvider.of(context).addTodoFormKey,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            GestureDetector(
              onTap: homeProvider.pickImage,
              child: DottedBorder(
                padding: EdgeInsets.symmetric(
                    vertical: HomeProvider.of(context).pickedImage == null
                        ? 16.h
                        : 0),
                color: CustomColors.primaryColor,
                borderType: BorderType.RRect,
                radius: Radius.circular(12.r),
                child: HomeProvider.of(context).pickedImage == null
                    ? widget.todoDetails != null
                        ? Image.network(
                            AppApiPaths.setImageUrl(widget.todoDetails!.image),
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                AppImages.testImage,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.image,
                                width: 24.w,
                                height: 24.h,
                              ),
                              8.widthBox,
                              Text(
                                "Add Img",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        fontSize: 19,
                                        color: CustomColors.primaryColor),
                              )
                            ],
                          )
                    : Image.file(
                        HomeProvider.of(context).pickedImage!,
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            16.heightBox,
            AppTextInputField(
              controller: HomeProvider.of(context).titleController,
              labelText: "Task title",
              hintText: "Enter title here...",
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return "The title is Required.";
                }
              },
            ),
            16.heightBox,
            AppTextInputField(
              controller: HomeProvider.of(context).descController,
              labelText: "Task Description",
              hintText: "Enter description here...",
              maxLines: 10,
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return "The title is Required.";
                }
              },
            ),
            16.heightBox,
            Text(
              "Priority",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: CustomColors.subTitleColor, fontSize: 12, height: 5),
            ),
            CustomDropdownField<Priority>(
              isPriority: true,
              items: Priority.values,
              selectedValue: HomeProvider.of(context).selectedPriority,
              displayItem: (priority) => priority.name,
              hint: "Choose Priority",
              validator: (value) =>
                  value == null ? "The Priority is required." : null,
              onChanged: (newValue) {
                homeProvider.setPriority(newValue);
              },
            ),
            16.heightBox,
            if (widget.todoDetails != null)
              Text(
                "Priority",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: CustomColors.subTitleColor, fontSize: 12, height: 5),
              ),
            if (widget.todoDetails != null)
              CustomDropdownField<StatusTodo>(
                isPriority: false,
                items: StatusTodo.values,
                selectedValue: HomeProvider.of(context).selectedTodoStatus,
                displayItem: (priority) => priority.name,
                hint: "Choose Priority",
                validator: (value) =>
                    value == null ? "The Status is required." : null,
                onChanged: (newValue) {
                  homeProvider.setTodoStatus(newValue);
                },
              ),
            if (widget.todoDetails == null)
              AppTextInputField(
                enabled: false,
                controller: HomeProvider.of(context).dateController,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );

                  if (picked != null) {
                    final DateFormat formatter = DateFormat('yyyy-MM-dd');
                    String formattedDate = formatter.format(picked);

                    homeProvider.setDatePicker(formattedDate);
                  }
                },
                labelText: "Due date",
                hintText: "choose due date...",
                suffix: const Icon(
                  Icons.calendar_month_outlined,
                  color: CustomColors.primaryColor,
                ),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return "The date is Required.";
                  }
                },
              ),
            16.heightBox,
            AppMainButton(
              onTap: () {
                if (homeProvider.addTodoFormKey.currentState!.validate()) {
                  if (widget.todoDetails != null) {
                    if (homeProvider.pickedImage != null) {
                      homeProvider.uploadImage(
                          isEdit: true, todo: widget.todoDetails);
                    } else {
                      homeProvider.editTodo(todo: widget.todoDetails!);
                    }
                  } else {
                    if (homeProvider.pickedImage != null) {
                      homeProvider.uploadImage();
                    } else {
                      EasyLoading.showError("you have to upload an image");
                    }
                  }
                }
              },
              translation:
                  widget.todoDetails != null ? "Edit task" : "Add task",
            ),
            16.heightBox,
          ],
        ),
      ),
    );
  }
}
