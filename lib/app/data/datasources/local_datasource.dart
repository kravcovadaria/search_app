import 'package:hive_flutter/hive_flutter.dart';
import 'package:search_app/app/data/models/github_repo.dart';

class LocalDatasource {
  Future<List<GithubRepo>> getFavourites() async {
    Box<GithubRepo> favs = await Hive.openBox<GithubRepo>('favourites');
    return List<GithubRepo>.from(favs.values);
  }

  Future<List<GithubRepo>> getHistory() async {
    Box<GithubRepo> favs = await Hive.openBox<GithubRepo>('history');
    return List<GithubRepo>.from(favs.values);
  }

  Future<void> updateHistory(List<GithubRepo> repos) async {
    Box<GithubRepo> history = await Hive.openBox<GithubRepo>('history');
    await history.clear();
    await history.addAll(repos);
  }

  Future<void> addToFav(GithubRepo repo) async {
    Box<GithubRepo> favs = await Hive.openBox<GithubRepo>('favourites');
    favs.put(repo.url, repo..favourite = true);
  }

  Future<void> removeFromFav(GithubRepo repo) async {
    Box<GithubRepo> favs = await Hive.openBox<GithubRepo>('favourites');
    favs.delete(repo.url);
  }

  Future<GithubRepo> toggleFavs(GithubRepo repo) async {
    Box<GithubRepo> favs = await Hive.openBox<GithubRepo>('favourites');
    if (favs.containsKey(repo.url)) {
      favs.delete(repo.url);
      repo.favourite = false;
    } else {
      repo.favourite = true;
      favs.put(repo.url, repo);
    }
    return repo;
  }
}
