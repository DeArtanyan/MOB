import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/core/theme/app_colors.dart';

/// Нижняя навигация профиля.
class ProfileBottomNavBar extends StatefulWidget {
  const ProfileBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  State<ProfileBottomNavBar> createState() => _ProfileBottomNavBarState();
}

class _ProfileBottomNavBarState extends State<ProfileBottomNavBar> {
  static const int _visibleCount = 4;

  final List<_NavItemData> _items = const <_NavItemData>[
    _NavItemData(label: 'Аренды', iconAsset: 'assets/icons/nav_rentals.svg'),
    _NavItemData(label: 'Заявки', iconAsset: 'assets/icons/nav_requests.svg'),
    _NavItemData(label: 'Пропуск', iconAsset: 'assets/icons/nav_pass.svg'),
    _NavItemData(label: 'Профиль', iconAsset: 'assets/icons/nav_profile.svg'),
    _NavItemData(label: 'Отзывы', iconAsset: 'assets/icons/nav_reviews.svg'),
    _NavItemData(label: 'Парковка', iconAsset: 'assets/icons/nav_parking.svg'),
    _NavItemData(label: 'Архив', iconAsset: 'assets/icons/nav_archive.svg'),
  ];

  int _startIndex = 0;

  @override
  void initState() {
    super.initState();
    _syncStartToSelected();
  }

  @override
  void didUpdateWidget(covariant ProfileBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _syncStartToSelected();
    }
  }

  void _syncStartToSelected() {
    final maxStart = (_items.length - _visibleCount).clamp(0, 999);
    int start = _startIndex;

    if (widget.selectedIndex < start) {
      start = widget.selectedIndex;
    } else if (widget.selectedIndex >= start + _visibleCount) {
      start = widget.selectedIndex - (_visibleCount - 1);
    }

    _startIndex = start.clamp(0, maxStart);
  }

  void _prev() {
    if (_startIndex <= 0) return;
    setState(() => _startIndex -= 1);
  }

  void _next() {
    final maxStart = (_items.length - _visibleCount).clamp(0, 999);
    if (_startIndex >= maxStart) return;
    setState(() => _startIndex += 1);
  }

  @override
  Widget build(BuildContext context) {
    final visible = _items.sublist(
      _startIndex,
      (_startIndex + _visibleCount).clamp(0, _items.length),
    );

    const double barHeight = 100;
    const double arrowSize = 34;
    const double arrowRadius = 14;

    return Container(
      height: barHeight,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
      decoration: BoxDecoration(
        color: AppColors.controlGrey,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Row(
        children: [
          _ArrowButton(
            icon: Icons.chevron_left,
            onTap: _prev,
            size: arrowSize,
            radius: arrowRadius,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(visible.length, (localIndex) {
                final globalIndex = _startIndex + localIndex;
                final item = visible[localIndex];
                final isSelected = globalIndex == widget.selectedIndex;

                return Expanded(
                  child: _NavItem(
                    label: item.label,
                    iconAsset: item.iconAsset,
                    isSelected: isSelected,
                    onTap: () => widget.onChanged(globalIndex),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(width: 10),
          _ArrowButton(
            icon: Icons.chevron_right,
            onTap: _next,
            size: arrowSize,
            radius: arrowRadius,
          ),
        ],
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    required this.icon,
    required this.onTap,
    required this.size,
    required this.radius,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: BorderSide(color: AppColors.border, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.iconAsset,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String iconAsset;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconAsset,
              width: 28,
              height: 28,
              colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItemData {
  final String label;
  final String iconAsset;

  const _NavItemData({
    required this.label,
    required this.iconAsset,
  });
}
