import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/github_repo_local_data_source.dart';
import '../data/remote/github_repo_remote_data_source.dart';
import '../model/domain/github_repo.dart';
import '../model/domain/github_repo_list.dart';

abstract class GithubRepoRepository {
  Future<GithubRepoList> getRepos(String query);
}

final githubRepoRepositoryProvider =
    Provider((ref) => GithubRepoRepositoryImpl(ref));

class GithubRepoRepositoryImpl implements GithubRepoRepository {
  GithubRepoRepositoryImpl(this._ref);

  final Ref _ref;

  late final GithubRepoRemoteDataSource remoteDataSource =
      _ref.read(githubRepoRemoteDataSourceProvider);

  late final GithubRepoLocalDataSource localDataSource =
      _ref.read(githubRepoLocalDataSourceProvider);

  @override
  Future<GithubRepoList> getRepos(String query) async {
    final cachedData = await localDataSource.getRepos(query);
    if (cachedData != null) {
      return cachedData;
    }

    final response = await remoteDataSource.getRepos(query);
    final domainData = response.toDomain();

    await localDataSource.saveRepos(query, domainData);

    return domainData;
  }
}
