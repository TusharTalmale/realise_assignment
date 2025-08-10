import 'package:flutter/material.dart';
import 'package:task_manager/mock_data.dart';
import 'package:task_manager/task_card.dart';
import 'package:task_manager/task_model.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late List<Task> tasks;

  @override
  void initState() {
    super.initState();
    tasks = List.from(mockTasks);
    _sortTasks();
  }

  // Sort to match screenshot order
  void _sortTasks() {
    tasks.sort((a, b) {
      int statusPriority(TaskStatus s) {
        switch (s) {
          case TaskStatus.overdue:
            return 0;
          case TaskStatus.completed:
            return 1;
          case TaskStatus.due:
            return 2;
        }
      }

      // Sort primarily by status
      int cmp = statusPriority(a.status).compareTo(statusPriority(b.status));
      if (cmp != 0) return cmp;

      // Overdue: shortest overdue time first
      if (a.status == TaskStatus.overdue) {
        return DateTime.now()
            .difference(a.deadline)
            .compareTo(DateTime.now().difference(b.deadline));
      }

      // Completed: newest first
      if (a.status == TaskStatus.completed) {
        return (b.startedDate ?? DateTime(1970))
            .compareTo(a.startedDate ?? DateTime(1970));
      }

      // Due: soonest deadline first
      if (a.status == TaskStatus.due) {
        return a.deadline.compareTo(b.deadline);
      }

      return 0;
    });
  }

  void updateTaskStatus(Task taskToUpdate, TaskStatus newStatus) {
    setState(() {
      final idx = tasks.indexWhere((t) => t.id == taskToUpdate.id);
      if (idx != -1) {
        tasks[idx].status = newStatus;
        if (newStatus == TaskStatus.overdue &&
            tasks[idx].startedDate == null) {
          tasks[idx].startedDate = DateTime.now();
        } else if (newStatus == TaskStatus.completed) {
          tasks[idx].startedDate = DateTime.now();
        } else if (newStatus == TaskStatus.due) {
          tasks[idx].startedDate = null;
        }
        _sortTasks();
      }
    });
  }

  void updateTaskDate(String taskId, DateTime newDate) {
    setState(() {
      final idx = tasks.indexWhere((t) => t.id == taskId);
      if (idx != -1) {
        tasks[idx].startedDate = newDate;
        _sortTasks();
      }
    });
  }

  Future<void> _selectDate(BuildContext context, Task task) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: task.startedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      updateTaskDate(task.id, picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8 ),
          child: Column(
            children: [
              const Divider(color: Colors.blue, thickness: 1.5, height: 1),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        TaskCard(
                          task: tasks[index],
                          onUpdate: (task, newStatus) =>
                              updateTaskStatus(task, newStatus),
                          onEditDate: (task) => _selectDate(context, task),
                        ),
                     
                      ],
                    );
                           
                  },
               // separatorBuilder: (_, __) =>
                      // const SizedBox(height: 4), // Tight spacing like screenshot
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
