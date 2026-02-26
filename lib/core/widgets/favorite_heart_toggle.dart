import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteHeartToggle extends StatefulWidget {
  const FavoriteHeartToggle({
    super.key,
    this.initialFilled = false,
    this.size = 24,
    this.filledColor = const Color(0xFFF06292),
  });

  final bool initialFilled;
  final double size;
  final Color filledColor;

  @override
  State<FavoriteHeartToggle> createState() => _FavoriteHeartToggleState();
}

class _FavoriteHeartToggleState extends State<FavoriteHeartToggle> {
  late bool _isFilled;

  @override
  void initState() {
    super.initState();
    _isFilled = widget.initialFilled;
  }

  void _toggle() => setState(() => _isFilled = !_isFilled);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Icon(
          _isFilled ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
          size: widget.size,
          color: _isFilled ? widget.filledColor : Colors.black87,
        ),
      ),
    );
  }
}
