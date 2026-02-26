import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';

class ProfileSurfaceCard extends StatelessWidget {
  const ProfileSurfaceCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.controlGrey,
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }
}
