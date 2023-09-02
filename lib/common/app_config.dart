import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static final _singleton = AppConfig._();
  static AppConfig get shared => _singleton;

  AppConfig._();

  static const appName = 'Search app';

  static String get baseUrl => dotenv.env['BASE_URL']!;

  static int get searchSize => int.parse(dotenv.env['SEARCH_SIZE']!);

  static Future<void> init() => shared._loadEnv();

  Future<void> _loadEnv() async {
    await dotenv.load(fileName: '.env');
  }
}
