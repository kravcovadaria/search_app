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

  GithubRepo copyWith({
    String? url,
    String? name,
    bool? favourite,
  }) =>
      GithubRepo(
        url: url ?? this.url,
        name: name ?? this.name,
        favourite: favourite ?? this.favourite,
      );

  factory GithubRepo.fromJson(Map<String, dynamic> json) =>
      GithubRepo(url: json['html_url'] as String, name: json['full_name'] as String);

  Map<String, dynamic> toJson() => {
        'html_url': url,
        'full_name': name,
        'favourite': favourite,
      };
}
