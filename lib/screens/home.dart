import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_tasks/blocs/task_bloc.dart';
import 'package:my_tasks/provider/provider.dart';
import 'package:my_tasks/screens/add_edit_tasks.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int lastId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyTasks'),
      ),
      body: SafeArea(
        child: BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is TaskAdded) {
              Provider.of<TaskProvider>(context, listen: false).add(state.task);
            }
            if (state is TaskDeleted) {
              Provider.of<TaskProvider>(context, listen: false)
                  .remove(state.task);
            }
            if (state is TaskUpdated) {
              Provider.of<TaskProvider>(context, listen: false)
                  .update(state.task);
            }
          },
          child: Consumer<TaskProvider>(
            builder: (context, value, child) {
              if (value.tasks.isNotEmpty) {
                lastId = value.tasks.last.id;
              }
              return Container(
                margin: const EdgeInsets.all(16),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: value.tasks.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                  title: const Text('Delete Task'),
                                  content: const Text(
                                      'Are you sure you want to delete this task?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<TaskBloc>()
                                            .add(RemoveTaskEvent(value.tasks[index]));
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                );
                              });
                            },
                            label: 'Delete',
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => AddTask(
                          lastId: lastId,
                          task: value.tasks[index],
                        ), transitionDuration: const Duration(milliseconds: 500), transitionsBuilder: (_, animation, __, child) {
                          return FadeTransition(opacity: animation, child: child);
                        })),
                        child: Card(
                          child: ListTile(
                            title: Text(value.tasks[index].title),
                            subtitle: Text(
                                "${value.tasks[index].description}\n${"Priority: ${value.tasks[index].priority.toString().split('.').last}"}"),
                            trailing: Checkbox(
                              value: value.tasks[index].isComplete,
                              onChanged: null,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => AddTask(
          lastId: lastId,
        ), transitionDuration: const Duration(milliseconds: 500), transitionsBuilder: (_, animation, __, child) {
          return ScaleTransition(scale: animation, child: child);
        })),
        child: const Icon(Icons.add),
      ),
    );
  }
}
