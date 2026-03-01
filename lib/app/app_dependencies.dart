import 'package:wordpice/features/profile/data/datasources/profile_mock_data_source.dart';
import 'package:wordpice/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:wordpice/features/profile/domain/repositories/profile_repository.dart';

/// Сборка зависимостей приложения.
class AppDependencies {
  final ProfileRepository profileRepository;

  AppDependencies({required this.profileRepository});

  /// Создание набора зависимостей с мок-реализациями.
  factory AppDependencies.mock() {
    final profileDataSource = ProfileMockDataSource();
    final profileRepository = ProfileRepositoryImpl(profileDataSource);

    return AppDependencies(profileRepository: profileRepository);
  }
}
