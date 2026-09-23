import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskyapp/core/services/preferences_manger.dart';

import '../models/task_model.dart';
import '../widgets/task_list_widget.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool isLoading = false;
  List<TaskModel> tasks = [];

  @override
  void initState() {
    _loadTask();

    // TODO: implement initState
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
        tasks = taskAfterDecode
            .map((e) => TaskModel.fromJson(e))
            .where((e) => e.isDone)
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
          child: Text(
            "Completed Tasks",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color(0XFFFFFCFC),
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
                    tasks: tasks,
                    onTap: (bool? value, int? index) async {
                      setState(() {
                        tasks[index!].isDone = value ?? false;
                      });


                      final updatedTask = tasks.map((e) => e.toJson()).toList();

                      await PreferencesManger().setString("tasks", jsonEncode(updatedTask));
                      _loadTask();
                    },
                    emptyMessage: 'No Tasks Completed',
                  ),
          ),
        ),
      ],
    );
  }
}
