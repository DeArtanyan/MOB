import 'package:wordpice/features/profile/domain/entities/rental_history_item.dart';

/// Источник данных для профиля.
abstract class ProfileDataSource {
  Future<List<RentalHistoryItem>> getRentalHistory();
}
