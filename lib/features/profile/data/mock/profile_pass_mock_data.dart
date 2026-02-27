import 'package:wordpice/features/profile/presentation/models/profile_pass_item.dart';

const ProfilePassItem profilePassMockData = ProfilePassItem(
  title: 'Пропуск для сотрудника',
  showButtonLabel: 'Показать',
  parkingPlace: '№31',
  validUntilText: 'Действителен до 31.12.2026',
  // validUntilText: null, // если нет даты действия -> "Нет активных пропусков"
  // parkingPlace: null,   // если нет парковки -> "Парковочное место: Нет"
);
