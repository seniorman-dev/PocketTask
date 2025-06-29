import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pockettask/controller/database/hive_storage.dart';
import 'package:pockettask/model/task_model.dart';
import 'package:pockettask/view/utils/components/extractors.dart';








class TaskController extends GetxController {
  
  //ADD & EDIT SECTION//
  final TextEditingController titleText = TextEditingController();
  final TextEditingController noteText = TextEditingController();
  final TextEditingController titleTextEdit = TextEditingController();
  final TextEditingController noteTextEdit = TextEditingController();
  final status = "pending";  //default: pending, completed

  // BOOLEANS
  final isLoading = false.obs;
  final taskList = <Task>[].obs;
  final filterTaskList = <Task>[].obs;
  //final task = Rxn<Task>(null); "Reactive nullable object"
  
  ///FILTER BY TASK STATUS///
  RxString selectedStatusFilter = "all".obs; //all //pending  //completed
  void onStatusFilter(String filter) {
    selectedStatusFilter.value = filter;
    debugPrint("selected filter: ${selectedStatusFilter.value}");
    update();
  }
  Future<void> filterTaskStatus(String query) async {
    if (query.isEmpty) {
      filterTaskList
      .assignAll(taskList);
      debugPrint("when query is empty: $filterTaskList");
    } 
    else {
      filterTaskList
      ..clear()
      ..addAll(taskList.where((e) => e.status.toLowerCase().contains(query.toLowerCase()))
      .toList());
      debugPrint("when query is not empty: $filterTaskList");
    }
  }



  
  //ADD TASK
  Future<void> addTask({
    required String title,
    required String note,
    required String status, 
    required DateTime createdAt,
  }) async{
    await SecureCache.write(
      generateRandomString(), 
      Task(title: title, note: note, status: status, createdAt: createdAt)
    );
    debugPrint("tasks added");
  }
  

  //UPDATE TASK
  Future<void> updateTask({
    required int index,
    required String title,
    required String note,
    required String status,  //pending //completed
    required DateTime createdAt,
  }) async{
    await SecureCache.update(
      index, 
      Task(title: title, note: note, status: status, createdAt: createdAt)
    );
    debugPrint("task updated at index: $index");
  }

  //GET TASKS
  Future<void> getTask() async{
    try {
      isLoading(true);
      final List<Task> res= SecureCache.getAllItems();
      //sort by created date (from latest to oldest)
      res.sort((a, b) => 
        b.createdAt.toLocal().compareTo(a.createdAt.toLocal())
      );
      debugPrint("sorted tasks from db: ${res.map((e) => e.toJson()).toList()}");
      taskList.assignAll(res);
      filterTaskList.assignAll(res);
    }
    finally {
      isLoading(false);
    }
  }

  //DELETE TASKS
  Future<void> deleteTaskById({
    required String key,
  }) async{
    await SecureCache.remove(
      key, 
    );
    debugPrint("tasks deleted by id");
  }

  Future<void> deleteTaskByIndex({
    required int index,
  }) async{
    await SecureCache.removeAt(
      index, 
    );
    debugPrint("tasks deleted by index");
  }


  @override
  void onInit() {
    // TODO: implement onInit
    getTask();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleText.dispose();
    noteText.dispose();
    titleTextEdit.dispose();
    noteTextEdit.dispose();
    super.dispose();
  }

}