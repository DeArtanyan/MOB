import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpice/app/navigation/app_tab_navigator.dart';
import 'package:wordpice/core/theme/app_colors.dart';
import 'package:wordpice/core/widgets/app_shell.dart';
import 'package:wordpice/features/profile/presentation/widgets/delete_account_modal.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const int _tabIndex = 3; // Профиль
  int _selectedBottomIndex = _tabIndex;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  void _onBottomChanged(int index) {
    if (index == _tabIndex) {
      Navigator.of(context).pop();
      return;
    }
    setState(() => _selectedBottomIndex = index);
    AppTabNavigator.goToTab(context, index);
  }

  void _save() {
    Navigator.of(context).pop();
  }

  void _exitWithoutSaving() {
    Navigator.of(context).pop();
  }

  Future<void> _showDeleteAccountDialog() => DeleteAccountModal.show(context);

  @override
  void dispose() {
    _nameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _positionController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedBottomIndex: _selectedBottomIndex,
      onBottomChanged: _onBottomChanged,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 18),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              children: [
                const _ProfilePreviewCard(),
                const SizedBox(height: 14),
                SizedBox(
                  width: 340,
                  child: _EditorCard(
                    nameController: _nameController,
                    middleNameController: _middleNameController,
                    lastNameController: _lastNameController,
                    emailController: _emailController,
                    positionController: _positionController,
                    companyController: _companyController,
                    onDeleteTap: _showDeleteAccountDialog,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: 200,
                  height: 44,
                  child: OutlinedButton(
                    onPressed: _save,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Сохранить',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _exitWithoutSaving,
                  child: const Text(
                    'Выйти без сохранения',
                    style: TextStyle(
                      fontSize: 34 / 2,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
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

class _ProfilePreviewCard extends StatelessWidget {
  const _ProfilePreviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.controlGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
              Positioned(
                top: -4,
                right: -4,
                child: SvgPicture.asset(
                  'assets/icons/edit-2.svg',
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Фамилия Имя Отчество',
                  style: TextStyle(
                    fontSize: 18 / 1.2,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Должность',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EditorCard extends StatelessWidget {
  const _EditorCard({
    required this.nameController,
    required this.middleNameController,
    required this.lastNameController,
    required this.emailController,
    required this.positionController,
    required this.companyController,
    required this.onDeleteTap,
  });

  final TextEditingController nameController;
  final TextEditingController middleNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController positionController;
  final TextEditingController companyController;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 410,
      decoration: BoxDecoration(
        color: AppColors.controlGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ОСНОВНОЕ',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            _LabeledInput(
              label: 'Имя',
              controller: nameController,
            ),
            const SizedBox(height: 8),
            _LabeledInput(
              label: 'Отчество',
              controller: middleNameController,
            ),
            const SizedBox(height: 8),
            _LabeledInput(
              label: 'Фамилия',
              controller: lastNameController,
            ),
            const SizedBox(height: 8),
            _LabeledInput(
              label: 'Эл.почта',
              controller: emailController,
            ),
            const SizedBox(height: 8),
            _LabeledInput(
              label: 'Должность',
              controller: positionController,
            ),
            const SizedBox(height: 8),
            _LabeledInput(
              label: 'Компания',
              controller: companyController,
            ),
            const SizedBox(height: 24),
            Center(
              child: SizedBox(
                width: 170,
                height: 44,
                child: OutlinedButton(
                  onPressed: onDeleteTap,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black87, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Удалить аккаунт',
                    style: TextStyle(
                      fontSize: 30 / 2,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
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

class _LabeledInput extends StatelessWidget {
  const _LabeledInput({
    required this.label,
    required this.controller,
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 3),
        Container(
          height: 28,
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black26, width: 1),
            ),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
            decoration: const InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
