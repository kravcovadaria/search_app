import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_app/flow/search/data/models/github_repo.dart';
import 'package:search_app/common/theme/app_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    super.key,
    required this.repo,
    required this.onFavTap,
  });

  final GithubRepo repo;
  final VoidCallback onFavTap;

  Future<void> _launchRepoUrl() async {
    try {
      launchUrl(Uri.parse(repo.url), mode: LaunchMode.externalApplication);
    } catch (e, stack) {
      log('Can not launch url: ${repo.url}\n$e\n$stack');
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10.r);
    const splashColor = Colors.black;
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: _launchRepoUrl,
        borderRadius: borderRadius,
        highlightColor: splashColor.withOpacity(0.01),
        splashColor: splashColor.withOpacity(0.01),
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
                      splashColor.withOpacity(0.05)),
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
      ),
    );
  }
}
