import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_app/app/data/datasources/local_datasource.dart';
import 'package:search_app/common/theme/app_icons.dart';
import 'package:search_app/common/widgets/app_bar.dart';
import 'package:search_app/common/widgets/search_card.dart';
import 'package:search_app/flow/search/domain/repositories/search_repository.dart';
import 'package:search_app/flow/search/presentation/logic/search/search_cubit.dart';
import 'package:search_app/flow/search/presentation/screens/favs_screen.dart';
import 'package:search_app/flow/search/presentation/widgets/search_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(
        SearchRepository(LocalDatasource()),
      )..clear(),
      child: const SearchScreenView(),
    );
  }
}

class SearchScreenView extends StatelessWidget {
  const SearchScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppNavBar(
          title: 'Github repos list',
          rightIcon: AppIcons.favorite_active,
          rightButtonTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const FavouritesScreen();
              }),
            ).then(
              (_) => context.read<SearchCubit>().markFavourites(),
            );
          },
        ),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: [
                if (state.searchString.isEmpty &&
                    state.repos.isEmpty &&
                    state.status == SearchStatus.success)
                  Text(
                    'You have empty history.'
                    '\nClick on search to start journey!',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  )
                else if (state.repos.isEmpty &&
                    state.status == SearchStatus.success)
                  Text(
                    'Nothing was find for your search.'
                    '\nPlease check the spelling',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.r,
                    vertical: 24.r,
                  ),
                  children: [
                    SearchField(
                      text: state.searchString,
                      onSubmitted: (String value) =>
                          _submitSearchString(context, value),
                      onPrefixPressed: (String value) =>
                          _submitSearchString(context, value),
                      onSuffixPressed: (String value) =>
                          _submitSearchString(context, ''),
                    ),
                    if (state.status == SearchStatus.loading)
                      Padding(
                        padding: EdgeInsets.only(top: 24.r),
                        child: CupertinoActivityIndicator(radius: 11.r),
                      ),
                    if (state.status == SearchStatus.success)
                      Padding(
                        padding: EdgeInsets.only(
                          top: 16.r,
                          bottom: 12.r,
                        ),
                        child: Text(
                          state.searchString.isEmpty
                              ? 'Search history'
                              : 'What we found',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    if (state.status == SearchStatus.success)
                      for (final item in state.repos)
                        Padding(
                          padding: EdgeInsets.only(top: 8.r),
                          child: SearchCard(
                            repo: item,
                            onFavTap: () =>
                                context.read<SearchCubit>().toggleFavs(item),
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

  void _submitSearchString(BuildContext context, String value) {
    SearchCubit cubit = context.read<SearchCubit>();
    if (value.isEmpty) {
      cubit.clear();
    } else {
      cubit.fetch(value);
    }
  }
}
