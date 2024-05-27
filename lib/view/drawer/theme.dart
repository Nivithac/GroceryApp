import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;
  bool _isDarkMode;

  ThemeNotifier(this._currentTheme, this._isDarkMode);

  ThemeData get currentTheme => _currentTheme;
  bool get isDarkMode => _isDarkMode;

  void switchTheme() {
    _isDarkMode = !_isDarkMode;
    _currentTheme = _isDarkMode ? darkTheme : lightTheme;
    notifyListeners();
  }
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  // Define other light theme properties
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  // Define other dark theme properties
);

class Appearance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Theme Toggle Example'),
        actions: [
          IconButton(
            icon: Icon(themeNotifier.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              themeNotifier.switchTheme();
            },
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: themeNotifier.isDarkMode ? DarkThemeContent() : LightThemeContent(),
      ),
    );
  }
}

class DarkThemeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1,
      duration: Duration(milliseconds: 500),
      child: Container(
        color: Colors.black,
        child: Center(
          child: Text(
            'Dark Theme Content',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class LightThemeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1,
      duration: Duration(milliseconds: 500),
      child: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            'Light Theme Content',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
