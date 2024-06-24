import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:my_tasks/blocs/task_bloc.dart';
import 'package:my_tasks/models/task.dart';
import 'package:my_tasks/utils/globals.dart';

class AddTask extends StatefulWidget {
  final int lastId;
  final Task? task;

  const AddTask({super.key, required this.lastId, this.task});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late final TextEditingController titleController, descriptionController;
  late Priority? priority;
  late bool? isCompleted;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task?.title);
    descriptionController =
        TextEditingController(text: widget.task?.description);
    priority = widget.task?.priority;
    isCompleted = widget.task?.isComplete;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.task == null ? "Add" : "Edit"} Task"),
      ),
      body: SafeArea(
        child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField(
                  value: priority,
                  items: const [
                    DropdownMenuItem(
                      value: Priority.SIMPLE,
                      child: Text('Simple'),
                    ),
                    DropdownMenuItem(
                      value: Priority.MEDIUM,
                      child: Text('Medium'),
                    ),
                    DropdownMenuItem(
                      value: Priority.DIFFICULT,
                      child: Text('Difficult'),
                    ),
                  ],
                  onChanged: (value) => priority = value!,
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(),
                  ),
                ),
                Visibility(
                  visible: widget.task != null,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const Text("Mark task as completed?"),
                    Checkbox(value: isCompleted ?? false, onChanged: (value) {
                      setState(() {
                        isCompleted = value!;
                      });
                      widget.task!.isComplete = value!;
                    })
                  ],),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      if (widget.task == null) {
                        context.read<TaskBloc>().add(
                              AddTaskEvent(
                                Task(
                                  id: widget.lastId + 1,
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  priority: priority!,
                                  isComplete: false,
                                ),
                              ),
                            );
                      } else {
                        widget.task!.title = titleController.text;
                        widget.task!.description = descriptionController.text;
                        widget.task!.priority = priority!;
                        context.read<TaskBloc>().add(UpdateTaskEvent(widget.task!));
                      }
                      Get.back();
                    },
                    child:
                        Text(widget.task == null ? 'Add Task' : 'Update Task'))
              ],
            )),
      ),
    );
  }
}
