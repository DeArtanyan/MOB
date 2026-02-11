import 'package:flutter/material.dart';

class SegmentCarousel extends StatefulWidget {
  final List<String> items;
  final int initialIndex;
  final ValueChanged<int> onChanged;

  const SegmentCarousel({
    super.key,
    required this.items,
    required this.initialIndex,
    required this.onChanged,
  });

  @override
  State<SegmentCarousel> createState() => _SegmentCarouselState();
}

class _SegmentCarouselState extends State<SegmentCarousel> {
  late final PageController _controller;
  late int _page;
  late int _selected;

  int get _count => widget.items.length;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialIndex.clamp(0, _count - 1);
    _page = 1000 + _selected;
    _controller = PageController(viewportFraction: 0.78, initialPage: _page);
  }

  int _realIndex(int page) => page % _count;

  void _goLeft() => _controller.previousPage(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );

  void _goRight() => _controller.nextPage(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Row(
        children: [
          _Arrow(isLeft: true, onTap: _goLeft),
          const SizedBox(width: 10),

          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (p) {
                _page = p;
                final idx = _realIndex(p);
                setState(() => _selected = idx);
                widget.onChanged(idx);
              },
              itemBuilder: (_, p) {
                final idx = _realIndex(p);
                final selected = idx == _selected;

                return Center(
                  child: Container(
                    height: 42,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected ? Colors.grey.shade200 : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.black87),
                    ),
                    child: Text(
                      widget.items[idx],
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 10),
          _Arrow(isLeft: false, onTap: _goRight),
        ],
      ),
    );
  }
}

class _Arrow extends StatelessWidget {
  final bool isLeft;
  final VoidCallback onTap;

  const _Arrow({required this.isLeft, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        minimumSize: const Size(38, 38),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Icon(
        isLeft ? Icons.chevron_left : Icons.chevron_right,
        size: 20,
        color: Colors.black87,
      ),
    );
  }
}
