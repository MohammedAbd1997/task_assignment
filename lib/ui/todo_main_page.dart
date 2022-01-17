import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/data/dummy_data.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/ui/screens/all_tasks_screen.dart';
import 'package:todo_app/ui/screens/complete_tasks_screen.dart';
import 'package:todo_app/ui/screens/inComplete_tasks_screen.dart';

class TodoMainPage extends StatefulWidget {
  @override
  State<TodoMainPage> createState() => _TodoMainPageState();
}

class _TodoMainPageState extends State<TodoMainPage>
    with SingleTickerProviderStateMixin {
  updateAllScreens(Task task) {
    task.isComplete = !task.isComplete;
    setState(() {});
  }

  deleteTask(Task task) {
    allTasks.remove(task);
    setState(() {});
  }

  changeCheckBox(bool value) {
    setState(() {
      value = !value;
    });
  }

  TabController tabController;

  initTabController() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      String message = tabController.index == 0
          ? 'you are in the all tasks tab'
          : tabController.index == 1
              ? 'you are in the completed tasks tab'
              : 'ypu are in the incomplete tasks tab';
      log(message);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTabController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.done),
              onPressed: () {
                tabController.animateTo(1);
              },
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text('O'),
                      ),
                      accountName: Text('Omar'),
                      accountEmail: Text('omar@gmail.com')),
                  ListTile(
                    onTap: () {
                      tabController.animateTo(0);
                    },
                    title: Text('All Tasks'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () {
                      tabController.animateTo(1);
                    },
                    title: Text('Complete Tasks'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () {
                      tabController.animateTo(2);
                    },
                    title: Text('InComplete Tasks'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              actions: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return addScreen(changeCheckBox);
                        }));
                      },
                    ))
              ],
              title: Text('TODO APP'),
              bottom: TabBar(
                controller: tabController,
                tabs: [
                  Tab(
                    icon: Icon(Icons.list),
                  ),
                  Tab(
                    icon: Icon(Icons.done),
                  ),
                  Tab(
                    icon: Icon(Icons.cancel_outlined),
                  ),
                ],
              ),
            ),
            // bottomNavigationBar: BottomNavigationBar(
            //   currentIndex: index,
            //   onTap: (newindex) {
            //     setState(() {
            //       this.index = newindex;
            //     });
            //   },
            //   items: [
            //     BottomNavigationBarItem(label: 'All', icon: Icon(Icons.list)),
            //     BottomNavigationBarItem(label: 'Complete', icon: Icon(Icons.done)),
            //     BottomNavigationBarItem(
            //         label: 'InComplete', icon: Icon(Icons.cancel)),
            //   ],
            // ),
            body: TabBarView(controller: tabController, children: [
              AllTasksScreen(updateAllScreens, deleteTask),
              CompleteTasksScreen(updateAllScreens, deleteTask),
              InCompleteTasksScreen(updateAllScreens, deleteTask),
            ]))
        : Scaffold(
            appBar: AppBar(
              title: Text('TODO APP'),
            ),
            body: Row(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      UserAccountsDrawerHeader(
                          currentAccountPicture: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text('O'),
                          ),
                          accountName: Text('Omar'),
                          accountEmail: Text('omar@gmail.com')),
                      ListTile(
                        onTap: () {
                          tabController.animateTo(0);
                        },
                        title: Text('All Tasks'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {
                          tabController.animateTo(1);
                        },
                        title: Text('Complete Tasks'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {
                          tabController.animateTo(2);
                        },
                        title: Text('InComplete Tasks'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(controller: tabController, children: [
                  AllTasksScreen(updateAllScreens, deleteTask),
                  CompleteTasksScreen(updateAllScreens, deleteTask),
                  InCompleteTasksScreen(updateAllScreens, deleteTask),
                ]))
              ],
            ),
          );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text('SHADY'),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return AppBar().preferredSize;
  }
}

class addScreen extends StatefulWidget {
  Function function;

  addScreen(this.function);

  @override
  _addScreenState createState() => _addScreenState();
}

class _addScreenState extends State<addScreen> {
  bool iscomplete = false;

  TextEditingController Task_Title = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    void toast() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please Add A Title of Task !!"),
      ));
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Screen'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            TextField(
                controller: Task_Title,
                decoration: InputDecoration(
                  labelText: 'Add New Title Task',
                )),
            SizedBox(
              height: 30,
            ),
            CheckboxListTile(
              value: (iscomplete),
              onChanged: (value) {
                iscomplete = !iscomplete;
                setState(() {});
              },
              title: Text('Complete'),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  if (!Task_Title.text.toString().isEmpty) {
                    allTasks.add(new Task(
                        title: Task_Title.text, isComplete: iscomplete));
                    Navigator.of(context).pop();
                  } else {
                    toast();
                  }
                },
                child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
