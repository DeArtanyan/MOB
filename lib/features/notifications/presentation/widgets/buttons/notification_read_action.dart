import 'package:flutter/material.dart';
import 'package:wordpice/features/notifications/presentation/widgets/styles/notification_styles.dart';

class NotificationReadAction extends StatefulWidget {
  const NotificationReadAction({
    super.key,
    required this.label,
    this.value,
    this.onChanged,
  });

  final String label;
  final bool? value;
  final ValueChanged<bool>? onChanged;

  @override
  State<NotificationReadAction> createState() => _NotificationReadActionState();
}

class _NotificationReadActionState extends State<NotificationReadAction> {
  bool _internalValue = false;

  bool get _isActive => widget.value ?? _internalValue;

  void _toggle() {
    final nextValue = !_isActive;
    if (widget.value == null) {
      setState(() => _internalValue = nextValue);
    }
    widget.onChanged?.call(nextValue);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggle,
      borderRadius: BorderRadius.circular(999),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _NotificationReadToggle(isActive: _isActive),
          const SizedBox(width: 8),
          Text(widget.label, style: NotificationStyles.actionText),
        ],
      ),
    );
  }
}

class _NotificationReadToggle extends StatelessWidget {
  const _NotificationReadToggle({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 22,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EEF2),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: Colors.black54, width: 1),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFF5EBD7E)
                : const Color(0xFFFF7C8F),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
