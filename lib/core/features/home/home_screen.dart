import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:taskyapp/core/features/home/components/archieved_tasks_widget.dart';
import 'package:taskyapp/core/features/home/components/high_priority_tasks_widget.dart';
import 'package:taskyapp/core/features/home/components/home_controller.dart';
import 'package:taskyapp/core/widgets/custom_svg_picture.dart';
import 'package:taskyapp/core/features/add_task/add_task_screen.dart';
import 'package:taskyapp/core/features/home/components/sliver_task_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller= context.read<HomeController>();
    return ChangeNotifierProvider<HomeController>(

      create: (context) => HomeController()..init(),

      child:  Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),

                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User Information
                          Row(
                            children: [
                              Selector<HomeController, String?>(
                                builder:
                                    (
                                      BuildContext context,
                                      String? userImagePath,
                                      Widget? child,
                                    ) {
                                      return CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: userImagePath == null
                                            ? const AssetImage(
                                                "assets/images/Avatar.png",
                                              )
                                            : FileImage(File(userImagePath)),
                                      );
                                    },
                                selector: (context, controller) =>
                                    controller.userImagePath,
                              ),

                              const SizedBox(width: 8),

                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Selector<HomeController, String?>(
                                      builder:
                                          (
                                            BuildContext context,
                                            String? username,
                                            Widget? child,
                                          ) {
                                            return Text(
                                              "Good Evening, $username",
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                            );
                                          },
                                      selector: (context, controller) =>
                                          controller.username,
                                    ),

                                    Text(
                                      "One task at a time. One step closer.",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Welcome Section
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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
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

                          const SizedBox(height: 16),

                          // Archived Tasks
                          ArchievedTasks(
                            totalTasks: controller.totalTasks,
                            doneTasks: controller.doneTasks,
                            progress: controller.progress,
                          ),

                          const SizedBox(height: 8),

                          // High Priority Tasks
                          HighPriorityTasks(
                            tasks: controller.tasks,

                            onTap: (bool? isDone, int? index) {
                              controller.doneTask(isDone, index);
                            },

                            refresh: () {
                              controller.loadTask();
                            },
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 24, bottom: 16),
                            child: Text(
                              "My Tasks",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Tasks List
                    controller.isLoading
                        ? const SliverToBoxAdapter(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.green,
                              ),
                            ),
                          )
                        : SliverTaskList(
                            tasks: controller.tasks,

                            onTap: (bool? isDone, int? index) {
                              controller.doneTask(isDone, index);
                            },

                            onDelete: (int id) {
                              controller.deleteTask(id);
                            },

                            onEdit: () {
                              controller.loadTask();
                            },
                          ),
                  ],
                ),
              ),
            ),

            // Add New Task Button
            floatingActionButton: SizedBox(
              height: 40,
              child: FloatingActionButton.extended(
                icon: const Icon(Icons.add),
                label: const Text("Add New Task"),

                onPressed: () async {
                  final bool? result = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(builder: (context) => const AddTask()),
                  );

                  if (context.mounted && result == true) {
                    controller.loadTask();
                  }
                },
              ),
            ),
          )
          
    );
  }
}
