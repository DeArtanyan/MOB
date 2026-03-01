import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RentalPriceRangeFilter extends StatefulWidget {
  const RentalPriceRangeFilter({
    super.key,
    required this.values,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.formatLabel,
  });

  final RangeValues values;
  final double min;
  final double max;
  final ValueChanged<RangeValues> onChanged;
  final String Function(double value) formatLabel;

  @override
  State<RentalPriceRangeFilter> createState() => _RentalPriceRangeFilterState();
}

class _RentalPriceRangeFilterState extends State<RentalPriceRangeFilter> {
  late final TextEditingController _startController;
  late final TextEditingController _endController;
  late final FocusNode _startFocusNode;
  late final FocusNode _endFocusNode;

  double get _step => 1000;

  int get _divisions {
    final step = _step;
    if (step <= 0) return 1;
    return ((widget.max - widget.min) / step).round().clamp(1, 1000);
  }

  @override
  void initState() {
    super.initState();
    _startController = TextEditingController();
    _endController = TextEditingController();
    _startFocusNode = FocusNode();
    _endFocusNode = FocusNode();

    _startFocusNode.addListener(() {
      if (!_startFocusNode.hasFocus) _applyTypedValue(isStart: true);
    });
    _endFocusNode.addListener(() {
      if (!_endFocusNode.hasFocus) _applyTypedValue(isStart: false);
    });

    _syncControllers();
  }

  @override
  void didUpdateWidget(covariant RentalPriceRangeFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_startFocusNode.hasFocus) {
      _startController.text = _displayText(widget.values.start);
    }
    if (!_endFocusNode.hasFocus) {
      _endController.text = _displayText(widget.values.end);
    }
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    _startFocusNode.dispose();
    _endFocusNode.dispose();
    super.dispose();
  }

  void _syncControllers() {
    _startController.text = _displayText(widget.values.start);
    _endController.text = _displayText(widget.values.end);
  }

  String _displayText(double value) => widget.formatLabel(value);

  void _applyTypedValue({required bool isStart}) {
    final controller = isStart ? _startController : _endController;
    final raw = controller.text.replaceAll(RegExp(r'\s+'), '');
    final parsed = int.tryParse(raw);

    if (parsed == null) {
      controller.text = _displayText(
        isStart ? widget.values.start : widget.values.end,
      );
      return;
    }

    double next = parsed.toDouble().clamp(widget.min, widget.max);
    final step = _step;
    if (step > 0) {
      next = ((next - widget.min) / step).round() * step + widget.min;
      next = next.clamp(widget.min, widget.max);
    }

    if (isStart) {
      final end = widget.values.end;
      final start = next <= end ? next : end;
      widget.onChanged(RangeValues(start, end));
      _startController.text = _displayText(start);
    } else {
      final start = widget.values.start;
      final end = next >= start ? next : start;
      widget.onChanged(RangeValues(start, end));
      _endController.text = _displayText(end);
    }
  }

  Widget _valueField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required VoidCallback onSubmitted,
  }) {
    return SizedBox(
      width: 80,
      height: 35,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        maxLines: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
          height: 1,
        ),
        cursorColor: Colors.black87,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black87, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black87, width: 1),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
        ),
        onSubmitted: (_) => onSubmitted(),
        onTapOutside: (_) {
          focusNode.unfocus();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _valueField(
          controller: _startController,
          focusNode: _startFocusNode,
          onSubmitted: () => _applyTypedValue(isStart: true),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6,
              activeTrackColor: const Color(0xFFD5DDE4),
              inactiveTrackColor: const Color(0xFFD5DDE4),
              thumbColor: const Color(0xFF7E94A8),
              rangeThumbShape: const RoundRangeSliderThumbShape(
                enabledThumbRadius: 9,
              ),
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: RangeSlider(
              values: widget.values,
              min: widget.min,
              max: widget.max,
              divisions: _divisions,
              onChanged: widget.onChanged,
            ),
          ),
        ),
        const SizedBox(width: 10),
        _valueField(
          controller: _endController,
          focusNode: _endFocusNode,
          onSubmitted: () => _applyTypedValue(isStart: false),
        ),
      ],
    );
  }
}
