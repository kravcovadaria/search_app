import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_app/app/data/models/github_repo.dart';
import 'package:search_app/common/theme/app_icons.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    super.key,
    required this.repo,
    required this.onFavTap,
  });

  final GithubRepo repo;
  final VoidCallback onFavTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.r,
          right: 16.r,
          top: 5.r,
          bottom: 6.r,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(repo.name),
            Theme(
              data: ThemeData(
                iconButtonTheme: IconButtonThemeData(
                  style: ButtonStyle(
                    iconSize: MaterialStateProperty.all<double>(24.r),
                    iconColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor,
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        const BeveledRectangleBorder()),
                    maximumSize: MaterialStateProperty.all<Size>(
                      Size(44.r, 44.r),
                    ),
                  ),
                ),
              ),
              child: IconButton(
                icon: Icon(
                  AppIcons.favorite_active,
                  color: repo.favourite
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).disabledColor,
                ),
                onPressed: onFavTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
