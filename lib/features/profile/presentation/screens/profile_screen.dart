import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/layout/app_constrained_scroll_view.dart';
import 'package:wordpice/core/widgets/layout/app_shell.dart';
import 'package:wordpice/features/profile/data/mock/profile_pass_mock_data.dart';
import 'package:wordpice/features/profile/presentation/models/profile_activity_filter.dart';
import 'package:wordpice/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:wordpice/features/profile/presentation/widgets/cards/profile_info_card.dart';
import 'package:wordpice/features/profile/presentation/widgets/cards/profile_pass_card.dart';
import 'package:wordpice/features/profile/presentation/widgets/cards/profile_user_card.dart';
import 'package:wordpice/features/profile/presentation/widgets/profile_rental_type_filters.dart';
import 'package:wordpice/features/profile/presentation/widgets/qr_modal.dart';
import 'package:wordpice/features/profile/presentation/widgets/sections/profile_activity_section.dart';
import 'package:wordpice/features/profile/presentation/widgets/segment_carousel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const int _tabIndex = 3;
  static const double _contentWidth = 360;
  static const double _narrowCardWidth = 340;
  static const List<ProfileActivityFilter> _activityFilters = [
    ProfileActivityFilter.activeRentals,
    ProfileActivityFilter.favorites,
    ProfileActivityFilter.rentalHistory,
    ProfileActivityFilter.requests,
  ];
  static const List<String> _carouselItems = [
    'Активные аренды',
    'Избранное',
    'История аренды',
    'Заявки',
  ];

  int _selectedBottomIndex = _tabIndex;
  int _carouselIndex = 0;

  void _openEditScreen() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const EditProfileScreen()));
  }

  void _onBottomChanged(int index) {
    if (index == _tabIndex) return;
    setState(() => _selectedBottomIndex = index);
    AppTabNavigator.goToTab(context, index);
  }

  ProfileActivityFilter get _selectedActivityFilter {
    if (_carouselIndex < 0 || _carouselIndex >= _activityFilters.length) {
      return ProfileActivityFilter.rentalHistory;
    }
    return _activityFilters[_carouselIndex];
  }

  void _showPassQr() {
    if (!profilePassMockData.hasActivePass) return;
    QrModal.showQr(
      context,
      validUntilText: profilePassMockData.validUntilText!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: AppConstrainedScrollView(
        maxWidth: _contentWidth,
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 28),
        child: _ProfileContent(
          onEditTap: _openEditScreen,
          carouselItems: _carouselItems,
          carouselIndex: _carouselIndex,
          onCarouselChanged: (index) => setState(() => _carouselIndex = index),
          selectedActivityFilter: _selectedActivityFilter,
          onShowPassQr: _showPassQr,
        ),
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({
    required this.onEditTap,
    required this.carouselItems,
    required this.carouselIndex,
    required this.onCarouselChanged,
    required this.selectedActivityFilter,
    required this.onShowPassQr,
  });

  final VoidCallback onEditTap;
  final List<String> carouselItems;
  final int carouselIndex;
  final ValueChanged<int> onCarouselChanged;
  final ProfileActivityFilter selectedActivityFilter;
  final VoidCallback onShowPassQr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileUserCard(onEditTap: onEditTap),
        const SizedBox(height: 30),
        _NarrowCard(child: ProfileInfoCard(onEditTap: onEditTap)),
        const SizedBox(height: 30),
        _NarrowCard(
          child: ProfilePassCard(
            pass: profilePassMockData,
            onShowPressed: onShowPassQr,
          ),
        ),
        const SizedBox(height: 30),
        _ProfileActivityControls(
          items: carouselItems,
          carouselIndex: carouselIndex,
          onChanged: onCarouselChanged,
        ),
        const SizedBox(height: 30),
        _NarrowCard(
          child: ProfileActivitySection(filter: selectedActivityFilter),
        ),
      ],
    );
  }
}

class _ProfileActivityControls extends StatelessWidget {
  const _ProfileActivityControls({
    required this.items,
    required this.carouselIndex,
    required this.onChanged,
  });

  final List<String> items;
  final int carouselIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _NarrowCard(
          child: Center(
            child: SegmentCarousel(
              items: items,
              initialIndex: carouselIndex,
              onChanged: onChanged,
            ),
          ),
        ),
        const SizedBox(height: 26),
        const _NarrowCard(child: ProfileRentalTypeFilters()),
      ],
    );
  }
}

class _NarrowCard extends StatelessWidget {
  const _NarrowCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: _ProfileScreenState._narrowCardWidth, child: child);
  }
}
