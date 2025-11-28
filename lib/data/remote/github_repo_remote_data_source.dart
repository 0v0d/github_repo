import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/api/github_search_response.dart';
import 'api_client.dart';

part 'github_repo_remote_data_source.g.dart';

final githubRepoRemoteDataSourceProvider =
Provider((ref) => GithubRepoRemoteDataSource(ref));

@RestApi()
abstract class GithubRepoRemoteDataSource {
  factory GithubRepoRemoteDataSource(Ref ref) =>
      _GithubRepoRemoteDataSource(ref.read(dioProvider));

  @GET('search/repositories')
  Future<GithubSearchResponse> getRepos(@Query('q') String query);
}
