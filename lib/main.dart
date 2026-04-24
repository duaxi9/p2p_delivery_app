import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:p2p_delivery_app/screens/home_screen.dart';

void main() {
  runApp(const LinkAirApp());
}

class LinkAirApp extends StatefulWidget {
  const LinkAirApp({super.key});

  @override
  State<LinkAirApp> createState() => _LinkAirAppState();
}

class _LinkAirAppState extends State<LinkAirApp> {
  bool isDarkMode = false;
  Locale _locale = const Locale('en');

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

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
      debugShowCheckedModeBanner: false,
      locale: _locale,

      // ✅ FIXED (no AppLocalizations errors)
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],

      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFEDEDEC),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),

      home: HomeScreen(
        isDarkMode: isDarkMode,
        onThemeChanged: toggleTheme,
        onLanguageChanged: changeLanguage,
        selectedLanguage: selectedLanguage,
      ),
    );
  }
}