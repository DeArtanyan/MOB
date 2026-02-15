import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/features/splash/presentation/widgets/splash_logo.dart';

/// Общий хедер приложения.
///
/// Что изменено:
/// - Привёл выравнивание к макету: серый фон, ровные отступы, без "кривых" Positioned.
/// - Логотип берём из SplashLogo (единый вид во всём приложении).
/// - Кнопка "Выход" сделана компактной (как в прототипе).
/// - Иконка уведомлений поддерживает бейдж: если notificationCount == 0, бейджа нет.
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.controlGrey,
        border: Border(
          bottom: BorderSide(color: AppColors.border.withOpacity(0.25), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Логотип слева
          const SplashLogo(),

          const Spacer(),

          // Кнопка "Выход"
          SizedBox(
            height: 34,
            child: OutlinedButton(
              onPressed: onLogout,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                side: BorderSide(color: AppColors.border, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Выход',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Уведомления (иконка + бейдж)
          SizedBox(
            width: 40,
            height: 40,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onNotifications,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // Если у тебя есть PNG иконка - используем её.
                  // Если файла нет (например в будущем), покажется стандартная иконка.
                  Image.asset(
                    'assets/icons/notification.png',
                    width: 22,
                    height: 22,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.notifications_none,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (notificationCount > 0)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        width: 18,
                        height: 18,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        child: Text(
                          '$notificationCount',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
