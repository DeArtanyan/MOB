import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/features/notifications/presentation/models/notification_item.dart';
import 'package:wordpice/features/notifications/presentation/widgets/buttons/notification_read_action.dart';
import 'package:wordpice/features/notifications/presentation/widgets/styles/notification_styles.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.item,
    required this.isRead,
    required this.onReadChanged,
  });

  final NotificationItem item;
  final bool isRead;
  final ValueChanged<bool> onReadChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: NotificationStyles.cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: Text(
                            item.title,
                            style: NotificationStyles.cardTopicText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(item.message, style: NotificationStyles.messageText),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            item.dateTimeText,
                            style: NotificationStyles.dateText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 14,
                    right: 14,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 180),
                      opacity: isRead ? 0 : 1,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF5A67),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: SvgPicture.asset(
                  'assets/icons/delete.svg',
                  width: 40,
                  height: 40,
                  colorFilter: const ColorFilter.mode(
                    Colors.black54,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        NotificationReadAction(
          label: 'Прочитать уведомление',
          value: isRead,
          onChanged: onReadChanged,
        ),
      ],
    );
  }
}
