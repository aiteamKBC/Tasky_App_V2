import 'package:flutter/material.dart';
import 'package:taskyapp/widgets/task_item_widget.dart';

import '../models/task_model.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    this.emptyMessage,
  });

  final List<TaskModel> tasks;

  final Function(bool?, int?) onTap;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyMessage ?? "No Data",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          )
        : ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) {
              return Container(height: 8);
            },
            padding: EdgeInsets.only(bottom: 40),
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return TaskItemWidget(
                model: tasks[index],
                onChanged: (bool? value) {
                  onTap(value, index);
                },
              );
            },
          );
  }
}
