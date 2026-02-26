import 'package:wordpice/features/profile/presentation/models/profile_request_item.dart';

const List<ProfileRequestItem> profileRequestsMockData = [
  ProfileRequestItem(
    number: 1,
    requestType: 'клининг',
    roomType: 'переговорная',
    roomNumber: '1',
    workTime: '10:00 - 12:00',
    comment: 'протрите пыль',
  ),
  ProfileRequestItem(
    number: 2,
    requestType: 'ремонт',
    roomType: 'офис',
    roomNumber: '4',
    workTime: '15:00 - 17:00',
    comment: 'не работает розетка',
  ),
];
