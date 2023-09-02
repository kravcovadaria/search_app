import 'package:hive_flutter/hive_flutter.dart';
import 'package:search_app/flow/search/data/models/github_repo.dart';

abstract class IFavouritesDatasource {
  Future<List<GithubRepo>> getFavourites();
  Future<void> addToFav(GithubRepo repo);
  Future<void> removeFromFav(GithubRepo repo);
  Future<GithubRepo> toggleFavs(GithubRepo repo);
}

class FavouritesDatasource implements IFavouritesDatasource {
  @override
  Future<List<GithubRepo>> getFavourites() async {
    Box<GithubRepo> favs = await Hive.openBox<GithubRepo>('favourites');
    return List<GithubRepo>.from(favs.values);
  }

  @override
  Future<void> addToFav(GithubRepo repo) async {
    Box<GithubRepo> favs = await Hive.openBox<GithubRepo>('favourites');
    favs.put(repo.url, repo..favourite = true);
  }

  @override
  Future<void> removeFromFav(GithubRepo repo) async {
    Box<GithubRepo> favs = await Hive.openBox<GithubRepo>('favourites');
    favs.delete(repo.url);
  }

  @override
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
