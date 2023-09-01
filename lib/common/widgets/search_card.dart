import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_app/app/data/models/github_repo.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({super.key, required this.repo});

  final GithubRepo repo;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        // color: AppColors.layer,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(repo.name),
    );
  }
}
