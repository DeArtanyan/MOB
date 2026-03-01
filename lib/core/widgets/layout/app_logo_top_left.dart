import 'package:flutter/material.dart';
import 'package:wordpice/features/splash/presentation/widgets/splash_logo.dart';

class AppLogoTopLeft extends StatelessWidget {
  final bool useHero;

  const AppLogoTopLeft({
    super.key,
    this.useHero = false,
  });

  @override
  Widget build(BuildContext context) {
    final logo = const Material(
      type: MaterialType.transparency,
      child: SplashLogo(),
    );

    return Positioned(
      top: 16,
      left: 24,
      child: useHero ? Hero(tag: 'app_logo', child: logo) : logo,
    );
  }
}
