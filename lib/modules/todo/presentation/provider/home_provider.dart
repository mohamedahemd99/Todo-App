import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/services/enums.dart';
import 'package:todo_app/helpers/navigator.dart';
import 'package:todo_app/modules/todo/presentation/screens/home/home_view.dart';
import 'package:todo_app/modules/todo/presentation/screens/todo_details/todo_details_view.dart';

import '../../../../helpers/utils.dart';
import '../../../auth/presentation/controller/auth_provider.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecase/add_todo_use_case.dart';
import '../../domain/usecase/delete_todo_use_case.dart';
import '../../domain/usecase/edit_todo_use_case.dart';
import '../../domain/usecase/get_todo_details_use_case.dart';
import '../../domain/usecase/get_todo_list_use_case.dart';
import '../../domain/usecase/upload_image_use_case.dart';

class HomeProvider extends ChangeNotifier {
  static HomeProvider of(BuildContext context, {bool isListen = true}) {
    return Provider.of<HomeProvider>(context, listen: isListen);
  }

  final AddTodoUseCase addTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final EditTodoUseCase editTodoUseCase;
  final GetTodoDetailsUseCase getTodoDetailsUseCase;
  final GetTodoListUseCase getTodoListUseCase;
  final UploadImageUseCase uploadImageUseCase;

  HomeProvider(
      this.addTodoUseCase,
      this.deleteTodoUseCase,
      this.editTodoUseCase,
      this.getTodoDetailsUseCase,
      this.getTodoListUseCase,
      this.uploadImageUseCase);

  Todo? _todoDetails;

  Todo get todoDetails => _todoDetails!;
  List<Todo> _todos = [];

  List<Todo> get todos => _filteredTodos;

  String get selectedStatus => _selectedStatus;
  TextEditingController priorityController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  Priority? selectedPriority;
  StatusTodo? selectedTodoStatus;
  final GlobalKey<FormState> addTodoFormKey = GlobalKey<FormState>();

  List<Todo> _filteredTodos = [];
  String _selectedStatus = "all";
  File? pickedImage;
  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  bool get isLoadingMore => _isLoadingMore;

  bool get hasMore => _hasMore;

