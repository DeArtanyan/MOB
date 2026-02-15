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
  late final PageController _controller;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex.clamp(0, widget.items.length - 1);
    _controller = PageController(
      initialPage: _index,
      viewportFraction: 1.0, // важно: соседи не должны быть видны
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
    // В прототипе стрелки и центральная кнопка компактнее.
    // У пользователя в эмуляторе обрезался текст — поэтому:
    // - уменьшаем высоты
    // - задаём TextStyle.height = 1.0
    const double kHeight = 38;
    const double kArrowSize = 34;
    const double kRadius = 14;

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
                onPageChanged: (i) {
                  setState(() => _index = i);
                  widget.onChanged(i);
                },
                itemCount: widget.items.length,
                itemBuilder: (_, i) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(kRadius),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: Text(
                      widget.items[i],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        ),
        child: Icon(icon, color: Colors.black87, size: 20),
      ),
    );
  }
}
