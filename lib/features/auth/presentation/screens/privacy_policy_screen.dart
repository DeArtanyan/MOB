import 'package:flutter/material.dart';
import 'package:wordpice/core/theme/app_text_styles.dart';


class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  static const String _policyText = '''
Настоящая Политика конфиденциальности определяет порядок обработки и защиты персональных данных пользователей мобильного приложения.

1. Общие положения  
Использование приложения означает согласие пользователя с настоящей Политикой конфиденциальности и условиями обработки его персональных данных.

2. Персональные данные  
В рамках работы приложения могут запрашиваться следующие данные:
— имя пользователя  
— фамилия  
— отчество  
— адрес электронной почты  

Данные используются исключительно в целях предоставления функционала приложения.

3. Цели сбора информации  
Персональные данные пользователя используются для:
— идентификации пользователя в системе  
— предоставления доступа к функционалу  
— обратной связи с пользователем  

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
            // Верхняя панель фиксированная
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                    style: IconButton.styleFrom(
                      side: const BorderSide(color: Colors.black87),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(28, 28),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Политика конфиденциальности',
                    style: AppTextStyles.header20,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      _policyText,
                      style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
