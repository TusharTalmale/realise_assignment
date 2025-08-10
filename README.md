# Flutter Task Manager UI

An interactive task list screen built with Flutter, demonstrating a clean and responsive UI for managing tasks with different statuses and deadlines.

## ✨ Features

### Dynamic Task Cards
Each task is displayed in a card whose appearance changes based on its status:

- **Overdue**: Highlighted in **red**.
- **Completed**: Faded appearance with a **green checkmark**.
- **Due**: Distinct **purple and gray** theme.

### Interactive Workflow
- **Start Task**: Available for tasks that are **Due**.  
  → Tapping changes status to **Overdue**.
- **Mark as Complete**: Available for tasks that are **Overdue**.  
  → Tapping changes status to **Completed**.

### Editable Deadlines
- Tap the **date** or **edit icon** to open a date picker.
- Available for **Overdue** and **Due** tasks to easily update deadlines.

## 🛠 UI Components

- **`TaskScreen`** → Main screen managing the task list state.
- **`TaskCard`** → Reusable widget for displaying individual tasks with dynamic styling.
- **`TaskModel`** & **`TaskStatus`** → Data model and enum for structure and state of tasks.
- **`mock_data`** → Contains sample task data for demonstration.

## 📂 Project Structure
```
lib/
├── task_screen.dart # Main task screen
├── task_card.dart # Task card UI component
├── task_model.dart # Task data model & enum
├── mock_data.dart # Sample tasks
└── main.dart # App entry point
```