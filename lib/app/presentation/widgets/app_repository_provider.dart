import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_app/flow/search/data/datasources/favorites_datasource.dart';
import 'package:search_app/flow/search/data/datasources/history_datasource.dart';
import 'package:search_app/flow/search/data/datasources/search_datasource.dart';
import 'package:search_app/flow/search/domain/repositories/favourites_repository.dart';
import 'package:search_app/flow/search/domain/repositories/search_repository.dart';
import 'package:search_app/common/api_manager.dart';

class AppRepositoryProvider extends StatelessWidget {
  const AppRepositoryProvider({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => SearchRepository(
            favouritesDatasource: FavouritesDatasource(),
            historyDatasource: HistoryDatasource(),
            searchDataSource: ISearchDataSource(ApiManager().getDio()),
          ),
        ),
        RepositoryProvider(
          create: (_) => FavouritesRepository(FavouritesDatasource()),
        )
      ],
      child: child,
    );
  }
}