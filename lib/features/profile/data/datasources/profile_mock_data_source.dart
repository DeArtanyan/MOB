import 'package:wordpice/features/profile/data/datasources/profile_data_source.dart';
import 'package:wordpice/features/profile/domain/entities/rental_history_item.dart';

/// Мок-реализация источника данных профиля.
class ProfileMockDataSource implements ProfileDataSource {
  @override
  Future<List<RentalHistoryItem>> getRentalHistory() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return const <RentalHistoryItem>[];
  }
}
