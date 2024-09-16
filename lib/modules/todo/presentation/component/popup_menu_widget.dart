import 'package:flutter/material.dart';
import 'package:todo_app/helpers/custom_colors.dart';
import 'package:todo_app/modules/todo/presentation/provider/home_provider.dart';

import '../../../../core/services/enums.dart';
import '../../../../helpers/navigator.dart';
import '../../domain/entities/todo.dart';
import '../screens/add_todo/add_todo_view.dart';

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({super.key, required this.todoDetails});

  final Todo? todoDetails;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOption>(
        onSelected: (MenuOption selectedOption) {
          if (selectedOption == MenuOption.edit) {
            pushView(
                context,
                AddTodoView(
                  todoDetails: todoDetails,
                ));
          } else if (selectedOption == MenuOption.delete) {
            HomeProvider.of(context, isListen: false)
                .deleteTodo(todoDetails!.id);
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOption>>[
              PopupMenuItem<MenuOption>(
                value: MenuOption.edit,
                child: ListTile(
                  title: Text('Edit',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 16,
                              )),
                ),
              ),
              PopupMenuItem<MenuOption>(
                value: MenuOption.delete,
                child: ListTile(
                  title: Text('Delete',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontSize: 16,
                              color: CustomColors.waitingHighColor)),
                ),
              ),
            ],
        icon: const Icon(
          Icons.more_vert_outlined,
          color: Colors.black,
        ));
  }
}

// Enum to define menu options
