import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';
import 'package:wordpice/core/widgets/buttons/app_action_menu_button.dart';
import 'package:wordpice/core/widgets/layout/app_constrained_scroll_view.dart';
import 'package:wordpice/core/widgets/layout/app_shell.dart';
import 'package:wordpice/features/rentals/presentation/screens/coworking_rental_screen.dart';
import 'package:wordpice/features/rentals/presentation/screens/meeting_room_rental_screen.dart';
import 'package:wordpice/features/rentals/presentation/screens/office_rental_screen.dart';

const _kTitleStyle = AppTextStyles.unboundedRegular22;
const _kActionTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w400);

class RentalsScreen extends StatefulWidget {
  const RentalsScreen({super.key});

  @override
  State<RentalsScreen> createState() => _RentalsScreenState();
}

class _RentalsScreenState extends State<RentalsScreen> {
  static const int _tabIndex = 0;
  static const double _contentWidth = 320;

  int _selectedBottomIndex = _tabIndex;

  void _onBottomChanged(int index) {
    if (index == _tabIndex) return;
    setState(() => _selectedBottomIndex = index);
    AppTabNavigator.goToTab(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: AppConstrainedScrollView(
        maxWidth: _contentWidth,
        centerVertically: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Аренды',
                style: _kTitleStyle,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 42),
            AppActionMenuButton(
              text: 'Аренда переговорной',
              textStyle: _kActionTextStyle,
              backgroundColor: AppColors.formSurface,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MeetingRoomRentalScreen(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            AppActionMenuButton(
              text: 'Аренда офиса',
              textStyle: _kActionTextStyle,
              backgroundColor: AppColors.formSurface,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OfficeRentalScreen()),
              ),
            ),
            const SizedBox(height: 30),
            AppActionMenuButton(
              text: 'Аренда коворкинга',
              textStyle: _kActionTextStyle,
              backgroundColor: AppColors.formSurface,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CoworkingRentalScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
