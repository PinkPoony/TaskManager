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

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-26 at 22 01 45" src="https://github.com/user-attachments/assets/94a81348-ef2f-4960-8d81-06452a7f868d" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-26 at 22 01 51" src="https://github.com/user-attachments/assets/8e8cf512-93b8-4ed4-85ab-08ffdec952c8" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-26 at 22 04 53" src="https://github.com/user-attachments/assets/1a10bff8-14be-43a1-b776-aa887563fed5" />
