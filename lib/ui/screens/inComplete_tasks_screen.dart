import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/data/dummy_data.dart';
import 'package:todo_app/ui/widgets/task_widget.dart';

class InCompleteTasksScreen extends StatelessWidget {
  Function function;
  Function deleteFun;

  InCompleteTasksScreen(this.function, this.deleteFun);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return allTasks.where((element) => !element.isComplete).length == 0
        ? Center(
            child: Lottie.asset('assets/animations/empty.json'),
          )
        : ListView.builder(
            itemCount: allTasks.where((element) => !element.isComplete).length,
            itemBuilder: (context, index) {
              return TaskWidget(
                  allTasks
                      .where((element) => !element.isComplete)
                      .toList()[index],
                  function,
                  deleteFun);
            });
  }
}
