import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_repository/target_repository.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/utils/extensions.dart';
import 'package:tctt_mobile/target_detail/bloc/target_detail_bloc.dart';
import 'package:tctt_mobile/widgets/label_text.dart';
import 'package:tctt_mobile/widgets/loader.dart';
import 'package:tctt_mobile/widgets/post_container.dart';
import 'package:tctt_mobile/widgets/rich_list_view.dart';

class TargetDetailPage extends StatelessWidget {
  const TargetDetailPage({super.key});

  static Route<void> route(String targetId) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (context) => TargetDetailBloc(
          targetRepository: RepositoryProvider.of<TargetRepository>(context),
          targetId: targetId,
        )
          ..add(const PostsFetchedEvent())
          ..add(const TargetInfoFetchedEvent()),
        child: const TargetDetailPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Các bài đăng',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Urbanist',
                letterSpacing: 0,
              ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    BlocSelector<TargetDetailBloc, TargetDetailState, String>(
                  selector: (state) {
                    return state.target.name?.noBlank ??
                        state.target.informalName?.noBlank ??
                        state.target.uid;
                  },
                  builder: (context, targetName) {
                    return MediumLabelText(targetName);
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<TargetDetailBloc, TargetDetailState>(
                builder: (context, state) {
                  switch (state.status) {
                    case FetchDataStatus.initial:
                      return const Loader();
                    default:
                      if (state.status.isLoading && state.posts.isEmpty) {
                        return const Loader();
                      }
                      return RichListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        startPadding: 0,
                        endPadding: 0,
                        hasReachedMax: state.hasReachedMax,
                        itemCount: state.posts.length,
                        onRefresh: () async {
                          context
                              .read<TargetDetailBloc>()
                              .add(const PostsReFetchedEvent());
                        },
                        itemBuilder: (index) {
                          final currentPost = state.posts[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: PostContainer(
                              comment: currentPost.commentTotal,
                              content: currentPost.content,
                              like: currentPost.reactionTotal,
                              name: state.target.name?.noBlank ??
                                  state.target.informalName?.noBlank ??
                                  state.target.uid,
                              share: currentPost.shareTotal,
                              time: currentPost.time,
                            ),
                          );
                        },
                        onReachedEnd: () {
                          context
                              .read<TargetDetailBloc>()
                              .add(const PostsFetchedEvent());
                        },
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
