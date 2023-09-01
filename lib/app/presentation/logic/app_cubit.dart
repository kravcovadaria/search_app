import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:search_app/app/data/models/github_repo.dart';
import 'package:search_app/app/presentation/logic/app_state.dart';
import 'package:search_app/common/app_config.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState.init());

  void initLocalSettings() async {
    try {
      await AppConfig.init();
      await Hive.initFlutter();
      Hive.registerAdapter(GithubRepoAdapter());
      if (!Hive.isBoxOpen('history')) {
        await Hive.openBox<GithubRepo>('history');
      }
      if (!Hive.isBoxOpen('favourites')) {
        await Hive.openBox<GithubRepo>('favourites');
      }
      emit(AppState(SettingsStates.ok));
    } catch (e) {
      emit(AppState(SettingsStates.error));
    }
  }
}
