import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback onNotifications;
  final int notificationCount; // 0 => не показываем бейдж

  const AppHeader({
    super.key,
    required this.onLogout,
    required this.onNotifications,
    this.notificationCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.black26),
            ),
            child: const Icon(Icons.image_outlined, color: Colors.black45),
          ),
          const SizedBox(width: 10),
          const Text('LOGOTYPE', style: AppTextStyles.header20),
          const Spacer(),
          OutlinedButton(
            onPressed: onLogout,
            child: const Text('Выход'),
          ),
          const SizedBox(width: 10),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: onNotifications,
                icon: const Icon(Icons.notifications_none),
              ),
              if (notificationCount > 0)
                Positioned(
                  top: 6,
                  right: 8,
                  child: Container(
                    width: 16,
                    height: 16,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black87),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
