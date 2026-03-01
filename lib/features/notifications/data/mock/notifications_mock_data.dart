import 'package:wordpice/features/notifications/presentation/models/notification_item.dart';

const String _technicalIssueTitle = 'Тема: Технические неполадки';
const String _technicalIssueMessage =
    'По техническим причинам бизнес центр сегодня с 10:00 до 12:00 не работает, приносим свои извинения';

const List<NotificationItem> notificationsMockData = [
  NotificationItem(
    title: _technicalIssueTitle,
    message: _technicalIssueMessage,
    dateTimeText: '12.02.2026, 16:27',
  ),
  NotificationItem(
    title: _technicalIssueTitle,
    message: _technicalIssueMessage,
    dateTimeText: '12.02.2026, 16:27',
  ),
  NotificationItem(
    title: _technicalIssueTitle,
    message: _technicalIssueMessage,
    dateTimeText: '12.02.2026, 16:27',
  ),
  NotificationItem(
    title: _technicalIssueTitle,
    message: _technicalIssueMessage,
    dateTimeText: '12.02.2026, 16:27',
  ),
  NotificationItem(
    title: _technicalIssueTitle,
    message: _technicalIssueMessage,
    dateTimeText: '12.02.2026, 16:27',
  ),
];
