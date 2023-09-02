import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_app/app/presentation/logic/app_cubit.dart';
import 'package:search_app/app/presentation/logic/app_state.dart';
import 'package:search_app/common/widgets/app_loading_indicator.dart';
import 'package:search_app/flow/search/presentation/screens/search_screen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const _LoadingView(),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listenWhen: (prev, cur) => prev.status != cur.status,
      listener: (BuildContext context, AppState state) =>
          Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Search app',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.r),
            const AppLoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
