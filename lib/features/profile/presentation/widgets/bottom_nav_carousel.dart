import 'package:flutter/material.dart';

class BottomNavCarousel extends StatefulWidget {
  final int selectedIndex; // 0..3
  final ValueChanged<int> onChanged;

  const BottomNavCarousel({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  State<BottomNavCarousel> createState() => _BottomNavCarouselState();
}

class _BottomNavCarouselState extends State<BottomNavCarousel> {
  static const _items = <String>[
    'Аренды',
    'Заявки',
    'Пропуск',
    'Профиль',
  ];

  late final PageController _controller;
  late int _page; // большой индекс для бесконечности

  int get _count => _items.length;

  @override
  void initState() {
    super.initState();

    // делаем “бесконечный” диапазон страниц
    _page = 1000 + widget.selectedIndex;
    _controller = PageController(viewportFraction: 0.62, initialPage: _page);
  }

  @override
  void didUpdateWidget(covariant BottomNavCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    // если снаружи сменили selectedIndex — аккуратно перелистнём
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      final target = (_page - (_page % _count)) + widget.selectedIndex;
      _page = target;
      _controller.jumpToPage(_page);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    return SafeArea(
      top: false,
      child: Container(
        height: 74,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Row(
          children: [
            _ArrowButton(isLeft: true, onTap: _goLeft),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (p) {
                  _page = p;
                  widget.onChanged(_realIndex(p));
                },
                itemBuilder: (_, p) {
                  final idx = _realIndex(p);
                  final selected = idx == widget.selectedIndex;

                  return Center(
                    child: _NavPill(
                      text: _items[idx],
                      selected: selected,
                    ),
                  );
                },
              ),
            ),

            _ArrowButton(isLeft: false, onTap: _goRight),
          ],
        ),
      ),
    );
  }
}

class _NavPill extends StatelessWidget {
  final String text;
  final bool selected;

  const _NavPill({
    required this.text,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Colors.grey.shade200 : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black87),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final bool isLeft;
  final VoidCallback onTap;

  const _ArrowButton({required this.isLeft, required this.onTap});

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
