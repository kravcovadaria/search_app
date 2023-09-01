import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_app/app/presentation/logic/app_cubit.dart';
import 'package:search_app/app/presentation/logic/app_state.dart';
import 'package:search_app/flow/search/presentation/screens/search_screen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _LoadingView(),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listenWhen: (prev, cur) => prev.status != cur.status,
      listener: (BuildContext context, AppState state) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchScreen(),
          ),
        );
      },
      child: Center(
        child: Column(
          children: [
            const Text(
              'Search app',
            ),
            SizedBox(
              height: 16.r,
            ),
            CupertinoActivityIndicator(radius: 11.r),
          ],
        ),
      ),
    );
  }
}
