import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_repository/target_repository.dart';
import 'package:tctt_mobile/features/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/features/target/cubit/target_cubit.dart';
import 'package:tctt_mobile/features/target/widgets/subject_actions/bloc/subject_action_bloc.dart';
import 'package:tctt_mobile/shared/widgets/post_container.dart';
import 'package:tctt_mobile/shared/widgets/rich_list_view.dart';

class SubjectActions extends StatelessWidget {
  const SubjectActions({super.key});

  @override
  Widget build(BuildContext context) {
    final typeAc = context
        .select((TargetCubit cubit) => cubit.state.selectedOption.typeAc);
    final unitId =
        context.select((AuthenticationBloc bloc) => bloc.state.user.unit.id);

    return BlocProvider(
      create: (context) => SubjectActionBloc(
        targetRepository: RepositoryProvider.of<TargetRepository>(context),
        unitId: unitId,
      )..add(PostsFetchedEvent(typeAc: typeAc)),
      child: BlocListener<TargetCubit, TargetState>(
        listenWhen: (previous, current) =>
            previous.selectedOption != current.selectedOption,
        listener: (context, state) {
          context
              .read<SubjectActionBloc>()
              .add(PostsReFetchedEvent(typeAc: state.selectedOption.typeAc));
        },
        child: BlocBuilder<SubjectActionBloc, SubjectActionState>(
          builder: (context, state) {
            return RichListView(
              physics: const AlwaysScrollableScrollPhysics(),
              startPadding: 0,
              endPadding: 0,
              hasReachedMax: state.hasReachedMax,
              itemCount: state.posts.length,
              onRefresh: () async {
                context
                    .read<SubjectActionBloc>()
                    .add(PostsReFetchedEvent(typeAc: typeAc));
              },
              itemBuilder: (index) {
                final currentPost = state.posts[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: PostContainer(
                    comment: currentPost.commentTotal,
                    content: currentPost.content,
                    like: currentPost.reactionTotal,
                    name: currentPost.fbSubject['name'],
                    share: currentPost.shareTotal,
                    time: currentPost.time,
                  ),
                );
              },
              onReachedEnd: () {
                context
                    .read<SubjectActionBloc>()
                    .add(PostsFetchedEvent(typeAc: typeAc));
              },
            );
          },
        ),
      ),
    );
  }
}
