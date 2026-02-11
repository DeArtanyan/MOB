import 'package:wordpice/features/profile/data/datasources/profile_mock_data_source.dart';
import 'package:wordpice/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:wordpice/features/profile/domain/repositories/profile_repository.dart';

/// Простейшая ручная "сборка" зависимостей приложения.
///
/// Почему так:
/// - без сторонних пакетов (по твоим правилам)
/// - новичку понятно: один класс, который создаёт нужные объекты
///
/// Позже сюда можно будет добавить ApiClient, RemoteDataSource и т.д.
class AppDependencies {
  final ProfileRepository profileRepository;

  AppDependencies({required this.profileRepository});

  /// Фабрика зависимостей для режима "моки".
  factory AppDependencies.mock() {
    final profileDataSource = ProfileMockDataSource();
    final profileRepository = ProfileRepositoryImpl(profileDataSource);

    return AppDependencies(profileRepository: profileRepository);
  }
}
