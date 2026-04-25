import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:my_app/screens/welcome_screens.dart';

void main() {
  runApp(const LinkAirApp());
}

class LinkAirApp extends StatefulWidget {
  const LinkAirApp({super.key});

  @override
  State<LinkAirApp> createState() => _LinkAirAppState();
}

class _LinkAirAppState extends State<LinkAirApp> {
  Locale _locale = const Locale('en');

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  String get selectedLanguage {
    switch (_locale.languageCode) {
      case 'fr':
        return 'Français';
      case 'ar':
        return 'العربية';
      default:
        return 'English';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LinkAir',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
      ),

      locale: _locale,

      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
        Locale('ar'),
      ],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      home: const WelcomeScreens(),
    );
  }
}