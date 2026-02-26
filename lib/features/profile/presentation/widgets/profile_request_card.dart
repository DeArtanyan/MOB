import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/features/profile/presentation/models/profile_request_item.dart';

class ProfileRequestCard extends StatelessWidget {
  const ProfileRequestCard({
    super.key,
    required this.item,
  });

  final ProfileRequestItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Заявка №${item.number}:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(13, 13, 13, 13),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Тип заявки: ${item.requestType}',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Text(
                'Тип помещения: ${item.roomType} Кабинет №: ${item.roomNumber}',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Text(
                'Время работы: ${item.workTime}',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Комментарий: ${item.comment}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                  if (item.hasAttachment)
                    SvgPicture.asset(
                      'assets/icons/document_download.svg',
                      width: 28,
                      height: 28,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
