import 'package:flutter/material.dart';
import 'package:taskyapp/core/theme/theme_controler.dart';
import 'package:taskyapp/core/widgets/custom_check_box.dart';
import 'package:taskyapp/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
  });
  final TaskModel model;
  final Function(bool?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Container(
        height: 60,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ThemeControler.isDark()
                ? Colors.transparent
                : Color(0xffD1DAD6),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            CustomCheckBox(
              value: model.isDone,
              onChanged: (bool? value) => onChanged(value),
            ),

            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.taskName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: model.isDone
                        ? Theme.of(context).textTheme.labelLarge
                        : Theme.of(context).textTheme.titleMedium,
                  ),
                  if (model.taskDescription.trim().isNotEmpty)
                    Text(
                      model.taskDescription,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall!,
                    ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
              color: ThemeControler.isDark()
                  ? (model.isDone ? Color(0xffA0A0A0) : Color(0XFFC6C6C6))
                  : (model.isDone ? Color(0xff6A6A6A) : Color(0XFF3A4640)),
            ),
          ],
        ),
      ),
    );
  }
}
