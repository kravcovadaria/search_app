import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_app/common/theme/app_icons.dart';
import 'package:search_app/common/widgets/app_bar.dart';
import 'package:search_app/common/widgets/app_loading_indicator.dart';
import 'package:search_app/common/widgets/search_card.dart';
import 'package:search_app/flow/search/domain/repositories/favourites_repository.dart';
import 'package:search_app/flow/search/presentation/logic/favs/favs_cubit.dart';
import 'package:search_app/flow/search/presentation/widgets/message_builder.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouritesCubit(
        context.read<FavouritesRepository>(),
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
        leftButtonTap: Navigator.of(context).pop,
      ),
      body: SafeArea(
        child: BlocBuilder<FavouritesCubit, FavouritesState>(
          builder: (context, state) {
            return MessageBuilder(
              messageBuilder: () {
                if (state.repos.isEmpty &&
                    state.status == FavouritesStatus.success) {
                  return 'You have no favorites.\n'
                      'Click on star while searching to add first favorite';
                }
                return '';
              },
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.r,
                  vertical: 24.r,
                ),
                children: [
                  if (state.status == FavouritesStatus.loading)
                    const AppLoadingIndicator(),
                  if (state.status == FavouritesStatus.success)
                    for (final item in state.repos)
                      Padding(
                        padding: EdgeInsets.only(top: 8.r),
                        child: SearchCard(
                          repo: item,
                          onFavTap: () =>
                              context.read<FavouritesCubit>().toggleFavs(item),
                        ),
                      ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
