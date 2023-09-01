import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavBar({
    super.key,
    required this.title,
    this.leftIcon,
    this.leftButtonTap,
    this.rightIcon,
    this.rightButtonTap,
  });

  final String title;
  final IconData? leftIcon;
  final VoidCallback? leftButtonTap;
  final IconData? rightIcon;
  final VoidCallback? rightButtonTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        title: Text(title),
        toolbarHeight: preferredSize.height,
        bottom: const _AppBarBottom(),
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
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 56.r);
}

class _AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const _AppBarBottom({super.key});

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
