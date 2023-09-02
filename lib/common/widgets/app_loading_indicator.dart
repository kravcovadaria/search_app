import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      radius: 11.r,
      color: Theme.of(context).progressIndicatorTheme.color,
    );
  }
}
