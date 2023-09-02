import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_app/flow/search/data/models/github_repo.dart';
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
        padding: EdgeInsets.fromLTRB(16.r, 5.r, 16.r, 6.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(repo.name, overflow: TextOverflow.ellipsis, maxLines: 1),
            IconButton(
              icon: Icon(
                AppIcons.favorite_active,
                size: 24.r,
                color: repo.favourite
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).disabledColor,
              ),
              style: ButtonStyle(
                splashFactory: NoSplash.splashFactory,
                iconSize: MaterialStateProperty.all<double>(24.r),
                iconColor: MaterialStateProperty.all<Color>(
                  repo.favourite
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).disabledColor,
                ),
                overlayColor: MaterialStateProperty.all<Color>(
                    Colors.black.withOpacity(0.05)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(
                      width: 2.r,
                      color: Colors.transparent,
                    ),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.transparent,
                ),
                maximumSize: MaterialStateProperty.all<Size>(
                  Size(44.r, 44.r),
                ),
              ),
              onPressed: onFavTap,
            ),
          ],
        ),
      ),
    );
  }
}
