# TaskManager 📋

iOS приложение для управления личными задачами. Позволяет создавать задачи, расставлять приоритеты, следить за дедлайнами и отслеживать прогресс.

## Стек

- **UI:** SwiftUI
- **Хранение данных:** SwiftData
- **Архитектура:** MVVM
- **Минимальная версия iOS:** 17.0

## Возможности

- ✅ Создание, редактирование и удаление задач
- ✅ Три уровня приоритета: низкий, средний, высокий
- ✅ Статусы задач: «К выполнению», «В процессе», «Готово»
- ✅ Дедлайны с подсветкой просроченных задач
- ✅ Поиск по задачам
- ✅ Поддержка тёмной темы

## Запуск проекта

1. Клонируй репозиторий:
```bash
git clone https://github.com/PinkPoony/TaskManager.git
```

2. Открой `TaskManager.xcodeproj` в Xcode 15+

3. Выбери симулятор или реальное устройство и нажми `Cmd + R`

> Сторонних зависимостей нет — проект запускается сразу после клонирования.

## Архитектура

Проект построен по паттерну **MVVM**:
TaskManager/
├── Models/
│   └── Task.swift
├── ViewModels/
│   └── TaskListViewModel.swift
├── Views/
│   ├── TaskListView.swift
│   ├── TaskDetailView.swift
│   ├── AddTaskView.swift
│   └── Components/
└── Assets.xcassets

## Скриншоты

<img src="https://github.com/user-attachments/assets/2617114d-5861-450d-a831-8d475c1c54ec" width="250"> 
<img src="https://github.com/user-attachments/assets/5cb6136f-98ab-445f-818a-c6a4f1633531" width="250"> 
<img src="https://github.com/user-attachments/assets/69dbbc57-4e31-4e52-834f-e6fada04e0b2" width="250">