  void resetForm() {
    titleController.clear();
    descController.clear();
    dateController.clear();
    selectedPriority = null;
    selectedTodoStatus = null;
    pickedImage = null;
    notifyListeners(); // Ensure the UI is updated
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedImage = File(image.path);
      notifyListeners();
    }
  }

  void setDatePicker(value) {
    dateController.text = value;
    notifyListeners();
  }

  void resetTodoList() {
    _todos.clear();
    notifyListeners();
  }

  void setStatus(String status) {
    _selectedStatus = status;
    filterTodos();
  }

  void setPriority(value) {
    selectedPriority = value;
    notifyListeners();
  }

  void setTodoStatus(value) {
    selectedTodoStatus = value;
    notifyListeners();
  }

  void setControllers(Todo todoModel) {
    selectedPriority = getPriorityString(todoModel.priority);
    selectedTodoStatus = getStatusString(todoModel.status);
    titleController.text = todoModel.title;
    descController.text = todoModel.desc;
    notifyListeners();
  }

  Priority getPriorityString(String priority) {
    switch (priority) {
      case 'low':
        priorityController.text = priority;
        selectedPriority = Priority.low;
        notifyListeners();

        return Priority.low;
      case 'medium':
        priorityController.text = priority;

        selectedPriority = Priority.medium;
        notifyListeners();
        return Priority.medium;
      case 'high':
        priorityController.text = priority;

        selectedPriority = Priority.high;
        notifyListeners();
        return Priority.high;

      default:
        priorityController.text = priority;

        selectedPriority = Priority.low;
        notifyListeners();
        return Priority.low;
    }
  }

  StatusTodo getStatusString(String status) {
    switch (status) {
      case 'inProgress':
        statusController.text = status;
        selectedTodoStatus = StatusTodo.inProgress;
        notifyListeners();

        return StatusTodo.inProgress;
      case 'waiting':
        statusController.text = status;

        selectedTodoStatus = StatusTodo.waiting;
        notifyListeners();
        return StatusTodo.waiting;
      case 'finished':
        statusController.text = status;

        selectedTodoStatus = StatusTodo.finished;
        notifyListeners();
        return StatusTodo.finished;

      default:
        statusController.text = status;

        selectedTodoStatus = StatusTodo.finished;
        notifyListeners();
        return StatusTodo.finished;
    }
  }

  void filterTodos() {
    if (_selectedStatus == "all") {
      _filteredTodos = _todos;
    } else {
      _filteredTodos =
          _todos.where((todo) => todo.status == _selectedStatus).toList();
    }
    notifyListeners();
  }

  void getTodoDetails(String id) async {
    await EasyLoading.show();

    final result = await getTodoDetailsUseCase.call(id);
    result.fold(
      (l) async {
        if (l.errorMessageModel.statusCode == 401) {
          await AuthProvider.of(navigatorKey.currentContext!, isListen: false)
              .refreshToken()
              .then((onValue) {
            getTodoDetails(id);
            EasyLoading.dismiss();
          });
        } else {
          EasyLoading.showError(l.errorMessageModel.message ?? "");
        }
      },
      (r) {
        EasyLoading.dismiss();
        _todoDetails = r;
        if (_todoDetails != null) {
          getPriorityString(_todoDetails!.priority.toLowerCase());
          getStatusString(_todoDetails!.status.toLowerCase());
          pushView(
              navigatorKey.currentContext!,
              TodoDetailsView(
                todoDetails: _todoDetails!,
              ));
        }
      },
    );
  }

  void deleteTodo(String id) async {
    await EasyLoading.show();

    final result = await deleteTodoUseCase.call(id);
    result.fold(
      (l) async {
        if (l.errorMessageModel.statusCode == 401) {
          await AuthProvider.of(navigatorKey.currentContext!, isListen: false)
              .refreshToken()
              .then((onValue) {
            getTodoDetails(id);
            EasyLoading.dismiss();
          });
        } else {
          EasyLoading.showError(l.errorMessageModel.message ?? "");
        }
      },
      (r) {
        _todos.removeWhere(
          (element) => element.id == id,
        );
        popALlAndPushPage(navigatorKey.currentContext!, const HomeView());
        notifyListeners();
        EasyLoading.dismiss();
      },
    );
  }

  Future<void> getTodos({int page = 1}) async {
    if (page == 1) {
      _todos.clear();
      _hasMore = true;
      notifyListeners();
    }

    _isLoadingMore = true;
    notifyListeners();

    final result = await getTodoListUseCase.call(page);
    result.fold(
      (l) async {
        if (l.errorMessageModel.statusCode == 401) {
          await AuthProvider.of(navigatorKey.currentContext!, isListen: false)
              .refreshToken()
              .then((onValue) {
            getTodos();
          });
        } else {
          EasyLoading.showError(l.errorMessageModel.message ?? "");
        }
      },
      (r) {
        _isLoadingMore = false;
        if (r.isEmpty) {
          _hasMore = false;
        } else {
          _currentPage = page;
          _todos.addAll(r);
        }
        filterTodos();
        notifyListeners();
      },
    );
  }

  Future<void> loadMoreTodos() async {
    if (_hasMore && !_isLoadingMore) {
      await getTodos(page: _currentPage + 1);
    }
  }

  void addTodo(
      {required String image,
      required String title,
      required String desc,
      required String priority,
      required String dueDate}) async {
    final result = await addTodoUseCase.call(
      desc: desc,
      image: image,
      priority: priority,
      title: title,
      dueDate: dueDate,
    );
    result.fold(
      (l) async {
        if (l.errorMessageModel.statusCode == 401) {
          await AuthProvider.of(navigatorKey.currentContext!, isListen: false)
              .refreshToken()
              .then((onValue) {
            addTodo(
              desc: desc,
              image: image,
              priority: priority,
              title: title,
              dueDate: dueDate,
            );
          });
        } else {
          EasyLoading.showError(l.errorMessageModel.message!);
        }
      },
      (r) {
        EasyLoading.showSuccess("Task is add successfully");
        resetForm();
        popALlAndPushPage(navigatorKey.currentContext!, const HomeView());
      },
    );
  }

  void editTodo({required Todo todo}) async {
    final result = await editTodoUseCase.call(
      user: todo.user,
      id: todo.id,
      status: selectedTodoStatus!.name,
      desc: descController.text,
      image: todo.image,
      priority: selectedPriority!.name,
      title: titleController.text,
    );
    result.fold(
      (l) async {
        if (l.errorMessageModel.statusCode == 401) {
          await AuthProvider.of(navigatorKey.currentContext!, isListen: false)
              .refreshToken()
              .then((onValue) {
            editTodo(
              todo: todo,
            );
          });
        } else {
          EasyLoading.showError(l.errorMessageModel.message!);
        }
      },
      (r) {
        EasyLoading.showSuccess("Task is Edit successfully");
        resetForm();
        popALlAndPushPage(navigatorKey.currentContext!, const HomeView());
      },
    );
  }

  void uploadImage({bool isEdit = false, Todo? todo}) async {
    EasyLoading.show();
    final result = await uploadImageUseCase.call(pickedImage!);
    result.fold(
      (l) async {
        if (l.errorMessageModel.statusCode == 401) {
          await AuthProvider.of(navigatorKey.currentContext!, isListen: false)
              .refreshToken()
              .then((onValue) {
            uploadImage(isEdit: isEdit, todo: todo!);
          });
        } else {
          EasyLoading.showError(l.errorMessageModel.message!);
        }
      },
      (imagePath) {
        if (isEdit) {
          todo!.image = imagePath;
          editTodo(todo: todo);
        } else {
          addTodo(
              image: imagePath,
              title: titleController.text,
              desc: descController.text,
              priority: selectedPriority!.name,
              dueDate: dateController.text);
        }
      },
    );
  }
}
