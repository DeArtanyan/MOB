import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/widgets/buttons/app_outlined_icon_button.dart';
import 'package:wordpice/core/widgets/navigation/app_bottom_nav_bar.dart';
import 'package:wordpice/core/widgets/navigation/app_header.dart';
import 'package:wordpice/core/widgets/states/app_empty_state_text.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';
import 'package:wordpice/features/notifications/data/mock/notifications_mock_data.dart';
import 'package:wordpice/features/notifications/presentation/widgets/buttons/notification_read_action.dart';
import 'package:wordpice/features/notifications/presentation/widgets/cards/notification_card.dart';
import 'package:wordpice/features/notifications/presentation/widgets/styles/notification_styles.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key, required this.selectedBottomIndex});

  final int selectedBottomIndex;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<bool> _readStates;

  @override
  void initState() {
    super.initState();
    _readStates = List<bool>.filled(notificationsMockData.length, false);
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const AuthScreen()),
      (_) => false,
    );
  }

  void _onBottomChanged(int index) {
    AppTabNavigator.goToTab(context, index);
  }

  bool get _areAllRead =>
      _readStates.isNotEmpty && _readStates.every((value) => value);

  void _setAllRead(bool value) {
    setState(() {
      _readStates = List<bool>.filled(_readStates.length, value);
    });
  }

  void _setReadAt(int index, bool value) {
    setState(() {
      _readStates[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppHeader(
              onLogout: _logout,
              onNotifications: () {},
              notificationCount: 0,
              showActions: false,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 22, 32, 24),
              child: _NotificationsBody(
                areAllRead: _areAllRead,
                readStates: _readStates,
                onAllReadChanged: _setAllRead,
                onReadChanged: _setReadAt,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: AppBottomNavBar(
          selectedIndex: widget.selectedBottomIndex,
          onChanged: _onBottomChanged,
        ),
      ),
    );
  }
}

class _NotificationsBody extends StatelessWidget {
  const _NotificationsBody({
    required this.areAllRead,
    required this.readStates,
    required this.onAllReadChanged,
    required this.onReadChanged,
  });

  final bool areAllRead;
  final List<bool> readStates;
  final ValueChanged<bool> onAllReadChanged;
  final void Function(int index, bool value) onReadChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _NotificationsTitleBar(),
        const SizedBox(height: 22),
        Center(
          child: NotificationReadAction(
            label: 'Прочитать все уведомления',
            value: areAllRead,
            onChanged: onAllReadChanged,
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: _NotificationsList(
            readStates: readStates,
            onReadChanged: onReadChanged,
          ),
        ),
      ],
    );
  }
}

class _NotificationsTitleBar extends StatelessWidget {
  const _NotificationsTitleBar();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppOutlinedIconButton(
            icon: Icons.arrow_back_ios_new,
            iconSize: 14,
            size: 30,
            radius: 10,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        const Text('Уведомления', style: NotificationStyles.titleText),
      ],
    );
  }
}

class _NotificationsList extends StatelessWidget {
  const _NotificationsList({
    required this.readStates,
    required this.onReadChanged,
  });

  final List<bool> readStates;
  final void Function(int index, bool value) onReadChanged;

  @override
  Widget build(BuildContext context) {
    if (notificationsMockData.isEmpty) {
      return const AppEmptyStateText(
        text: 'Уведомлений нет',
        style: NotificationStyles.emptyStateText,
      );
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: notificationsMockData.length,
      separatorBuilder: (_, _) => const SizedBox(height: 46),
      itemBuilder: (_, i) => NotificationCard(
        item: notificationsMockData[i],
        isRead: readStates[i],
        onReadChanged: (value) => onReadChanged(i, value),
      ),
    );
  }
}
