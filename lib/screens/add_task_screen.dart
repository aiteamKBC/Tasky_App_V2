import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskyapp/core/services/preferences_manger.dart';
import 'package:taskyapp/core/widgets/custom_text_form_field.dart';
import 'package:taskyapp/models/task_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFFFFCFC),
                      ),
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
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      final taskjson = PreferencesManger().getString("tasks");

                      List<dynamic> listTasks = [];
                      if (taskjson != null) {
                        listTasks = jsonDecode(taskjson) as List<dynamic>;
                      }
                      TaskModel model = TaskModel(
                        id: listTasks.length + 1,
                        taskName: taskNameController.text,
                        taskDescription: taskDescriptionController.text,
                        isHighPriority: isHighPriority,
                      );

                      listTasks.add(model.toJson());

                      // print(taskjson);
                      final taskAfterEncode = jsonEncode(listTasks);
                      await PreferencesManger().setString(
                        "tasks",
                        taskAfterEncode,
                      );

                      Navigator.of(context).pop(true);
                    }
                  },

                  label: Text(
                    "Add Task",
                    style: TextStyle(decoration: TextDecoration.none),
                  ),
                  icon: Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
