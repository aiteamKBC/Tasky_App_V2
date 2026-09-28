import 'package:flutter/material.dart';
import 'package:taskyapp/widgets/task_item_widget.dart';

import '../models/task_model.dart';

class SliverTaskList extends StatelessWidget {
  const SliverTaskList({
    super.key,
    required this.tasks,
    required this.onTap,
    this.emptyMessage,
    required this.onDelete,
  });

  final List<TaskModel> tasks;

  final Function(bool?, int?) onTap;
  final Function(int) onDelete;

  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                emptyMessage ?? "No Data",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.only(bottom: 80),
            sliver: SliverList.separated(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return TaskItemWidget(
                  model: tasks[index],
                  onChanged: (bool? value) {
                    onTap(value, index);
                  },
                  onDeleted: (int id) {
                    onDelete(id);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(height: 8);
              },
            ),
          );
  }
}
