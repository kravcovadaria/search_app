import 'package:hive/hive.dart';

part 'github_repo.g.dart';

@HiveType(typeId: 0)
class GithubRepo {
  GithubRepo({
    required this.url,
    required this.name,
    this.favourite = false,
  });

  @HiveField(0)
  String url;
  @HiveField(1)
  String name;
  @HiveField(2)
  bool favourite;

  factory GithubRepo.fromJson(Map<String, dynamic> json) =>
      GithubRepo(url: json['url'] as String, name: json['name'] as String);
}
