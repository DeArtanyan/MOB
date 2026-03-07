import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';

class SegmentCarousel extends StatefulWidget {
  const SegmentCarousel({
    super.key,
    required this.items,
    required this.onChanged,
    this.initialIndex = 0,
  });

  final List<String> items;
  final ValueChanged<int> onChanged;
  final int initialIndex;

  @override
  State<SegmentCarousel> createState() => _SegmentCarouselState();
}

class _SegmentCarouselState extends State<SegmentCarousel> {
  static const int _loopMultiplier = 1000;

  late final PageController _controller;

  @override
  void initState() {
    super.initState();

    final safeLength = widget.items.isEmpty ? 1 : widget.items.length;
    final initialIndex = widget.initialIndex.clamp(0, safeLength - 1);

    final initialPage = safeLength * _loopMultiplier + initialIndex;
    _controller = PageController(
      initialPage: initialPage,
      viewportFraction: 1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _prev() {
    if (widget.items.isEmpty) return;
    _controller.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _next() {
    if (widget.items.isEmpty) return;
    _controller.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

    const double kHeight = 38;
    const double kArrowSize = 34;
    const double kRadius = 10;

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ArrowButton(
            icon: Icons.chevron_left,
            onTap: _prev,
            size: kArrowSize,
            radius: kRadius,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 160,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kRadius),
              child: SizedBox(
                height: kHeight,
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (page) {
                    final nextIndex = page % widget.items.length;
                    widget.onChanged(nextIndex);
                  },
                  itemBuilder: (_, page) {
                    final itemIndex = page % widget.items.length;
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.formSurface,
                        borderRadius: BorderRadius.circular(kRadius),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Text(
                        widget.items[itemIndex],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          _ArrowButton(
            icon: Icons.chevron_right,
            onTap: _next,
            size: kArrowSize,
            radius: kRadius,
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
        child: Icon(icon, color: Colors.black87, size: 20),
      ),
    );
  }
}
