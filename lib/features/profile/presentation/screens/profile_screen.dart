import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/widgets/app_logo_top_left.dart';
import '../widgets/segment_carousel.dart';
import '../widgets/bottom_nav_carousel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // UI-only мок. Потом придёт с backend.
  int _unreadNotifications = 1;

  int _topCarouselIndex = 0;
  int _bottomNavIndex = 3; // "Профиль" условно

  @override
  Widget build(BuildContext context) {
    final topItems = <String>['Избранное', 'Активные аренды', 'Архив'];

    final bottomItems = const <BottomNavItem>[
      BottomNavItem(label: 'Аренды', iconAsset: 'assets/icons/nav_rentals.png'),
      BottomNavItem(label: 'Заявки', iconAsset: 'assets/icons/nav_requests.png'),
      BottomNavItem(label: 'Пропуск', iconAsset: 'assets/icons/nav_pass.png'),
      BottomNavItem(label: 'Профиль', iconAsset: 'assets/icons/nav_profile.png'),
      BottomNavItem(label: 'Отзывы', iconAsset: 'assets/icons/nav_reviews.png'),
      BottomNavItem(label: 'Парковка', iconAsset: 'assets/icons/nav_parking.png'),
      BottomNavItem(label: 'Архив', iconAsset: 'assets/icons/nav_archive.png'),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _Header(
              unreadCount: _unreadNotifications,
              onExit: () {
                // UI-only: позже будет логика выхода
              },
              onNotificationsTap: () {
                // UI-only: позже экран уведомлений
                setState(() => _unreadNotifications = 0); // чтобы увидеть, что бейдж исчезает
              },
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  children: [
                    _UserCard(),
                    const SizedBox(height: 14),
                    _EmailCompanyCard(),
                    const SizedBox(height: 14),
                    _PassCard(),
                    const SizedBox(height: 18),

                    SegmentCarousel(
                      items: topItems,
                      initialIndex: _topCarouselIndex,
                      onChanged: (i) => setState(() => _topCarouselIndex = i),
                    ),

                    const SizedBox(height: 14),

                    // Фильтры (как в макете кнопки-пилюли)
                    _FiltersGrid(),

                    const SizedBox(height: 18),

                    const Text(
                      'У вас нет истории аренд',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: BottomNavCarousel(
                items: bottomItems,
                initialIndex: _bottomNavIndex,
                onChanged: (i) => setState(() => _bottomNavIndex = i),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.unreadCount,
    required this.onExit,
    required this.onNotificationsTap,
  });

  final int unreadCount;
  final VoidCallback onExit;
  final VoidCallback onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.controlGrey,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: Row(
        children: [
          const AppLogoTopLeft(useHero: false),

          const Spacer(),

          SizedBox(
            height: 36,
            child: OutlinedButton(
              onPressed: onExit,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.border, width: 1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'Выход',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Колокольчик + бейдж
          SizedBox(
            width: 40,
            height: 40,
            child: InkResponse(
              onTap: onNotificationsTap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.notifications_none, color: Colors.black87),
                  if (unreadCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          unreadCount.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceGrey,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFFE6D9FF),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Фамилия Имя Отчество', style: TextStyle(fontSize: 14, color: Colors.black87)),
                SizedBox(height: 4),
                Text('Должность', style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // UI-only: редактирование аватара/ФИО позже
            },
            icon: const Icon(Icons.edit, size: 20),
          ),
        ],
      ),
    );
  }
}

class _EmailCompanyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceGrey,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Почта', style: TextStyle(fontSize: 12, color: Colors.black87)),
                SizedBox(height: 2),
                Text('pochta@mail.ru', style: TextStyle(fontSize: 12, color: Colors.black54)),
                SizedBox(height: 10),
                Text('Компания', style: TextStyle(fontSize: 12, color: Colors.black87)),
                SizedBox(height: 2),
                Text('ООО “Офис”', style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // UI-only: редактирование данных позже
            },
            icon: const Icon(Icons.edit, size: 20),
          ),
        ],
      ),
    );
  }
}

class _PassCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceGrey,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.controlGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.qr_code, color: Colors.black87),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Пропуск для\nсотрудника', style: TextStyle(fontSize: 14, color: Colors.black87)),
                SizedBox(height: 6),
                Text('Парковочное место: №31', style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
          SizedBox(
            height: 36,
            child: OutlinedButton(
              onPressed: () {
                // UI-only: открыть модалку QR позже
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.border, width: 1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Показать', style: TextStyle(color: Colors.black87)),
            ),
          ),
        ],
      ),
    );
  }
}

class _FiltersGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget pill(String text) {
      return SizedBox(
        height: 34,
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.border, width: 1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.black87)),
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: pill('Все аренды')),
            const SizedBox(width: 12),
            Expanded(child: pill('Переговорные')),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: pill('Коворкинг')),
            const SizedBox(width: 12),
            Expanded(child: pill('Офис')),
          ],
        ),
      ],
    );
  }
}
