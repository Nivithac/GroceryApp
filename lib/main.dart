import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/drawer/dashboard.dart';
import 'package:provider/provider.dart';

import 'view/drawer/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(lightTheme, false),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: '',
          theme: themeNotifier.currentTheme,
          home: Dashboard(),
        );
      },
    );
  }
}
