import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';

class ProfileSurfaceCard extends StatelessWidget {
  const ProfileSurfaceCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.profileSurface,
        border: Border.all(color: AppColors.bottomNavBackground, width: 1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }
}
