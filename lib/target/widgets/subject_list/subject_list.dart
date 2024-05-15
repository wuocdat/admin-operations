import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_repository/target_repository.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/utils/extensions.dart';
import 'package:tctt_mobile/shared/utils/url_launcher.dart';
import 'package:tctt_mobile/target/cubit/target_cubit.dart';
import 'package:tctt_mobile/target/widgets/subject_list/bloc/subject_list_bloc.dart';
import 'package:tctt_mobile/theme/colors.dart';
import 'package:tctt_mobile/widgets/empty_list_message.dart';
import 'package:tctt_mobile/widgets/loader.dart';
import 'package:tctt_mobile/widgets/rich_list_view.dart';

class SubjectList extends StatelessWidget {
  const SubjectList({super.key});

  @override
  Widget build(BuildContext context) {
    final typeAc = context
        .select((TargetCubit cubit) => cubit.state.selectedOption.typeAc);

    return BlocProvider(
      create: (context) => SubjectListBloc(
          targetRepository: RepositoryProvider.of<TargetRepository>(context))
        ..add(SubjectListFetched(typeAc: typeAc)),
      child: BlocListener<TargetCubit, TargetState>(
        listenWhen: (previous, current) =>
            previous.selectedOption != current.selectedOption,
        listener: (context, state) {
          context
              .read<SubjectListBloc>()
              .add(SubjectReFetchedEvent(typeAc: state.selectedOption.typeAc));
        },
        child: BlocBuilder<SubjectListBloc, SubjectListState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<SubjectListBloc>()
                    .add(SubjectReFetchedEvent(typeAc: typeAc));
              },
              child: Builder(
                builder: (context) {
                  switch (state.status) {
                    case FetchDataStatus.initial:
                      return const Loader();
                    default:
                      if (state.status.isLoading && state.subjects.isEmpty) {
                        return const Loader();
                      }
                      if (state.subjects.isEmpty) {
                        return const EmptyListMessage(
                          message: "Không có mục nào",
                        );
                      }
                      return RichListView(
                        physicsl: const AlwaysScrollableScrollPhysics(),
                        hasReachedMax: state.hasReachedMax,
                        itemCount: state.subjects.length,
                        itemBuilder: (index) {
                          final currentSubject = state.subjects[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SubjectItem(
                              name: currentSubject.name,
                              facebookName: currentSubject.informalName,
                              uid: currentSubject.uid,
                              addedAt: currentSubject.createdAt.split(' ').last,
                              type: currentSubject.type.fbPageType,
                              isTracking: currentSubject.isTracking,
                            ),
                          );
                        },
                        onReachedEnd: () {
                          context
                              .read<SubjectListBloc>()
                              .add(SubjectListFetched(typeAc: typeAc));
                        },
                      );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class SubjectItem extends StatelessWidget {
  const SubjectItem({
    super.key,
    this.name,
    this.facebookName,
    required this.uid,
    required this.addedAt,
    required this.type,
    required this.isTracking,
  });

  final String? facebookName;
  final String uid;
  final String addedAt;
  final FbPageType type;
  final bool isTracking;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x230E151B),
            offset: Offset(
              0.0,
              2,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primaryBackground,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name?.noBlank ?? facebookName?.noBlank ?? uid,
              style: const TextStyle(
                color: Color(0xFF14181B),
                fontSize: 24,
                letterSpacing: 0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(type.title),
            const SizedBox(height: 2),
            if (facebookName != null) Text('Tên facebook: $facebookName'),
            const SizedBox(height: 2),
            InkWell(
              onTap: () => launchLink('https://facebook.com/$uid'),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'UID: ',
                      style: DefaultTextStyle.of(context).style,
                    ),
                    TextSpan(
                      text: uid,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(isTracking ? 'Theo dõi' : 'Không theo dõi'),
            const SizedBox(height: 2),
            Text('Được thêm từ ngày ${addedAt}'),
          ],
        ),
      ),
    );
  }
}

extension on String {
  FbPageType get fbPageType {
    switch (this) {
      case '1':
        return FbPageType.fanpage;
      case '2':
        return FbPageType.openGroup;
      default:
        return FbPageType.personalPage;
    }
  }
}
