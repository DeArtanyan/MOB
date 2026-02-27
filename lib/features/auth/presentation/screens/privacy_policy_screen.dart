import 'package:flutter/material.dart';
import 'package:wordpice/features/auth/presentation/widgets/auth_text_widgets.dart';
import 'package:wordpice/features/auth/presentation/widgets/privacy_policy_header.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const _policyText = '''
Настоящая Политика конфиденциальности определяет порядок обработки и защиты персональных данных пользователей мобильного приложения.

1. Общие положения
Использование приложения означает согласие пользователя с настоящей Политикой конфиденциальности и условиями обработки его персональных данных.

2. Персональные данные
В рамках работы приложения могут запрашиваться следующие данные:
- имя пользователя
- фамилия
- отчество
- адрес электронной почты

3. Цели сбора информации
Персональные данные пользователя используются для:
- идентификации пользователя в системе
- предоставления доступа к функционалу
- обратной связи с пользователем

4. Защита информации
Приложение принимает необходимые меры для защиты персональных данных пользователя от неправомерного доступа, изменения или уничтожения.

5. Передача данных третьим лицам
Персональные данные не передаются третьим лицам без согласия пользователя, за исключением случаев, предусмотренных законодательством.

6. Изменение политики
Разработчик имеет право вносить изменения в настоящую Политику конфиденциальности без предварительного уведомления пользователей.

7. Заключительные положения
Пользователь может в любой момент отозвать согласие на обработку персональных данных, прекратив использование приложения.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PrivacyPolicyHeader(onBack: () => Navigator.of(context).pop()),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
                child: const AuthPolicyBodyText(_policyText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
