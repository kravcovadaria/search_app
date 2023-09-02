import 'package:hive_flutter/hive_flutter.dart';
import 'package:search_app/flow/search/data/models/github_repo.dart';

abstract class IHistoryDatasource {
  Future<List<GithubRepo>> getHistory();
  Future<void> updateHistory(List<GithubRepo> repos);
}

class HistoryDatasource implements IHistoryDatasource {
  @override
  Future<List<GithubRepo>> getHistory() async {
    Box<GithubRepo> favs = await Hive.openBox<GithubRepo>('history');
    return List<GithubRepo>.from(favs.values);
  }

  @override
  Future<void> updateHistory(List<GithubRepo> repos) async {
    Box<GithubRepo> history = await Hive.openBox<GithubRepo>('history');
    await history.clear();
    await history.addAll(repos);
  }
}
