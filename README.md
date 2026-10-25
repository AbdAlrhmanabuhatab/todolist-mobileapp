# 📝 TODO — Clean Architecture Flutter Application

A production-grade, responsive To-Do List mobile application built with **Flutter**, designed according to **Clean Architecture** principles, strict separation of concerns, and software engineering best practices.

Designed specifically as a portfolio showcase demonstrating:
- **Clean Architecture & Feature-First Structure**
- **SOLID Principles** (Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion)
- **State Management** with `Provider` (`ChangeNotifier`)
- **Repository Pattern** with abstract contracts
- **Comprehensive Unit & Widget Testing** (100% passing tests)
- **Design System** with centralized theming, colors, typography, and responsive dimensions (`flutter_screenutil`)

---

## 🏗️ Architecture & Project Structure

The project follows a **Feature-First Clean Architecture**:

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart       # Design system color palette
│   │   ├── app_dimensions.dart   # 4-point spacing grid, radii, sizing
│   │   ├── app_strings.dart      # Centralized string localization repository
│   │   └── app_assets.dart       # Type-safe asset constants
│   ├── extensions/
│   │   └── context_extensions.dart # BuildContext helpers (theme, dimensions, snackbars)
│   ├── router/
│   │   ├── route_names.dart      # Strongly-typed route constants
│   │   └── app_router.dart       # Centralized OnGenerateRoute handling
│   ├── theme/
│   │   └── app_theme.dart        # Unified ThemeData (M3, typography, components)
│   └── widgets/
│       ├── app_primary_button.dart
│       ├── app_text_field.dart
│       ├── auth_navigation_link.dart
│       └── decorative_header_shape.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   └── models/user_model.dart
│   │   └── presentation/
│   │       ├── providers/auth_provider.dart
│   │       └── screens/
│   │           ├── login_screen.dart
│   │           └── signup_screen.dart
│   ├── onboarding/
│   │   └── presentation/
│   │       └── screens/splash_screen.dart
│   └── tasks/
│       ├── data/
│       │   ├── models/task_model.dart
│       │   └── repositories/
│       │       ├── task_repository.dart           # Abstract interface (DIP)
│       │       └── in_memory_task_repository.dart # Concrete implementation
│       └── presentation/
│           ├── providers/task_provider.dart
│           ├── screens/dashboard_screen.dart
│           └── widgets/
│               ├── dashboard_header.dart
│               ├── task_list_card.dart
│               └── task_list_item.dart
└── main.dart                     # App entrypoint & MultiProvider setup
```

---

## 🎯 Quality Standards & Engineering Highlights

| Quality Metric | Implementation |
|---|---|
| **Readability** | Strict naming conventions, comprehensive `///` documentation on every public member, idiomatic Dart 3. |
| **Maintainability** | Single source of truth for styles, strings, routes, and dimensions. Changes in one place propagate everywhere. |
| **Modularity** | Features are organized independently (`auth`, `tasks`, `onboarding`) alongside a decoupled `core` layer. |
| **Reusability** | Generic reusable UI components (`AppPrimaryButton`, `AppTextField`, `TaskListItem`, etc.) adaptable across views. |
| **Scalability** | Abstract `TaskRepository` interface allows seamlessly swapping `InMemoryTaskRepository` with Hive, Isar, Drift, or Firebase. |
| **Performance** | `const` constructors throughout the widget tree, zero unnecessary rebuilds, cached unmodifiable lists. |
| **Reliability** | Strict input validation, null-safety, and end-to-end automated unit & widget test coverage. |
| **Low Coupling** | UI depends solely on providers; providers depend on abstract repository interfaces, not concrete implementations. |

---

## 🧪 Testing Suite

Automated testing covers:
1. **Model Tests**: Immutability, `copyWith`, JSON serialization/deserialization, equality & hashCode.
2. **Repository Tests**: CRUD operations, unmodifiable list safety, edge case exceptions.
3. **Provider Tests**: Reactive state propagation, listeners notification, task stats calculations.
4. **Widget Tests**: Screen bootstrapping and UI component smoke tests.

Run all tests:
```bash
flutter test
```

Analyze code quality:
```bash
flutter analyze
```

---

## 🚀 Getting Started

1. **Clone the repository:**
   ```bash
   git clone <repo-url>
   cd todolist
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   ```bash
   flutter run
   ```
