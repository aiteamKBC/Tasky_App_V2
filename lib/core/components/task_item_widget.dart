import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskyapp/core/enums/task_item_actions_enum.dart';
import 'package:taskyapp/core/services/preferences_manger.dart';
import 'package:taskyapp/core/theme/theme_controler.dart';
import 'package:taskyapp/core/widgets/custom_check_box.dart';
import 'package:taskyapp/core/widgets/custom_text_form_field.dart';
import 'package:taskyapp/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDeleted,
    required this.onEdit,
  });
  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int) onDeleted;
  final Function() onEdit;
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

            PopupMenuButton<TaskItemActionsEnum>(
              icon: Icon(
                Icons.more_vert,
                color: ThemeControler.isDark()
                    ? (model.isDone ? Color(0xffA0A0A0) : Color(0XFFC6C6C6))
                    : (model.isDone ? Color(0xff6A6A6A) : Color(0XFF3A4640)),
              ),

              onSelected: (value) async {
                switch (value) {
                  case TaskItemActionsEnum.markAsDone:
                    onChanged(!model.isDone);

                  case TaskItemActionsEnum.edit:
                    final result = await _showBottomSheet(context, model);
                    if (result == true) {
                      onEdit();
                    }

                  case TaskItemActionsEnum.delete:
                    _showAlertDialog(context);

                  // onDeleted(model.id);
                }
              },

              itemBuilder: (context) => TaskItemActionsEnum.values.map((e) {
                return PopupMenuItem<TaskItemActionsEnum>(
                  value: e,
                  child: Text(e.name),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  /////////////////////////////////////1
  _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: Text("are you sure you want to delete task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(decoration: TextDecoration.none),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                onDeleted(model.id);

                Navigator.pop(context);
              },
              child: Text(
                "Delete",
                style: TextStyle(decoration: TextDecoration.none),
              ),
            ),
          ],
        );
      },
    );
  }

  ////////////////////////////////////////////////////2
  Future<bool?> _showBottomSheet(BuildContext context, TaskModel model) {
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    TextEditingController taskNameController = TextEditingController(
      text: model.taskName,
    );
    TextEditingController taskDescriptionController = TextEditingController(
      text: model.taskDescription,
    );
    bool isHighPriority = model.isHighPriority;
    return showModalBottomSheet<bool>(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),

                    CustomTextFormField(
                      controller: taskNameController,
                      title: "Task Name",
                      maxLine: 1,
                      hintText: 'Finish UI design for login screen',
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please Enter Task Name";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    CustomTextFormField(
                      controller: taskDescriptionController,
                      title: "Task Description",
                      maxLine: 5,
                      hintText:
                          'Finish onboarding UI and hand off to devs by Thursday.',
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "High Priority",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Switch(
                          value: isHighPriority,
                          onChanged: (bool value) {
                            setState(() {
                              isHighPriority = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 40,

                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () async {
                          if (key.currentState?.validate() ?? false) {
                            final taskjson = PreferencesManger().getString(
                              "tasks",
                            );

                            List<dynamic> listTasks = [];
                            if (taskjson != null) {
                              listTasks = jsonDecode(taskjson) as List<dynamic>;
                            }

                            TaskModel newmodel = TaskModel(
                              id: model.id,
                              isDone: model.isDone,
                              taskName: taskNameController.text,
                              taskDescription: taskDescriptionController.text,
                              isHighPriority: isHighPriority,
                            );
                            final item = listTasks.firstWhere((e) {
                              return e["id"] == model.id;
                            });
                            final int index = listTasks.indexOf(item);
                            listTasks[index] = newmodel;
                            final taskAfterEncode = jsonEncode(listTasks);
                            await PreferencesManger().setString(
                              "tasks",
                              taskAfterEncode,
                            );

                            Navigator.of(context).pop(true);
                          }
                        },

                        label: Text(
                          "Edit Task",
                          style: TextStyle(decoration: TextDecoration.none),
                        ),
                        icon: Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
