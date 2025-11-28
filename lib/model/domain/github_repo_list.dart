import 'package:freezed_annotation/freezed_annotation.dart';

import 'github_repo.dart';

part 'github_repo_list.freezed.dart';
part 'github_repo_list.g.dart';

@freezed
class GithubRepoList with _$GithubRepoList {
  const factory GithubRepoList({
    required List<GithubRepo> items,
  }) = _GithubRepoList;

  const GithubRepoList._();

  factory GithubRepoList.fromJson(Map<String, dynamic> json) =>
      _$GithubRepoListFromJson(json);
}