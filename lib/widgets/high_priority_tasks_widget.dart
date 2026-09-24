import 'package:flutter/material.dart';
import 'package:taskyapp/core/theme/theme_controler.dart';
import 'package:taskyapp/core/widgets/custom_check_box.dart';
import 'package:taskyapp/core/widgets/custom_svg_picture.dart';
import 'package:taskyapp/models/task_model.dart';
import 'package:taskyapp/screens/high_priority_screen.dart';

class HighPriorityTasks extends StatelessWidget {
  const HighPriorityTasks({
    super.key,
    required this.onTap,
    required this.tasks,
    required this.refresh,
  });
  final Function(bool?, int?) onTap;
  final List<TaskModel> tasks;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    final priorityTasks = tasks.reversed
        .where((task) => task.isHighPriority)
        .take(4)
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'High Priority Tasks',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff15B86C),
                    ),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: priorityTasks.length,
                  itemBuilder: (context, index) {
                    final task = priorityTasks[index];
                    return Row(
                      children: [
                        CustomCheckBox(
                          value: task.isDone,
                          onChanged: (bool? value) {
                            final originalIndex = tasks.indexWhere(
                              (e) => e.id == task.id,
                            );
                            onTap(value, originalIndex);
                          },
                        ),
                        Expanded(
                          child: Text(
                            task.taskName,
                            style: task.isDone
                                ? Theme.of(context).textTheme.labelLarge
                                : Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HighPriorityScreen()),
              );
              refresh();
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: 56,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ThemeControler.isDark()
                        ? const Color(0xff6E6E6E)
                        : const Color(0XFFD1DAD6),
                  ),
                ),
                child: CustomSvgPicture(
                  path: 'assets/images/Icon_arrow.svg',
                  hight: 15,
                  width: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
