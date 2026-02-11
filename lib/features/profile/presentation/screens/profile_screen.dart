import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wordpice/core/widgets/app_header.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';
import 'package:wordpice/features/profile/presentation/widgets/bottom_nav_carousel.dart';
import 'package:wordpice/features/profile/presentation/widgets/qr_modal.dart';
import 'package:wordpice/features/profile/presentation/widgets/segment_carousel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _notificationCount = 0;
  int _selectedBottomIndex = 3;

  bool _hasActiveRentals = false;

  final List<String> _segments = const [
    'Активные аренды',
    'Избранное',
    'История аренды',
    'Заявки',
  ];

  int _segmentIndex = 0;

  final List<String> _historyFilters = const [
    'Все аренды',
    'Переговорные',
    'Коворкинг',
    'Офис',
  ];

  int _historyFilterIndex = 0;

  Timer? _qrTimer;
  DateTime _qrValidUntil = DateTime.now().add(const Duration(hours: 2));

  @override
  void initState() {
    super.initState();
    _startQrTimer();
  }

  void _startQrTimer() {
    _qrTimer?.cancel();
    _qrTimer = Timer.periodic(const Duration(hours: 2), (_) {
      if (!mounted) return;
      setState(() {
        _qrValidUntil = DateTime.now().add(const Duration(hours: 2));
      });
    });
  }

  @override
  void dispose() {
    _qrTimer?.cancel();
    super.dispose();
  }

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AuthScreen()),
      (route) => false,
    );
  }

  Future<void> _onShowQr() async {
    if (!_hasActiveRentals) {
      await QrModal.showNoActiveRentals(context);
      return;
    }

    await QrModal.showQr(
      context,
      validUntilText: 'Ваш qr-код действует до 12.12.2026',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavCarousel(
        selectedIndex: _selectedBottomIndex,
        onChanged: (i) {
          setState(() => _selectedBottomIndex = i);

          if (i == 0) {
            // Аренды
            Navigator.of(context).pushReplacementNamed('/rentals');
          }

          if (i == 1 || i == 2) {
            // UI-only заглушки
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Раздел в разработке')),
            );
          }
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              notificationCount: _notificationCount,
              onLogout: _logout,
              onNotifications: () {},
            ),

            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                    child: Column(
                      children: [

                        /// ===== ФИО =====
                        _ProfileCard(
                          height: 76,
                          child: Row(
                            children: const [
                              CircleAvatar(radius: 23),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Фамилия Имя Отчество\nДолжность',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Icon(Icons.edit, size: 18),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        /// ===== Контакты =====
                        _ProfileCard(
                          height: 100,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Почта\npochta@mail.ru'),
                              SizedBox(height: 8),
                              Text('Компания\nООО "Офис"'),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        /// ===== QR блок =====
                        _ProfileCard(
                          height: 80,
                          child: Row(
                            children: [
                              const Icon(Icons.qr_code_2, size: 28),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text('Пропуск для сотрудника\nПарковка №31'),
                              ),
                              OutlinedButton(
                                onPressed: _onShowQr,
                                child: const Text('Показать'),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// ===== Верхняя фильтрация =====
                        SegmentCarousel(
                          items: _segments,
                          initialIndex: _segmentIndex,
                          onChanged: (i) => setState(() => _segmentIndex = i),
                        ),

                        const SizedBox(height: 16),

                        /// ===== История фильтры =====
                        Column(
                          children: [
                            Row(
                              children: [
                                _HistoryFilterButton(
                                  text: 'Все аренды',
                                  isSelected: _historyFilterIndex == 0,
                                  onTap: () => setState(() => _historyFilterIndex = 0),
                                ),
                                const SizedBox(width: 12),
                                _HistoryFilterButton(
                                  text: 'Переговорные',
                                  isSelected: _historyFilterIndex == 1,
                                  onTap: () => setState(() => _historyFilterIndex = 1),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _HistoryFilterButton(
                                  text: 'Коворкинг',
                                  isSelected: _historyFilterIndex == 2,
                                  onTap: () => setState(() => _historyFilterIndex = 2),
                                ),
                                const SizedBox(width: 12),
                                _HistoryFilterButton(
                                  text: 'Офис',
                                  isSelected: _historyFilterIndex == 3,
                                  onTap: () => setState(() => _historyFilterIndex = 3),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        /// ===== Заглушка истории =====
                        const Text(
                          'У вас нет истории аренд',
                          style: TextStyle(fontSize: 14),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Карточка профиля
class _ProfileCard extends StatelessWidget {
  final double height;
  final Widget child;

  const _ProfileCard({
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

/// Кнопка фильтра истории
class _HistoryFilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _HistoryFilterButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 38,
        child: OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            backgroundColor:
                isSelected ? Colors.grey.shade200 : Colors.transparent,
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
