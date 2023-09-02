import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_app/app/presentation/logic/app_cubit.dart';
import 'package:search_app/app/presentation/screens/loading_screen.dart';
import 'package:search_app/app/presentation/widgets/app_repository_provider.dart';
import 'package:search_app/common/theme/app_theme.dart';

class SearchApp extends StatelessWidget {
  const SearchApp({super.key});

  @override
  Widget build(BuildContext context) {

    return AppRepositoryProvider(
      child: BlocProvider(
        create: (_) => AppCubit()..initLocalSettings(),
        child: MaterialApp(
          title: 'Search App',
          debugShowCheckedModeBanner: false,
          theme: AppThemeManager.getMainThemeData(),
          home: const LoadingScreen(),
        ),
      ),
    );
  }
}
