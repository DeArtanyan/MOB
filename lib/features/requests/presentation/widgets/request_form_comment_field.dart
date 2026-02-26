import 'package:flutter/material.dart';

class RequestFormCommentField extends StatelessWidget {
  const RequestFormCommentField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104,
      child: TextField(
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          hintText: 'Введите комментарий',
          contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black87, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black87, width: 1),
          ),
        ),
      ),
    );
  }
}
