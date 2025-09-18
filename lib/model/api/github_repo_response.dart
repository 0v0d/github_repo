import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/github_repo.dart';

part 'github_repo_response.freezed.dart';

part 'github_repo_response.g.dart';

@freezed
class GithubRepoResponse with _$GithubRepoResponse {
  const factory GithubRepoResponse({
    required int id,
    @JsonKey(name: 'full_name') required String fullName,
    String? language,
  }) = _GithubRepoResponse;

  factory GithubRepoResponse.fromJson(Map<String, Object?> json) =>
      _$GithubRepoResponseFromJson(json);

  const GithubRepoResponse._();

  GithubRepo toDomain() {
    return GithubRepo(
      id: id,
      fullName: fullName,
      language: language,
    );
  }
}
