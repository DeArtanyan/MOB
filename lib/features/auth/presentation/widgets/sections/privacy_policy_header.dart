import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';

class PrivacyPolicyHeader extends StatelessWidget {
  const PrivacyPolicyHeader({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.controlGrey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, size: 16),
            style: IconButton.styleFrom(
              side: const BorderSide(color: Colors.black87),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(28, 28),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Политика конфиденциальности',
              style: TextStyle(
                fontFamily: 'MontserratAlternates',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),

            ),
          ),
        ],
      ),
    );
  }
}
