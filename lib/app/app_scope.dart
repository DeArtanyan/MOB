import 'package:flutter/material.dart';

import 'package:wordpice/app/app_dependencies.dart';

/// InheritedWidget для доступа к зависимостям приложения.
///
/// Сейчас (UI-only) зависимости почти не используются,
/// но этот каркас позволит позже подключить backend,
/// не переписывая навигацию и экраны.
class AppScope extends InheritedWidget {
  final AppDependencies dependencies;

  const AppScope({
    super.key,
    required this.dependencies,
    required super.child,
  });

  static AppDependencies of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    if (scope == null) {
      throw StateError('AppScope не найден. Оберни MaterialApp в AppScope.');
    }
    return scope.dependencies;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) => false;
}
