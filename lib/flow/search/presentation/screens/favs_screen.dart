import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_app/app/data/datasources/local_datasource.dart';
import 'package:search_app/common/theme/app_icons.dart';
import 'package:search_app/common/widgets/app_bar.dart';
import 'package:search_app/common/widgets/search_card.dart';
import 'package:search_app/flow/search/domain/repositories/search_repository.dart';
import 'package:search_app/flow/search/presentation/logic/favs/favs_cubit.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouritesCubit(
        SearchRepository(LocalDatasource()),
      )..fetch(),
      child: const FavouritesScreenView(),
    );
  }
}

class FavouritesScreenView extends StatelessWidget {
  const FavouritesScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavBar(
        title: 'Favorite repos list',
        leftIcon: AppIcons.left,
        leftButtonTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: SafeArea(
        child: BlocBuilder<FavouritesCubit, FavouritesState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: [
                if (state.repos.isEmpty &&
                    state.status == FavouritesStatus.success)
                  Text(
                    'You have no favorites.'
                    '\nClick on star while searching to add first favorite',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.r,
                    vertical: 24.r,
                  ),
                  children: [
                    if (state.status == FavouritesStatus.loading)
                      Padding(
                        padding: EdgeInsets.only(top: 24.r),
                        child: CupertinoActivityIndicator(radius: 11.r),
                      ),
                    if (state.status == FavouritesStatus.success)
                      for (final item in state.repos)
                        Padding(
                          padding: EdgeInsets.only(top: 8.r),
                          child: SearchCard(
                            repo: item,
                            onFavTap: () => context
                                .read<FavouritesCubit>()
                                .toggleFavs(item),
                          ),
                        ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
