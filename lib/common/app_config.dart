import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static final _singleton = AppConfig._();
  static AppConfig get shared => _singleton;

  AppConfig._();

  static const appName = 'Search app';

  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  Future<void> loadDev() async {
    await dotenv.load(fileName: '.env.dev');
  }

  Future<void> loadProd() async {
    await dotenv.load(fileName: '.env.prod');
  }
}
