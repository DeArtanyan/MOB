import 'package:flutter/material.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/widgets/layout/app_constrained_scroll_view.dart';
import 'package:wordpice/core/widgets/layout/app_shell.dart';
import 'package:wordpice/features/profile/presentation/screens/change_password_screen.dart';
import 'package:wordpice/features/profile/presentation/widgets/cards/edit_profile_cards.dart';
import 'package:wordpice/features/profile/presentation/widgets/delete_account_modal.dart';
import 'package:wordpice/features/profile/presentation/widgets/styles/edit_profile_styles.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const int _tabIndex = 3;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  late final List<TextEditingController> _controllers = <TextEditingController>[
    _nameController,
    _middleNameController,
    _lastNameController,
    _emailController,
    _positionController,
    _companyController,
  ];

  late final List<EditProfileField> _editorFields = <EditProfileField>[
    EditProfileField(label: 'Имя', controller: _nameController),
    EditProfileField(label: 'Отчество', controller: _middleNameController),
    EditProfileField(label: 'Фамилия', controller: _lastNameController),
    EditProfileField(label: 'Эл.почта', controller: _emailController),
    EditProfileField(label: 'Должность', controller: _positionController),
    EditProfileField(label: 'Компания', controller: _companyController),
  ];

  void _onBottomChanged(int index) {
    if (index == _tabIndex) {
      Navigator.of(context).pop();
      return;
    }
    AppTabNavigator.goToTab(context, index);
  }

  void _closeScreen() {
    Navigator.of(context).pop();
  }

  void _changePassword() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
    );
  }

  Future<void> _showDeleteAccountDialog() => DeleteAccountModal.show(context);

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _tabIndex,
      onBottomChanged: _onBottomChanged,
      body: AppConstrainedScrollView(
        maxWidth: EditProfileStyles.maxContentWidth,
        padding: EditProfileStyles.screenPadding,
        child: Column(
          children: [
            const EditProfilePreviewCard(),
            const SizedBox(height: 30),
            _EditProfileEditorSection(
              fields: _editorFields,
              onChangePasswordTap: _changePassword,
              onDeleteTap: _showDeleteAccountDialog,
            ),
            const SizedBox(height: 14),
            _EditProfileActions(
              onSaveTap: _closeScreen,
              onExitTap: _closeScreen,
            ),
          ],
        ),
      ),
    );
  }
}

class _EditProfileEditorSection extends StatelessWidget {
  const _EditProfileEditorSection({
    required this.fields,
    required this.onChangePasswordTap,
    required this.onDeleteTap,
  });

  final List<EditProfileField> fields;
  final VoidCallback onChangePasswordTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: EditProfileStyles.editorWidth,
      child: EditProfileEditorCard(
        fields: fields,
        onChangePasswordTap: onChangePasswordTap,
        onDeleteTap: onDeleteTap,
      ),
    );
  }
}

class _EditProfileActions extends StatelessWidget {
  const _EditProfileActions({required this.onSaveTap, required this.onExitTap});

  final VoidCallback onSaveTap;
  final VoidCallback onExitTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: EditProfileStyles.saveButtonWidth,
          height: EditProfileStyles.saveButtonHeight,
          child: OutlinedButton(
            onPressed: onSaveTap,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: EditProfileStyles.saveButtonRadius,
              ),
            ),
            child: const Text(
              'Сохранить',
              style: EditProfileStyles.primaryButtonTextStyle,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: onExitTap,
          child: const Text(
            'Выйти без сохранения',
            style: EditProfileStyles.exitTextStyle,
          ),
        ),
      ],
    );
  }
}
