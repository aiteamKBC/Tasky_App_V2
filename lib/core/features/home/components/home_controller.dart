import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskyapp/core/constants/storage_key.dart';
import 'package:taskyapp/core/services/preferences_manger.dart';
import 'package:taskyapp/models/task_model.dart';

class HomeController with ChangeNotifier {
  String? username;
  String? userImagePath;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTasks = 0;
  int doneTasks = 0;
  double progress = 0.0;
  List<TaskModel> tasksList = [];


  void init() {
    loaduserData();
    loadTask();
    notifyListeners();
  }

  void loaduserData() async {
    username = PreferencesManger().getString(StorageKey.username);
    userImagePath = PreferencesManger().getString(StorageKey.userImagePath);
    notifyListeners();
  }

  void loadTask() async {
    isLoading = true;

    final finalTask = PreferencesManger().getString(StorageKey.tasks);

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskAfterDecode.map((e) {
        return TaskModel.fromJson(e);
      }).toList();
      calculateProgress();
    }

    isLoading = false;
    notifyListeners();
  }

  void calculateProgress() {
    totalTasks = tasks.length;
    doneTasks = tasks.where((element) => element.isDone == true).length;
    progress = totalTasks > 0 ? doneTasks / totalTasks : 0.0;
    notifyListeners();
  }

  void doneTask(bool? value, int? index) async {
    tasks[index!].isDone = value ?? false;
    calculateProgress();

    final updatedTask = tasks.map((e) => e.toJson()).toList();

    await PreferencesManger().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );
    notifyListeners();
  }

  // TODO :Make Shared Method

  void deleteTask(int id) async {
    tasks.removeWhere((task) => task.id == id);
    calculateProgress();
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PreferencesManger().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );
    notifyListeners();
  }
}
