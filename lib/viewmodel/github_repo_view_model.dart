import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_images/model/domain/github_repo.dart';
import 'package:random_images/repository/github_repo_repository.dart';

import '../model/domain/github_repo_list.dart';

final githubRepoViewModelProvider =
    StateNotifierProvider<GithubRepoViewModel, UiState>(
        (ref) => GithubRepoViewModel(ref));

class GithubRepoViewModel extends StateNotifier<UiState> {
  GithubRepoViewModel(this._ref) : super(UiState.loading());

  final Ref _ref;

  late final GithubRepoRepository githubRepoRepository =
      _ref.read(githubRepoRepositoryProvider);

  Future<void> fetchRepoNames(String query) async {
    try {
      final repos = await githubRepoRepository.getRepos(query);

      if (repos.items.isEmpty) {
        state = UiState.emptyResult();
        return;
      }

      state = UiState.success(repos);
    } catch (e) {
      state = UiState.networkError();
    }
  }
}

sealed class UiState {
  const UiState();

  factory UiState.loading() => const UiStateLoading();

  factory UiState.success(GithubRepoList data) => UiStateSuccess(data);

  factory UiState.networkError() => const UiStateNetworkError();

  factory UiState.emptyResult() => const UiStateEmptyResult();
}

class UiStateLoading extends UiState {
  const UiStateLoading();
}

class UiStateSuccess extends UiState {
  final GithubRepoList data;

  const UiStateSuccess(this.data);
}

class UiStateNetworkError extends UiState {
  const UiStateNetworkError();
}

class UiStateEmptyResult extends UiState {
  const UiStateEmptyResult();
}
