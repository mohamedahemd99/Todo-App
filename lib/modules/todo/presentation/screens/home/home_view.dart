import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/helpers/app_image_paths.dart';
import 'package:todo_app/helpers/custom_colors.dart';
import 'package:todo_app/helpers/navigator.dart';
import 'package:todo_app/helpers/size_extension.dart';
import 'package:todo_app/modules/auth/presentation/controller/auth_provider.dart';
import 'package:todo_app/modules/todo/presentation/component/qrcode_scanner.dart';
import 'package:todo_app/modules/todo/presentation/component/todo_card.dart';
import 'package:todo_app/modules/todo/presentation/provider/home_provider.dart';
import 'package:todo_app/modules/todo/presentation/screens/add_todo/add_todo_view.dart';
import 'package:todo_app/widgets/app_size_boxes.dart';
import 'package:todo_app/widgets/scaffold_widget.dart';

import '../../../domain/entities/todo.dart';
import '../../component/selection_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController = ScrollController();
      _scrollController.addListener(_onScroll);
      HomeProvider.of(context, isListen: false).getTodos();
    });

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _scrollController.removeListener(_onScroll);
        _scrollController.dispose();
      },
    );

    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      HomeProvider.of(context, isListen: false).loadMoreTodos();
    }
  }

  Future<void> _onRefresh() async {
    // Refresh the todos by calling getTodos
    HomeProvider.of(context, isListen: false).getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      isRootScreen: true,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: InkWell(
          onTap: () => pushView(context, AddTodoView()),
          child: CircleAvatar(
            radius: 32.r,
            backgroundColor: CustomColors.primaryColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
      title: "Todo",
      actions: [
        IconButton(
            onPressed: () {
              AuthProvider.of(context, isListen: false).profileUser();
            },
            icon: Image.asset(AppImages.profile)),
        IconButton(
          onPressed: () {
            AuthProvider.of(context, isListen: false).logoutUser().then(
                  (value) =>
                      HomeProvider.of(context, isListen: false).resetTodoList(),
                );
          },
          icon: Image.asset(AppImages.logout),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.heightBox,
            Text(
              'My Tasks',
              style: Theme.of(context).primaryTextTheme.headlineLarge!.copyWith(
                  fontSize: 16,
                  color: CustomColors.titleColor.withOpacity(0.6)),
            ),
            16.heightBox,
            const SelectionRow(),
            16.heightBox,
            Expanded(
              child: Consumer<HomeProvider>(
                builder: (context, provider, child) {
                  return (provider.todos.isNotEmpty && !provider.isLoadingMore)
                      ? ListView.separated(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (index < provider.todos.length) {
                              Todo todo = provider.todos[index];
                              return TodoCard(todo: todo);
                            } else if (provider.isLoadingMore) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                          separatorBuilder: (context, index) => 12.heightBox,
                          itemCount: provider.todos.length +
                              (provider.hasMore
                                  ? 1
                                  : 0), // Add extra space for the loader
                        )
                      : SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Center(
                            child: Text(
                              HomeProvider.of(context).selectedStatus == 'all'
                                  ? "There are no tasks"
                                  : "There are no ${HomeProvider.of(context).selectedStatus} tasks",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        );
                },
              ),
            ),
            if (Platform.isAndroid || Platform.isIOS)
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: InkWell(
                  onTap: () => pushView(context, QrCodeScanner()),
                  child: Image.asset(AppImages.qrcode),
                ),
              ),
            50.heightBox,
          ],
        ),
      ),
    );
  }
}
