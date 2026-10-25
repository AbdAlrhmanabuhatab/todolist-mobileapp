/// Application entry point.
///
/// Configures [ScreenUtilInit], wires up [Provider] for state management,
/// applies the centralised [AppTheme], and sets up routing via [AppRouter].
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:todolist/core/router/app_router.dart';
import 'package:todolist/core/router/route_names.dart';
import 'package:todolist/core/theme/app_theme.dart';
import 'package:todolist/features/auth/presentation/providers/auth_provider.dart';
import 'package:todolist/features/tasks/data/repositories/in_memory_task_repository.dart';
import 'package:todolist/features/tasks/presentation/providers/task_provider.dart';

/// Application bootstrap.
///
/// Wraps the widget tree with [MultiProvider] so that [AuthProvider]
/// and [TaskProvider] are available to all descendant widgets.
void main() {
  runApp(const TodoApp());
}

/// The root widget of the TODO application.
///
/// Sets up:
/// 1. [MultiProvider] for dependency injection.
/// 2. [ScreenUtilInit] for responsive sizing.
/// 3. [MaterialApp] with centralised theming and routing.
class TodoApp extends StatelessWidget {
  /// Creates the [TodoApp].
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
          create: (_) => TaskProvider(
            repository: InMemoryTaskRepository(),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'TODO',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            initialRoute: RouteNames.splash,
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
