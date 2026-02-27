import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/profile/data/mock/profile_pass_mock_data.dart';
import 'package:wordpice/features/profile/presentation/models/profile_activity_filter.dart';
import 'package:wordpice/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:wordpice/features/profile/presentation/widgets/profile_activity_section.dart';
import 'package:wordpice/features/profile/presentation/widgets/profile_info_card.dart';
import 'package:wordpice/features/profile/presentation/widgets/profile_pass_card.dart';
import 'package:wordpice/features/profile/presentation/widgets/profile_rental_type_filters.dart';
import 'package:wordpice/features/profile/presentation/widgets/profile_user_card.dart';
import 'package:wordpice/features/profile/presentation/widgets/qr_modal.dart';
import 'package:wordpice/features/profile/presentation/widgets/segment_carousel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const int _tabIndex = 3;

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
    switch (_carouselIndex) {
      case 0:
        return ProfileActivityFilter.activeRentals;
      case 1:
        return ProfileActivityFilter.favorites;
      case 2:
        return ProfileActivityFilter.rentalHistory;
      case 3:
        return ProfileActivityFilter.requests;
      default:
        return ProfileActivityFilter.rentalHistory;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 28),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              children: [
                ProfileUserCard(onEditTap: _openEditScreen),
                const SizedBox(height: 30),
                _NarrowCard(child: ProfileInfoCard(onEditTap: _openEditScreen)),
                const SizedBox(height: 30),
                _NarrowCard(
                  child: ProfilePassCard(
                    pass: profilePassMockData,
                    onShowPressed: () {
                      if (!profilePassMockData.hasActivePass) return;
                      QrModal.showQr(
                        context,
                        validUntilText: profilePassMockData.validUntilText!,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                _NarrowCard(
                  child: Center(
                    child: SegmentCarousel(
                      items: const [
                        'Активные аренды',
                        'Избранное',
                        'История аренды',
                        'Заявки',
                      ],
                      initialIndex: _carouselIndex,
                      onChanged: (i) => setState(() => _carouselIndex = i),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const _NarrowCard(child: ProfileRentalTypeFilters()),
                const SizedBox(height: 30),
                _NarrowCard(
                  child: ProfileActivitySection(
                    filter: _selectedActivityFilter,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NarrowCard extends StatelessWidget {
  const _NarrowCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 340, child: child);
  }
}
