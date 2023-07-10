import 'dart:io';

class AppConfig {
  static final String appName = "MSQ Wallet";
  static final String packageName = "com.apptester.app";
  static final String defaultLanguage = "en";
  static final String defaultTheme = "dark";
  static const String currency = "\$";
  static String admobKey = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';
  static final Map<String, String> languagesSupported = {
    'en': "English",
    'ar': "عربى",
    'pt': "Portugal",
    'fr': "Français",
    'id': "Bahasa Indonesia",
    'es': "Español",
    'it': "italiano",
    'tr': "Türk",
    'sw': "Kiswahili",
  };
}
