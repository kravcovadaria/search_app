// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GitSearchResult _$$_GitSearchResultFromJson(Map<String, dynamic> json) =>
    _$_GitSearchResult(
      totalCount: json['total_count'] as int? ?? 0,
      incompleteResults: json['incomplete_results'] as bool? ?? false,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => GithubRepo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_GitSearchResultToJson(_$_GitSearchResult instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'incomplete_results': instance.incompleteResults,
      'items': instance.items,
    };
