import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/domain/github_repo.dart';
import '../../model/domain/github_repo_list.dart';

final githubRepoLocalDataSourceProvider = Provider<GithubRepoLocalDataSource>(
  (ref) => GithubRepoLocalDataSourceImpl(),
);

abstract class GithubRepoLocalDataSource {
  Future<GithubRepoList?> getRepos(String query);

  Future<void> saveRepos(String query, GithubRepoList repos);

  Future<void> clearCache();
}

class GithubRepoLocalDataSourceImpl implements GithubRepoLocalDataSource {
  GithubRepoLocalDataSourceImpl();

  final Map<String, GithubRepoList> _cache = {};

  @override
  Future<GithubRepoList?> getRepos(String query) async {
    return _cache[query];
  }

  @override
  Future<void> saveRepos(String query, GithubRepoList repos) async {
    _cache[query] = repos;
  }

  @override
  Future<void> clearCache() async {
    _cache.clear();
  }

  Future<void> removeCache(String query) async {
    _cache.remove(query);
  }
}
