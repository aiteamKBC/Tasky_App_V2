import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskyapp/core/services/preferences_manger.dart';

import '../models/task_model.dart';
import '../widgets/task_list_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool isLoading = false;
  List<TaskModel> todoTasks = [];

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
        todoTasks = taskAfterDecode
            .map((e) => TaskModel.fromJson(e))
            .where((e) => e.isDone == false)
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Text(
              "To Do Tasks",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontSize: 20),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      value: 20,
                      color: Colors.white,
                    ),
                  )
                : TaskListWidget(
                    tasks: todoTasks,
                    onTap: (bool? value, int? index) async {
                      setState(() {
                        todoTasks[index!].isDone = value ?? false;
                      });
                      final allData = PreferencesManger().getString("tasks");

                      if (allData != null) {
                        List<TaskModel> allDataList =
                            (jsonDecode(allData) as List)
                                .map((element) => TaskModel.fromJson(element))
                                .toList();
                        final newIndex = allDataList.indexWhere(
                          (e) => e.id == todoTasks[index!].id,
                        );
                        allDataList[newIndex] = todoTasks[index!];
                        await PreferencesManger().setString(
                          "tasks",
                          jsonEncode(allDataList),
                        );
                        _loadTask();
                      }
                    },
                    emptyMessage: 'No Tasks Founded',
                  ),
          ),
        ),
      ],
    );
  }
}
