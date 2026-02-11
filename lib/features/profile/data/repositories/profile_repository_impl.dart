import 'package:wordpice/features/profile/data/datasources/profile_data_source.dart';
import 'package:wordpice/features/profile/domain/entities/rental_history_item.dart';
import 'package:wordpice/features/profile/domain/repositories/profile_repository.dart';

/// Реализация репозитория (data-layer).
///
/// Здесь мы "подключаем" конкретный источник данных.
/// Сейчас это мок, позже будет HTTP-реализация.
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource _dataSource;

  ProfileRepositoryImpl(this._dataSource);

  @override
  Future<List<RentalHistoryItem>> getRentalHistory() {
    return _dataSource.getRentalHistory();
  }
}
