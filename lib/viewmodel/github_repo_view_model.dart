import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_images/repository/github_repo_repository.dart';

import '../model/domain/github_repo_list.dart';

final githubRepoViewModelProvider =
NotifierProvider<GithubRepoViewModel, UiState>(GithubRepoViewModel.new);

class GithubRepoViewModel extends Notifier<UiState> {
  @override
  UiState build() {
    // 初期状態を返す
    return UiState.loading();
  }
  GithubRepoRepository get _repository => ref.read(githubRepoRepositoryProvider);

  Future<void> fetchRepoNames(String query) async {
    state = UiState.loading();
    try {
      final repos = await _repository.getRepos(query);

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
