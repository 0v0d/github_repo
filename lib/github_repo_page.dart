import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_images/github_repo_detail_page.dart';
import 'package:random_images/viewmodel/github_repo_view_model.dart';

class GithubRepoPage extends ConsumerWidget {
  const GithubRepoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(githubRepoViewModelProvider.notifier);
    final uiState = ref.watch(githubRepoViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repositories'),
      ),
      body: GithubRepoListView(
        state: uiState,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.fetchRepoNames("kotlin"); // テスト用のボタン
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}

class GithubRepoListView extends StatelessWidget {
  final Object state;

  const GithubRepoListView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      UiStateLoading() => const Center(child: CircularProgressIndicator()),
      UiStateSuccess(:final data) => ListView.builder(
          itemCount: data.items.length,
          itemBuilder: (context, index) {
            final repo = data.items[index];
            return ListTile(
              title: Text(repo.fullName),
              subtitle: repo.language != null ? Text(repo.language ?? "") : null,
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => GithubRepoDetailPage(repo: repo),
                  ),
                );
              },
            );
          },
        ),
      UiStateNetworkError() => const Center(child: Text('Network Error')),
      UiStateEmptyResult() => const Center(child: Text('No Results Found')),
      _ => const SizedBox(),
    };
  }
}
