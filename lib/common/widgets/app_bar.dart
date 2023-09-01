import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: preferredSize.width,
      height: preferredSize.height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3.r),
            blurRadius: 1.r,
            color:
                Theme.of(context).appBarTheme.shadowColor ?? Colors.transparent,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 1);
}

class AppNavBar extends AppBar {
  AppNavBar({
    super.key,
    required String title,
    IconData? leftIcon,
    VoidCallback? leftButtonTap,
    IconData? rightIcon,
    VoidCallback? rightButtonTap,
  }) : super(
          title: Text(title),
          toolbarHeight: 56.r,
          bottom: const AppBarBottom(),
          leading: leftIcon == null
              ? null
              : IconButton(
                  icon: Icon(leftIcon),
                  onPressed: leftButtonTap,
                ),
          actions: [
            if (rightIcon != null)
              IconButton(
                icon: Icon(rightIcon),
                onPressed: rightButtonTap,
              ),
          ],
        );
}
