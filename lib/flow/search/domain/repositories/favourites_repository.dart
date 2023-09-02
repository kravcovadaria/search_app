import 'package:search_app/flow/search/data/datasources/favorites_datasource.dart';
import 'package:search_app/flow/search/data/models/github_repo.dart';

abstract class IFavouritesRepository {
  Future<List<GithubRepo>> getFavourites();
  Future<GithubRepo> toggleFavs(GithubRepo repo);
}

class FavouritesRepository implements IFavouritesRepository {
  FavouritesRepository(this.favouritesDatasource);

  final IFavouritesDatasource favouritesDatasource;

  @override
  Future<List<GithubRepo>> getFavourites() =>
      favouritesDatasource.getFavourites();

  @override
  Future<GithubRepo> toggleFavs(GithubRepo repo) =>
      favouritesDatasource.toggleFavs(repo);
}
