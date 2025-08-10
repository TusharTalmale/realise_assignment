import 'package:task_manager/task_model.dart';

final List<Task> mockTasks = [
  // Overdue Tasks
  Task(
    id: 'Order-1043',
    type: 'Arrange Pickup',
    title: 'Arrange Pickup',
    assignee: 'Sandhya',
    priority: 'High Priority',
    status: TaskStatus.overdue,
    startedDate: DateTime(2025, 6, 10),
    deadline: DateTime(2025, 6, 20),
  ),
  Task(
    id: 'Entity-2559',
    type: 'Adhoc Task',
    title: 'Adhoc Task',
    assignee: 'Arman',
    priority: null,
    status: TaskStatus.overdue,
    startedDate: DateTime(2025, 6, 12),
    deadline: DateTime(2025, 6, 12),
  ),
  Task(
    id: 'Order-1020',
    type: 'Collect Payment',
    title: 'Collect Payment',
    assignee: 'Sandhya',
    priority: 'High Priority',
    status: TaskStatus.overdue,
    startedDate: DateTime(2025, 6, 15),
    deadline: DateTime(2025, 6, 22),
  ),

  // Completed Tasks
  Task(
    id: 'Order-194',
    type: 'Arrange Delivery',
    title: 'Arrange Delivery',
    assignee: 'Prashant',
    priority: null,
    status: TaskStatus.completed,
    startedDate: DateTime(2023, 8, 20),
    deadline: DateTime(2023, 8, 21),
  ),
  Task(
    id: 'Entity-2184',
    type: 'Share Company Profile',
    title: 'Share Company Profile',
    assignee: 'Asif Khan K',
    priority: null,
    status: TaskStatus.completed,
    startedDate: DateTime(2023, 8, 22),
    deadline: DateTime(2023, 8, 23),
  ),
  Task(
    id: 'Entity-472',
    type: 'Add Followup',
    title: 'Add Followup',
    assignee: 'Avik',
    priority: null,
    status: TaskStatus.completed,
    startedDate: DateTime(2023, 8, 25),
    deadline: DateTime(2023, 8, 26),
  ),

  // Due Tasks
  Task(
    id: 'Enquiry-3563',
    type: 'Convert Enquiry',
    title: 'Convert Enquiry',
    assignee: 'Prashant',
    priority: null,
    status: TaskStatus.due,
    startedDate: DateTime(2023, 8, 28),
    deadline: DateTime(2023, 8, 30),
  ),
  Task(
    id: 'Order-176',
    type: 'Arrange Pickup',
    title: 'Arrange Pickup',
    assignee: 'Prashant',
    priority: 'High Priority',
    status: TaskStatus.due,
    startedDate: DateTime(2023, 9, 1),
    deadline: DateTime(2023, 9, 2),
  ),
];
