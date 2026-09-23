import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskyapp/core/theme/theme_controler.dart';
import 'package:taskyapp/core/widgets/custom_check_box.dart';
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "High Priority Tasks",

                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff15B86C),
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: tasks.where((e) => e.isHighPriority).length > 4
                      ? 4
                      : tasks.where((e) => e.isHighPriority).length,
                  itemBuilder: (BuildContext context, int index) {
                    final task = tasks.reversed
                        .where((e) => e.isHighPriority)
                        .toList()[index];
                    return Row(
                      children: [
                        CustomCheckBox(
                          value: task.isDone,
                          onChanged: (bool? value) {
                            final index = tasks.indexWhere(
                              (e) => e.id == task.id,
                            );
                            onTap(value, index);
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
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HighPriorityScreen();
                  },
                ),
              );
              refresh();
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: 56,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ThemeControler.isDark()
                        ? Color(0xff6E6E6E)
                        : Color(0XFFD1DAD6),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/images/Icon_arrow.svg",
                  height: 10,
                  width: 10,
                  colorFilter: ColorFilter.mode(
                    ThemeControler.isDark()
                        ? Color(0xffC6C6C6)
                        : Color(0xff3A4640),

                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
