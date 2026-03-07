import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/features/splash/presentation/widgets/splash_logo.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback onNotifications;
  final int notificationCount;
  final bool showActions;

  const AppHeader({
    super.key,
    required this.onLogout,
    required this.onNotifications,
    this.notificationCount = 0,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.controlGrey,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
      child: Row(
        children: [
          const SplashLogo(),
          if (showActions) ...[
            const Spacer(),
            SizedBox(
              height: 34,
              child: OutlinedButton(
                onPressed: onLogout,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  side: BorderSide(color: AppColors.border, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
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
                    SvgPicture.asset(
                      'assets/icons/notification.svg',
                      width: 30,
                      height: 30,
                      colorFilter: const ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn),
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
                            color: AppColors.controlGrey,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.border, width: 1),
                          ),
                          child: Text(
                            '$notificationCount',
                            style: const TextStyle(
                              fontSize: 11,
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
        ],
      ),
    );
  }
}
