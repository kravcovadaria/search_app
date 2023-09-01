import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_app/app/presentation/logic/app_cubit.dart';
import 'package:search_app/app/presentation/screens/loading_screen.dart';
import 'package:search_app/common/theme/app_colors.dart';

class SearchApp extends StatelessWidget {
  const SearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppColors appColors = const AppColors();
    TextStyle mainStyle = TextStyle(
      fontFamily: 'Raleway',
      fontSize: 16.sp,
      height: 1.1875,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
    );
    TextStyle bodyStyle = TextStyle(
      fontFamily: 'Raleway',
      fontSize: 14.sp,
      height: 1.4286,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    );
    return BlocProvider(
      create: (_) => AppCubit()..initLocalSettings(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        color: appColors.main,
        theme: ThemeData(
          scaffoldBackgroundColor: appColors.main,
          primaryColor: appColors.primaryAccent,
          hoverColor: appColors.secondaryAccent,
          disabledColor: appColors.placeholderText,
          cardColor: appColors.layer,
          shadowColor: appColors.shadow,
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: appColors.spinner,
          ),
          useMaterial3: true,
          textTheme: TextTheme(
            bodyMedium: bodyStyle.copyWith(
              color: appColors.primaryText,
            ),
            bodySmall: bodyStyle.copyWith(
              color: appColors.layer,
            ),
            headlineMedium: mainStyle.copyWith(
              color: appColors.primaryText,
            ),
            displayMedium: mainStyle.copyWith(
              color: appColors.primaryAccent,
            ),
            displaySmall: bodyStyle.copyWith(
              color: appColors.placeholderText,
            ),
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: mainStyle.copyWith(
              color: appColors.primaryText,
            ),
            backgroundColor: appColors.main,
            surfaceTintColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            shadowColor: appColors.shadow,
          ),
          iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
              splashFactory: NoSplash.splashFactory,
              iconColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return appColors.placeholderText;
                  }
                  return appColors.white;
                },
              ),
              overlayColor: MaterialStateProperty.all<Color>(
                Colors.transparent,
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return appColors.secondaryAccent;
                  } else if (states.contains(MaterialState.disabled)) {
                    return appColors.layer;
                  }
                  return appColors.primaryAccent;
                },
              ),
              shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                (Set<MaterialState> states) {
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(
                        width: 2.r,
                        color: (states.contains(MaterialState.disabled))
                            ? appColors.placeholderText
                            : Colors.transparent),
                  );
                },
              ),
              iconSize: MaterialStateProperty.all<double>(24.r),
              maximumSize: MaterialStateProperty.all<Size>(
                Size(44.r, 44.r),
              ),
            ),
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: appColors.primaryText,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide:
                  BorderSide(color: appColors.primaryAccent, width: 2.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
            ),
            hintStyle: bodyStyle.copyWith(color: appColors.placeholderText),
            helperStyle: bodyStyle.copyWith(color: appColors.primaryText),
            focusColor: appColors.secondaryAccent,
            fillColor: appColors.layer,
          ),
        ),
        home: const LoadingScreen(),
      ),
    );
  }
}
