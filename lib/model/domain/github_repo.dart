import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_repo.freezed.dart';

part 'github_repo.g.dart';

@freezed
class GithubRepoList with _$GithubRepoList {
  const factory GithubRepoList({
    required List<GithubRepo> items,
  }) = _GithubRepoList;

  const GithubRepoList._();

  factory GithubRepoList.fromJson(Map<String, dynamic> json) =>
      _$GithubRepoListFromJson(json);
}

@freezed
class GithubRepo with _$GithubRepo {
  const factory GithubRepo({
    required int id,
    required String fullName,
    String? language,
  }) = _GithubRepo;

  const GithubRepo._();

  factory GithubRepo.fromJson(Map<String, dynamic> json) =>
      _$GithubRepoFromJson(json);
}
