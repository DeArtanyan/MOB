import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/core/theme/app_colors.dart';

class BottomNavItem {
  final String label;
  final String iconAsset;

  const BottomNavItem({required this.label, required this.iconAsset});
}

class BottomNavCarousel extends StatefulWidget {
  const BottomNavCarousel({
    super.key,
    required this.items,
    required this.onChanged,
    this.initialIndex = 0,
  });

  final List<BottomNavItem> items;
  final ValueChanged<int> onChanged;
  final int initialIndex;

  @override
  State<BottomNavCarousel> createState() => _BottomNavCarouselState();
}

class _BottomNavCarouselState extends State<BottomNavCarousel> {
  late final PageController _controller;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex.clamp(0, widget.items.length - 1);
    _controller = PageController(
      initialPage: _index,
      viewportFraction: 1.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _prev() {
    if (_index <= 0) return;
    _controller.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _next() {
    if (_index >= widget.items.length - 1) return;
    _controller.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: AppColors.controlGrey,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          _Arrow(icon: Icons.chevron_left, onTap: _prev),
          const SizedBox(width: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                height: 56,
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (i) {
                    setState(() => _index = i);
                    widget.onChanged(i);
                  },
                  itemCount: widget.items.length,
                  itemBuilder: (_, i) {
                    final item = widget.items[i];
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              item.iconAsset,
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.label,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          _Arrow(icon: Icons.chevron_right, onTap: _next),
        ],
      ),
    );
  }
}

class _Arrow extends StatelessWidget {
  const _Arrow({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 56,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: BorderSide(color: AppColors.border, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Icon(icon, color: Colors.black87),
      ),
    );
  }
}
