import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/github_repo.dart';
import '../domain/github_repo_list.dart';
import 'github_repo_response.dart';

part 'github_search_response.freezed.dart';
part 'github_search_response.g.dart';

@freezed
class GithubSearchResponse with _$GithubSearchResponse  {
  const factory GithubSearchResponse({
    @JsonKey(name: 'total_count') required int totalCount,
    @JsonKey(name: 'incomplete_results') required bool incompleteResults,
    required List<GithubRepoResponse> items,
  }) = _GithubSearchResponse;

  factory GithubSearchResponse.fromJson(Map<String, Object?> json) =>
      _$GithubSearchResponseFromJson(json);

  const GithubSearchResponse._();

  GithubRepoList toDomain() {
    return GithubRepoList(
      items: items.map((repo) => repo.toDomain()).toList(),
    );
  }
}
