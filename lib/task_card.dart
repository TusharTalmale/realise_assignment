import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final void Function(Task task, TaskStatus newStatus) onUpdate;
  final void Function(Task task) onEditDate;

  const TaskCard({
    super.key,
    required this.task,
    required this.onUpdate,
    required this.onEditDate,
  });

  String _formatOverdueTime(DateTime deadline) {
    final now = DateTime.now();
    final diff = now.difference(deadline);
    return "${diff.inHours}h ${diff.inMinutes.remainder(60)}m";
  }

  String _formatDueDate(DateTime deadline) {
    final now = DateTime.now();
    final diff = deadline.difference(now);
    if (diff.inDays == 0) return "Due Today";
    if (diff.inDays == 1) return "Due Tomorrow";
    if (diff.inDays > 1) return "Due in ${diff.inDays} days";
    return "Due";
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color verticalLineColor;
    bool isDashed = false;
    double opacity = 1.0;

    switch (task.status) {
      case TaskStatus.overdue:
        statusColor = Colors.green;
        verticalLineColor =const Color(0xFF673AB7);
        break;
      case TaskStatus.completed:
        statusColor = Colors.green;
        verticalLineColor = Colors.green;
        opacity = 0.5;
        break;
      case TaskStatus.due:
        statusColor = const Color(0xFF673AB7);
        verticalLineColor = Colors.grey;
        isDashed = true;
        break;
    }

    return Column(
      children: [
        
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left vertical line
            Container(
              width: 4,
              height: 99,
              child: isDashed
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        4,
                        (index) => Container(
                          height: 20,
                          width: 2,
                          color: verticalLineColor,
                        ),
                      ),
                    )
                  : Container(color: verticalLineColor),
            ),
            const SizedBox(width: 10),
        
            // Task details
            Expanded(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
SizedBox(height: 10,),
                  // ID + menu
                  Row(
                    children: [
                      Text(
                        task.id,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
  decoration: TextDecoration.underline,                          color:  task.status == TaskStatus.completed ?  const Color(0xFF673AB7).withOpacity(0.5) :
                               const Color(0xFF673AB7)
                              
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.more_vert, size: 16, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 6),
        
                  // Title
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black.withOpacity(opacity),
                    ),
                  ),
                      const SizedBox(height: 6),
        
                  // Assignee
                  if (task.assignee.isNotEmpty)
                    Row(
                      children: [
                        Text(
                          task.assignee,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.withOpacity(opacity),
                          ),
                        ),
                        if (task.priority != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          task.priority!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                      ],
                    ),
        
        
                ],
              ),
            ),
        
            // Status & actions
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox( height: 10),
                Row(
                  children: [
                    Text(
                      task.status == TaskStatus.overdue
                          ? "Overdue - ${_formatOverdueTime(task.deadline)}"
                          : task.status == TaskStatus.completed
                              ? "Completed: ${DateFormat('MMM d').format(task.startedDate ?? DateTime.now())}"
                              : _formatDueDate(task.deadline),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color:  task.status == TaskStatus.overdue ? Colors.red:   task.status == TaskStatus.completed ? Colors.green.withOpacity(0.5) : Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 4),
                    if (task.status != TaskStatus.completed)
                      GestureDetector(
                        onTap: () => onEditDate(task),
                        child: const Icon(Icons.edit_square,
                            size: 16, color: Colors.grey),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
        
                Row(
                  children: [
                    Text(
                      task.status == TaskStatus.overdue
                          ? "Started: ${DateFormat('MMM d').format(task.startedDate ?? DateTime.now())}"
                          : "Start: ${DateFormat('MMM d').format(task.startedDate ?? DateTime.now())}",
                      style: TextStyle(
                        fontSize: 12,
                        
                        color: Colors.grey.withOpacity(opacity),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 4),
                if (task.status != TaskStatus.completed)
                  TextButton(
                    onPressed: () => onUpdate(
                      task,
                      task.status == TaskStatus.due
                          ? TaskStatus.overdue
                          : TaskStatus.completed,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      
                    ),
                    child: Row(
                      children: [
                        Icon(
                          task.status == TaskStatus.due
                              ? Icons.play_circle_filled_outlined
                              : Icons.check,
                          size: 14,
                          color: statusColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          task.status == TaskStatus.due
                              ? "Start Task"
                              : "Mark as complete",
                          style: TextStyle(
                            fontSize: 12,
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
               
              ],
            ),
          ],
        ),
    
        if (task.status == TaskStatus.due)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4 , horizontal: 8),
          child: SizedBox(
            
            width: 500,
            child: CustomPaint(
              painter: DashedLinePainter(),
            ),
          ),
        )
      else
        Container(padding: EdgeInsets.symmetric(horizontal: 10) , child:  Divider(color: Colors.grey, height: 1 ,)),  ],
    );
  }
}



class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}