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
    return Row(
      children: [
        _ArrowButton(icon: Icons.chevron_left, onTap: _prev),
        const SizedBox(width: 10),

        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              height: 44,
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
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: Text(
                      widget.items[i],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
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
        _ArrowButton(icon: Icons.chevron_right, onTap: _next),
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
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
