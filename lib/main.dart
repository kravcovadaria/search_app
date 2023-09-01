import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_app/app/presentation/screens/loading_screen.dart';
import 'package:search_app/app/presentation/screens/search_app.dart';
import 'package:search_app/common/theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const SearchApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          AppColors appColors = const AppColors();
          TextStyle mainStyle = TextStyle(
            fontFamily: 'Raleway',
            fontSize: 16.sp,
            height: 1.1875,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          );

          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: appColors.main,
              primaryColor: appColors.primaryAccent,
              appBarTheme: AppBarTheme(
                titleTextStyle: mainStyle.copyWith(
                  color: appColors.primaryText,
                ),
                centerTitle: true,
              ),
              iconButtonTheme: IconButtonThemeData(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return appColors.secondaryAccent;
                      } else if (states.contains(MaterialState.disabled)) {
                        return appColors.layer;
                      }
                      return appColors.primaryAccent;
                    },
                  ),
                  shape:
                      MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                    (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(
                            color: (states.contains(MaterialState.pressed))
                                ? appColors.secondaryAccent
                                : (states.contains(MaterialState.disabled))
                                    ? appColors.placeholderText
                                    : appColors.primaryAccent),
                      );
                    },
                  ),
                  iconSize: MaterialStateProperty.all<double>(24.r),
                  maximumSize: MaterialStateProperty.all<Size>(
                    Size(44.r, 44.r),
                  ),
                ),
              ),
              useMaterial3: true,
            ),
            home: const LoadingScreen(),
          );
        });
  }
}
