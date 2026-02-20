import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:wordpice/features/profile/presentation/widgets/qr_modal.dart';
import 'package:wordpice/features/profile/presentation/widgets/segment_carousel.dart';

/// Экран "Профиль" (UI-only).
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const int _tabIndex = 3; // Профиль
  int _selectedBottomIndex = _tabIndex;
  int _carouselIndex = 0;

  void _openEditScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const EditProfileScreen()),
    );
  }

  void _onBottomChanged(int index) {
    if (index == _tabIndex) return;
    setState(() => _selectedBottomIndex = index);
    AppTabNavigator.goToTab(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 28),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              children: [
                _UserCard(onEditTap: _openEditScreen),
                const SizedBox(height: 30),
                _NarrowCard(child: _InfoCard(onEditTap: _openEditScreen)),
                const SizedBox(height: 30),
                _NarrowCard(
                  child: _PassCard(
                    onShowPressed: () => QrModal.showQr(
                      context,
                      validUntilText: 'Действителен до 31.12.2026',
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _NarrowCard(
                  child: Center(
                    child: SegmentCarousel(
                      items: const ['Избранное', 'Все аренды', 'Переговорные'],
                      initialIndex: _carouselIndex,
                      onChanged: (i) => setState(() => _carouselIndex = i),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const _NarrowCard(child: _FiltersGrid()),
                const SizedBox(height: 16),
                const Text(
                  'У вас нет истории аренд',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NarrowCard extends StatelessWidget {
  const _NarrowCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 340, child: child);
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

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

class _UserCard extends StatelessWidget {
  const _UserCard({required this.onEditTap});

  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(27),
                  ),
                  child: const Icon(Icons.person_outline, size: 26),
                ),
                Positioned(
                  top: -6,
                  right: -6,
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      onPressed: onEditTap,
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        'assets/icons/edit-2.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Фамилия Имя Отчество',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Должность',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.onEditTap});

  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Почта',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'почта@mail.ru',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Компания',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'ООО "Офис"',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: IconButton(
                onPressed: onEditTap,
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  'assets/icons/edit.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PassCard extends StatelessWidget {
  const _PassCard({required this.onShowPressed});

  final VoidCallback onShowPressed;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border, width: 1),
              ),
              child: const Icon(Icons.qr_code_2, size: 30),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Пропуск для сотрудника',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 30,
                    child: OutlinedButton(
                      onPressed: onShowPressed,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        side: BorderSide(color: AppColors.border, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Показать',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Парковочное место: №31',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FiltersGrid extends StatelessWidget {
  const _FiltersGrid();

  @override
  Widget build(BuildContext context) {
    Widget btn(String text) {
      return SizedBox(
        width: 160,
        height: 34,
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.border, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            btn('Все аренды'),
            btn('Переговорные'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            btn('Коворкинг'),
            btn('Офис'),
          ],
        ),
      ],
    );
  }
}
