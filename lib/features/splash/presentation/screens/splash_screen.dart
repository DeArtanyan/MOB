import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wordpice/features/auth/presentation/screens/auth_screen.dart';
import 'package:wordpice/features/splash/presentation/widgets/splash_logo.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _interval = Duration(seconds: 2);

  final List<String> _allPhrases = const [
    'Вы красивы',
    'Всё получится',
    'Вы справитесь',
    'День удачный',
    'Мы рядом',
    'Смело вперёд',
    'Время действовать',
    'Дышите глубже',
  ];

  late final List<String> _selected3;
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _selected3 = _pick3RandomUnique(_allPhrases);

    _timer = Timer.periodic(_interval, (_) {
      if (!mounted) return;

      if (_index >= _selected3.length - 1) {
        _timer?.cancel();
        _goToAuth();
        return;
      }

      setState(() => _index++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<String> _pick3RandomUnique(List<String> source) {
    final copy = List<String>.from(source);
    copy.shuffle(Random());
    return copy.take(3).toList();
  }

  void _goToAuth() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1200),
        reverseTransitionDuration: const Duration(milliseconds: 1200),
        pageBuilder: (_, __, ___) => const AuthScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final phrase = _selected3[_index];

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: 'app_logo',
                child: const Material(
                  type: MaterialType.transparency,
                  child: SplashLogo(),
                ),
              ),
            ),
            Positioned(
              bottom: 28,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  child: Text(
                    phrase,
                    key: ValueKey(phrase),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
