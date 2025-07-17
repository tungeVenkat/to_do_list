# 📝 ToDoList Flutter App

A simple and elegant ToDo List app built using **Flutter**, backed by **Firebase**, and structured using the **MVVM architecture**. It allows users to create, edit, delete, and manage tasks dynamically with priority levels and due dates.

---

## 🚀 Features

- ✅ Add, edit, and delete tasks
- ✅ Set title, description, priority, and due date
- ✅ Firebase Firestore for real-time database
- ✅ MVVM architecture using GetX
- ✅ Dynamic UI based on task data
- ❌ Reminder/Notification feature not working (removed temporarily)

---

## 🧠 Architecture: MVVM (Model - View - ViewModel)

- **Model** – Represents Task structure (title, desc, priority, etc.)
- **View** – Flutter widgets (UI screens)
- **ViewModel** – Controllers with business logic using GetX (`TaskController`)

---

## 🔧 Tech Stack

| Tool / Package           | Purpose                           |
|--------------------------|-----------------------------------|
| **GetX** (`get`)         | State management + navigation     |
| **Firebase Core**        | Firebase initialization           |
| **Cloud Firestore**      | Store tasks in the cloud          |
| **intl**                 | Date formatting                   |
| **uuid**                 | Unique ID generation              |

---

## 📦 Dependencies

```yaml
dependencies:
  get: ^4.6.6
  firebase_core: ^2.31.0
  cloud_firestore: ^4.8.4
  intl: ^0.19.0
  uuid: ^4.5.1
  # flutter_local_notifications: ❌ Removed due to errors
