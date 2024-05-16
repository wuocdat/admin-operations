import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_repository/target_repository.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/utils/extensions.dart';
import 'package:tctt_mobile/target_detail/bloc/target_detail_bloc.dart';
import 'package:tctt_mobile/theme/colors.dart';
import 'package:tctt_mobile/widgets/empty_list_message.dart';
import 'package:tctt_mobile/widgets/images.dart';
import 'package:tctt_mobile/widgets/label_text.dart';
import 'package:tctt_mobile/widgets/loader.dart';
import 'package:tctt_mobile/widgets/rich_list_view.dart';

class TargetDetailPage extends StatelessWidget {
  const TargetDetailPage({super.key});

  static Route<void> route(String targetId) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (context) => TargetDetailBloc(
          targetRepository: RepositoryProvider.of<TargetRepository>(context),
          targetId: targetId,
        )..add(const PostsFetchedEvent()),
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
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: MediumLabelText('An-Nam Yakukohaiyo'),
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
                      if (state.posts.isEmpty) {
                        return const EmptyListMessage(
                          message: "Không có mục nào",
                        );
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
                              name: 'todo',
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

class PostContainer extends StatelessWidget {
  const PostContainer({
    super.key,
    required this.name,
    required this.time,
    required this.content,
    required this.like,
    required this.comment,
    required this.share,
  });

  final String name;
  final String time;
  final String content;
  final String like;
  final String comment;
  final String share;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: SmartAvatar(text: name),
              title: Text(name),
              subtitle: Text(time),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            ),
            Text(content),
            const SizedBox(height: 8),
            Divider(color: AppColors.secondaryBackground.withOpacity(0.3)),
            Row(
              children: [
                Expanded(child: InfoBox(title: 'lượt thích', amount: like)),
                Expanded(child: InfoBox(title: 'bình luận', amount: comment)),
                Expanded(child: InfoBox(title: 'chia sẻ', amount: share)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  const InfoBox({
    super.key,
    required this.title,
    required this.amount,
  });

  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: <TextSpan>[
          TextSpan(
            text: '${amount.noBlank ?? 0}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: ' $title'),
        ],
      ),
    );
  }
}
