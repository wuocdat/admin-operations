import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:target_repository/target_repository.dart';
import 'package:tctt_mobile/core/utils/extensions.dart';
import 'package:tctt_mobile/features/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/features/target/cubit/target_cubit.dart';
import 'package:tctt_mobile/features/target/widgets/subject_actions/bloc/subject_action_bloc.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/widgets/loader.dart';
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
    final startDate =
        context.select((TargetCubit cubit) => cubit.state.startDate);
    final endDate = context.select((TargetCubit cubit) => cubit.state.endDate);
    final currentPickedUnitId = context
            .select((TargetCubit cubit) => cubit.state.currentUnit.id)
            .noBlank ??
        unitId;

    return BlocProvider(
      create: (context) => SubjectActionBloc(
        targetRepository: RepositoryProvider.of<TargetRepository>(context),
        unitId: unitId,
      )..add(PostsFetchedEvent(
          typeAc: typeAc,
          startDate: (startDate ?? DateTime.now()).stringFormat,
          endDate: (endDate ?? DateTime.now()).stringFormat,
          unitId: currentPickedUnitId,
        )),
      child: BlocListener<TargetCubit, TargetState>(
        listenWhen: (previous, current) =>
            previous.selectedOption != current.selectedOption ||
            previous.updateFilterCount != current.updateFilterCount,
        listener: (context, state) {
          context.read<SubjectActionBloc>().add(PostsReFetchedEvent(
                typeAc: state.selectedOption.typeAc,
                startDate: (state.startDate ?? DateTime.now()).stringFormat,
                endDate: (state.endDate ?? DateTime.now()).stringFormat,
                unitId: state.currentUnit.id.noBlank ?? unitId,
              ));
        },
        child: BlocBuilder<SubjectActionBloc, SubjectActionState>(
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
                    context.read<SubjectActionBloc>().add(PostsReFetchedEvent(
                          typeAc: typeAc,
                          startDate: (startDate ?? DateTime.now()).stringFormat,
                          endDate: (endDate ?? DateTime.now()).stringFormat,
                          unitId: currentPickedUnitId,
                        ));
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
                    context.read<SubjectActionBloc>().add(PostsFetchedEvent(
                          typeAc: typeAc,
                          startDate: (startDate ?? DateTime.now()).stringFormat,
                          endDate: (endDate ?? DateTime.now()).stringFormat,
                          unitId: currentPickedUnitId,
                        ));
                  },
                );
            }
          },
        ),
      ),
    );
  }
}

extension DateTimeX on DateTime {
  String get stringFormat => DateFormat('yyyy-MM-dd').format(this);
}
