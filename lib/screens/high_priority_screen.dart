import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskyapp/core/services/preferences_manger.dart';
import 'package:taskyapp/models/task_model.dart';
import 'package:taskyapp/widgets/task_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  bool isLoading = false;
  List<TaskModel> highPriorityTasks = [];

  @override
  void initState() {
    _loadTask();

    super.initState();
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });
    final finalTask = PreferencesManger().getString("tasks");

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        highPriorityTasks = taskAfterDecode
            .map((e) => TaskModel.fromJson(e))
            .where((e) => e.isHighPriority == true)
            .toList();
        highPriorityTasks = highPriorityTasks.reversed.toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('High Priority')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  value: 20,
                  color: Colors.white,
                ),
              )
            : TaskListWidget(
                tasks: highPriorityTasks,
                onTap: (bool? value, int? index) async {
                  setState(() {
                    highPriorityTasks[index!].isDone = value ?? false;
                  });
                  final allData = PreferencesManger().getString("tasks");

                  if (allData != null) {
                    List<TaskModel> allDataList = (jsonDecode(allData) as List)
                        .map((element) => TaskModel.fromJson(element))
                        .toList();
                    final newIndex = allDataList.indexWhere(
                      (e) => e.id == highPriorityTasks[index!].id,
                    );
                    allDataList[newIndex] = highPriorityTasks[index!];
                    PreferencesManger().setString(
                      "tasks",
                      jsonEncode(allDataList),
                    );

                    _loadTask();
                  }
                },
                emptyMessage: 'No Tasks Founded',
              ),
      ),
    );
  }
}
