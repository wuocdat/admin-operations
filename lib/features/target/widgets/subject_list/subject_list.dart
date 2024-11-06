import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_repository/target_repository.dart';
import 'package:tctt_mobile/features/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/core/utils/extensions.dart';
import 'package:tctt_mobile/core/utils/url_launcher.dart';
import 'package:tctt_mobile/features/target/cubit/target_cubit.dart';
import 'package:tctt_mobile/features/target/widgets/subject_list/bloc/subject_list_bloc.dart';
import 'package:tctt_mobile/features/target_detail/view/target_detail_page.dart';
import 'package:tctt_mobile/core/theme/colors.dart';
import 'package:tctt_mobile/shared/widgets/loader.dart';
import 'package:tctt_mobile/shared/widgets/rich_list_view.dart';

class SubjectList extends StatelessWidget {
  const SubjectList({super.key});

  Future<void> _showWithDrawDialog(
      BuildContext context, String subjectId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<SubjectListBloc>(context),
          child: BlocBuilder<SubjectListBloc, SubjectListState>(
            builder: (context, state) {
              return AlertDialog(
                title: const Text('Xóa đối tượng'),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Bạn có chắc chắn muốn xóa đối tượng này không?'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  if (!state.deleteStatus.isLoading)
                    TextButton(
                      child: const Text('Thoát'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  if (!state.deleteStatus.isLoading)
                    ElevatedButton(
                      onPressed: () => context
                          .read<SubjectListBloc>()
                          .add(SubjectDeletedEvent(subjectId: subjectId)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Xóa'),
                    ),
                  if (state.deleteStatus.isLoading)
                    const CircularProgressIndicator(),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final typeAc = context
        .select((TargetCubit cubit) => cubit.state.selectedOption.typeAc);
    final fbType =
        context.select((TargetCubit cubit) => cubit.state.fbPageType);
    final searchTargetName =
        context.select((TargetCubit cubit) => cubit.state.targetName);
    final currentUnitId =
        context.select((AuthenticationBloc bloc) => bloc.state.user.unit.id);
    final currentPickedUnitId = context
            .select((TargetCubit cubit) => cubit.state.currentUnit.id)
            .noBlank ??
        currentUnitId;

    return BlocProvider(
      create: (context) => SubjectListBloc(
          targetRepository: RepositoryProvider.of<TargetRepository>(context))
        ..add(SubjectListFetched(
          unitId: currentPickedUnitId,
          typeAc: typeAc,
          fbPageType: fbType,
          name: searchTargetName,
        )),
      child: MultiBlocListener(
        listeners: [
          BlocListener<TargetCubit, TargetState>(
            listenWhen: (previous, current) =>
                previous.selectedOption != current.selectedOption ||
                previous.updateFilterCount != current.updateFilterCount,
            listener: (context, state) {
              context.read<SubjectListBloc>().add(SubjectReFetchedEvent(
                  unitId: state.currentUnit.id.noBlank ?? currentUnitId,
                  typeAc: state.selectedOption.typeAc,
                  name: state.targetName,
                  fbPageType: state.fbPageType));
            },
          ),
          BlocListener<SubjectListBloc, SubjectListState>(
            listenWhen: (previous, current) =>
                (previous.deleteStatus != current.deleteStatus) ||
                (previous.status != current.status),
            listener: (context, state) {
              if (state.deleteStatus.isFailure || state.status.isFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text("Đã xảy ra lỗi")),
                  );
              }
              if (state.deleteStatus.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Xóa thành công'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
                context.read<SubjectListBloc>().add(SubjectReFetchedEvent(
                      unitId: currentPickedUnitId,
                      typeAc: typeAc,
                      fbPageType: fbType,
                      name: searchTargetName,
                    ));
              }
            },
          ),
        ],
        child: BlocBuilder<SubjectListBloc, SubjectListState>(
          builder: (context, state) {
            switch (state.status) {
              case FetchDataStatus.initial:
                return const Loader();
              default:
                if (state.status.isLoading && state.subjects.isEmpty) {
                  return const Loader();
                }
                return RichListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  hasReachedMax: state.hasReachedMax,
                  itemCount: state.subjects.length,
                  onRefresh: () async {
                    context.read<SubjectListBloc>().add(SubjectReFetchedEvent(
                        unitId: currentPickedUnitId,
                        name: searchTargetName,
                        typeAc: typeAc,
                        fbPageType: fbType));
                  },
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
                        onTap: () {
                          Navigator.of(context)
                              .push(TargetDetailPage.route(currentSubject.id));
                        },
                        onDelete: () =>
                            _showWithDrawDialog(context, currentSubject.id),
                      ),
                    );
                  },
                  onReachedEnd: () {
                    context.read<SubjectListBloc>().add(SubjectListFetched(
                        unitId: currentPickedUnitId,
                        typeAc: typeAc,
                        fbPageType: fbType,
                        name: searchTargetName));
                  },
                );
            }
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
    this.onTap,
    this.onDelete,
  });

  final String? facebookName;
  final String uid;
  final String addedAt;
  final FbPageType type;
  final bool isTracking;
  final String? name;
  final void Function()? onTap;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
          padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 0, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
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
                    if (facebookName != null)
                      Text('Tên facebook: $facebookName'),
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
                    Text('Được thêm từ ngày $addedAt'),
                  ],
                ),
              ),
              IconButton(onPressed: onDelete, icon: const Icon(Icons.delete))
            ],
          ),
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
