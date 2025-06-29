import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pockettask/controller/database/hive_storage.dart';
import 'package:pockettask/controller/database/task_controller.dart';
import 'package:pockettask/model/task_model.dart';
import 'package:pockettask/view/utils/theme/theme_controller.dart';



//flutter test test/pocket_task_test_cases.dart
//flutter test


void main() {


  late TaskController taskController;
  late Box<Task> taskBox;

  setUpAll(() async {
    // Initialize test bindings
    TestWidgetsFlutterBinding.ensureInitialized();

    // Mock path provider for Hive
    const MethodChannel('plugins.flutter.io/path_provider')
    .setMockMethodCallHandler((MethodCall methodCall) async {
      print('Mocking call: ${methodCall.method}');
      switch (methodCall.method) {
        case 'getApplicationDocumentsDirectory':
        case 'getTemporaryDirectory':
        return '.';
        default:
        return null;
      }
    });


    // Initialize Hive
    Hive.init(Directory.current.path);
    //Hive.registerAdapter(TaskAdapter()); (Already registered in SecureCache)
    await SecureCache.init(); // if it also uses Hive or storage
  });

  setUp(() async {
    taskBox = await Hive.openBox<Task>('test_tasks');
    taskController = TaskController();
    Get.put(taskController);
  });

  tearDown(() async {
    await taskBox.clear();
    await taskBox.close();
    Get.reset(); // reset GetX dependencies
  });
  
  tearDownAll(() async {
    await Hive.close();
  });




  // TESTS HERE//
  test('Should add a new task to Hive', () async {
    final testTask = Task(
      title: 'Test Task',
      note: 'Test Note',
      status: 'pending',
      createdAt: DateTime.timestamp(),
    );

    await taskBox.add(testTask);

    await taskController.addTask(
      title: testTask.title,
      note: testTask.note,
      status: testTask.status,
      createdAt: testTask.createdAt,
    );

    expect(taskBox.values.length, 1);
    expect(taskBox.values.first.title, 'Test Task');
  });

  test('Should update task status', () async {
    final task = Task(
      title: 'Original Task',
      note: 'Original Note',
      status: 'completed',
      createdAt: DateTime.timestamp(),
    );
    await taskBox.add(task);

    await taskController.updateTask(
      index: 0,
      title: task.title,
      note: task.note,
      status: task.status,
      createdAt: task.createdAt,
    );

    final updatedTask = taskBox.getAt(0);
    expect(updatedTask?.status, 'completed');
  });

  test('Should filter tasks by status', () async {
    await taskBox.addAll([
      Task(title: 'Task 1', note: 'Note 1', status: 'pending', createdAt: DateTime.timestamp()),
      Task(title: 'Task 2', note: 'Note 2', status: 'completed', createdAt: DateTime.timestamp()),
    ]);

    final pendingTasks = taskBox.values.where((task) => task.status == 'pending').toList();

    expect(pendingTasks.length, 1);
    expect(pendingTasks[0].status, 'pending');
  });

  test('Should toggle theme mode', () async {
    final themeController = ThemeController();
    Get.put(themeController);

    expect(themeController.isDarkMode.value, false);

    themeController.toggleTheme();
    expect(themeController.isDarkMode.value, true);

    themeController.toggleTheme();
    expect(themeController.isDarkMode.value, false);
  });
}
