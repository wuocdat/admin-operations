import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_repository/target_repository.dart';
import 'package:tctt_mobile/features/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/features/new_subject/new_subject_page.dart';
import 'package:tctt_mobile/features/target/widgets/filter_content/filter_content.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/features/target/cubit/target_cubit.dart';
import 'package:tctt_mobile/features/target/widgets/subject_actions/subject_actions.dart';
import 'package:tctt_mobile/features/target/widgets/subject_list/subject_list.dart';
import 'package:tctt_mobile/shared/widgets/has_permission.dart';
import 'package:tctt_mobile/shared/widgets/head_bar.dart';
import 'package:tctt_mobile/shared/widgets/toggle_options.dart';

class TargetPage extends StatelessWidget {
  const TargetPage({super.key});

  static const List<Widget> _widgetOptions = [
    SubjectList(),
    SubjectActions(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TargetCubit(
        targetRepository: RepositoryProvider.of<TargetRepository>(context),
      )..resetTime(),
      child: BlocConsumer<TargetCubit, TargetState>(
        listenWhen: (previous, current) =>
            previous.downloadingStatus != current.downloadingStatus,
        listener: (context, state) {
          switch (state.downloadingStatus) {
            case FetchDataStatus.loading:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đang tải xuống...'),
                ),
              );
              break;

            case FetchDataStatus.success:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Tải xuống thành công'),
                ),
              );
              break;

            case FetchDataStatus.failure:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tải xuống thất bại'),
                ),
              );
              break;

            default:
              break;
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              HeadBar<TargetOptions>(
                label: "Đối tượng giám sát và Kênh truyền thông",
                hideSearchBar: true,
                selectedOption: state.selectedOption,
                options: TargetOptions.values
                    .map<DropdownMenuItem<TargetOptions>>(
                        (TargetOptions value) {
                  return DropdownMenuItem<TargetOptions>(
                    value: value,
                    child: Text(value.title),
                  );
                }).toList(),
                onPickedOption: (TargetOptions? value) {
                  context
                      .read<TargetCubit>()
                      .changeOption(value ?? TargetOptions.subject);
                },
                action: BlocSelector<AuthenticationBloc, AuthenticationState,
                    String>(
                  selector: (state) {
                    return state.user.unit.id;
                  },
                  builder: (context, unitId) {
                    final isListMode = context.select((TargetCubit cubit) =>
                        cubit.state.viewIndex.isListMode);
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (isListMode) ...[
                          CreatingPermission(
                            feature: ProtectedFeature.fbSubjects,
                            child: IconButton(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  NewSubjectPage.route(
                                      unitId, state.selectedOption),
                                );
                                // if (!context.mounted) return;
                                // context
                                //     .read<TaskBloc>()
                                //     .add(const ReloadIncreasedEvent());
                              },
                              icon: const Icon(Icons.add),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        if (!isListMode) ...[
                          IconButton(
                            onPressed: () {
                              context
                                  .read<TargetCubit>()
                                  .downloadExcelFile(unitId);
                            },
                            icon: const Icon(Icons.file_download_outlined),
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                        ],
                        FilterButton(
                          filtered: state.filterChanged,
                          onTap: () {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              context: context,
                              builder: (_) {
                                return FilterContent(
                                  initialTargetName: state.targetName,
                                  showTime: !isListMode,
                                  initialEndDate: state.endDate,
                                  initialStartDate: state.startDate,
                                  selectedFbPageType: state.fbPageType,
                                  currentUnit: state.currentUnit,
                                  stepUnitsList: state.stepUnitsList,
                                  subUnitsList: state.subUnitsList,
                                  onApplyFilterData: context
                                      .read<TargetCubit>()
                                      .updateFilterDataForActionView,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: ToggleOptions(
                          selectedIndex: state.viewIndex,
                          items: SubjectViewOption.values
                              .map((e) => Text(e.title))
                              .toList(),
                          onPressed: (int index) {
                            context.read<TargetCubit>().changeViewIndex(index);
                          },
                        ),
                      ),
                    ),
                    Expanded(child: _widgetOptions.elementAt(state.viewIndex)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

extension on int {
  bool get isListMode => this == 0;
}
