import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskyapp/core/services/preferences_manger.dart';
import 'package:taskyapp/core/widgets/custom_svg_picture.dart';
import 'package:taskyapp/models/task_model.dart';
import 'package:taskyapp/screens/add_task_screen.dart';
import 'package:taskyapp/widgets/archieved_tasks_widget.dart';
import 'package:taskyapp/widgets/high_priority_tasks_widget.dart';
import 'package:taskyapp/widgets/task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTasks = 0;
  int doneTasks = 0;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _loaduserName();
    _loadTask();
  }

  void _loaduserName() async {
    setState(() {
      username = PreferencesManger().getString("username");
    });
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });
    final finalTask = PreferencesManger().getString("tasks");

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        tasks = taskAfterDecode.map((e) {
          return TaskModel.fromJson(e);
        }).toList();
        _calculateProgress();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void _calculateProgress() {
    totalTasks = tasks.length;
    doneTasks = tasks.where((element) => element.isDone == true).length;
    progress = totalTasks > 0 ? doneTasks / totalTasks : 0.0;
  }

  void _doneTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      _calculateProgress();
    });

    final updatedTask = tasks.map((e) => e.toJson()).toList();

    await PreferencesManger().setString("tasks", jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.transparent,

                          backgroundImage: AssetImage(
                            "assets/images/Avatar.png",
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good Evening, $username",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                "One task at a time. One step closer.",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Yuhuu, Your work Is ",

                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Row(
                          children: [
                            Text(
                              "almost done! ",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(width: 8),
                            CustomSvgPicture.withoutColor(
                              path: "assets/images/wavinghand.svg",
                              width: 32,
                              hight: 32,
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    //Archieved Tasks
                    ArchievedTasks(
                      totalTasks: totalTasks,
                      doneTasks: doneTasks,
                      progress: progress,
                    ),
                    SizedBox(height: 8),
                    HighPriorityTasks(
                      tasks: tasks,
                      onTap: (bool? value, int? index) {
                        _doneTask(value, index);
                      },
                      refresh: () {
                        _loadTask();
                      },
                    ),
                    // SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.only(top: 24, bottom: 16),
                      child: Text(
                        "My Tasks",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),

                    //SizedBox(height: 50,),
                  ],
                ),
              ),
              isLoading
                  ? const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: TaskListWidget(
                        tasks: tasks,
                        onTap: (bool? value, int? index) {
                          _doneTask(value, index);
                        },
                      ),
                    ),
            ],
          ),
        ),

        floatingActionButton: SizedBox(
          height: 40,
          child: FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            label: const Text("Add New Task"),

            onPressed: () async {
              // الانتظار حتى يعود المستخدم من صفحة الإضافة لتحديث القائمة
              final bool? result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const AddTask(),
                ),
              );
              if (result != null && result == true) {
                _loadTask();
              }
            },
          ),
        ),
      ),
    );
  }
}
