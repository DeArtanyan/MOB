import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/layout/app_shell.dart';
import 'package:wordpice/features/archive/data/mock/archive_mock_data.dart';
import 'package:wordpice/features/archive/presentation/widgets/cards/archive_card.dart';
import 'package:wordpice/features/archive/presentation/widgets/states/archive_empty_state.dart';
import 'package:wordpice/features/archive/presentation/widgets/styles/archive_styles.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  static const int _tabIndex = 6;
  int _selectedBottomIndex = _tabIndex;

  void _onBottomChanged(int index) {
    if (index == _tabIndex) return;
    setState(() => _selectedBottomIndex = index);
    AppTabNavigator.goToTab(context, index);
  }

  @override
  Widget build(BuildContext context) {
    final items = archiveMockData;

    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 28),
        child: items.isEmpty
            ? const ArchiveEmptyState()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final item in items) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 6),
                      child: Text(item.dateText, style: ArchiveStyles.dateText),
                    ),
                    ArchiveCard(item: item),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
      ),
    );
  }
}
