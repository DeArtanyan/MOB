import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/features/profile/presentation/models/profile_pass_item.dart';
import 'package:wordpice/features/profile/presentation/widgets/cards/profile_surface_card.dart';
import 'package:wordpice/features/profile/presentation/widgets/styles/profile_card_decorations.dart';
import 'package:wordpice/features/profile/presentation/widgets/styles/profile_card_styles.dart';

class ProfilePassCard extends StatelessWidget {
  const ProfilePassCard({
    super.key,
    required this.pass,
    required this.onShowPressed,
  });

  static const String _emptyStateText = 'Нет активных пропусков';

  final ProfilePassItem pass;
  final VoidCallback onShowPressed;

  @override
  Widget build(BuildContext context) {
    return ProfileSurfaceCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const _PassQrIcon(),
            const SizedBox(width: 12),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 84),
                child: pass.hasActivePass
                    ? _ActivePassContent(
                        pass: pass,
                        onShowPressed: onShowPressed,
                      )
                    : const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _emptyStateText,
                          style: ProfileCardStyles.title,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PassQrIcon extends StatelessWidget {
  const _PassQrIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: ProfileCardDecorations.outlinedCard(
        color: AppColors.background,
      ),
      child: const Icon(Icons.qr_code_2, size: 30),
    );
  }
}

class _ActivePassContent extends StatelessWidget {
  const _ActivePassContent({required this.pass, required this.onShowPressed});

  final ProfilePassItem pass;
  final VoidCallback onShowPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          pass.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: ProfileCardStyles.passTitle,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 30,
          child: OutlinedButton(
            onPressed: onShowPressed,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              side: ProfileCardDecorations.outlineBorderSide,
              shape: const RoundedRectangleBorder(
                borderRadius: ProfileCardDecorations.outlineRadius,
              ),
            ),
            child: Text(
              pass.showButtonLabel,
              style: ProfileCardStyles.passButton,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Парковочное место: ${pass.parkingPlaceOrFallback}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: ProfileCardStyles.passMeta,
        ),
      ],
    );
  }
}
