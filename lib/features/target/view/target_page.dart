import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tctt_mobile/core/theme/colors.dart';
import 'package:tctt_mobile/features/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/features/new_subject/new_subject_page.dart';
import 'package:tctt_mobile/features/target/models/filter_data.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/features/target/cubit/target_cubit.dart';
import 'package:tctt_mobile/features/target/widgets/subject_actions/subject_actions.dart';
import 'package:tctt_mobile/features/target/widgets/subject_list/subject_list.dart';
import 'package:tctt_mobile/features/target/widgets/wrap_options.dart';
import 'package:tctt_mobile/shared/widgets/border_container.dart';
import 'package:tctt_mobile/shared/widgets/has_permission.dart';
import 'package:tctt_mobile/shared/widgets/head_bar.dart';
import 'package:tctt_mobile/shared/widgets/inputs.dart';
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
      create: (_) => TargetCubit()..resetTime(),
      child: BlocBuilder<TargetCubit, TargetState>(
        builder: (context, state) {
          return Column(
            children: [
              HeadBar<TargetOptions>(
                label: "Đối tượng và Kênh ta",
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
                            onPressed: () async {},
                            icon: const Icon(Icons.file_download_outlined),
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                        ],
                        FilterButton(
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

class FilterContent extends StatefulWidget {
  const FilterContent({
    super.key,
    required this.onApplyFilterData,
    this.initialEndDate,
    this.initialStartDate,
    required this.showTime,
    this.selectedFbPageType,
    required this.initialTargetName,
  });

  final void Function(FilterData) onApplyFilterData;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final bool showTime;
  final FbPageType? selectedFbPageType;
  final String initialTargetName;

  @override
  State<FilterContent> createState() => _FilterContentState();
}

class _FilterContentState extends State<FilterContent> {
  late DateTime? _pickedStartDate;
  late DateTime? _pickedEndDate;
  late FbPageType? _fbPageType;
  late String _targetName;

  @override
  void initState() {
    super.initState();
    _pickedStartDate = widget.initialStartDate;
    _pickedEndDate = widget.initialEndDate;
    _fbPageType = widget.selectedFbPageType;
    _targetName = widget.initialTargetName;
  }

  void _setStartDate(DateTime date) {
    setState(() {
      _pickedStartDate = date;
    });
  }

  void _setEndDate(DateTime date) {
    setState(() {
      _pickedEndDate = date;
    });
  }

  void _setFbPageType(FbPageType? type) {
    setState(() {
      _fbPageType = type;
    });
  }

  void _setTargetName(String name) {
    setState(() {
      _targetName = name;
    });
  }

  void _handleApplyFilterData() {
    final data = FilterData(
      startDate:
          _pickedStartDate ?? DateTime.now().subtract(const Duration(days: 1)),
      endDate: _pickedEndDate ?? DateTime.now(),
      fbPageType: _fbPageType,
      targetName: _targetName,
    );
    widget.onApplyFilterData(data);
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        heightFactor: 0.9,
        child: ListView(
          children: [
            BottomBorderContainer(
              borderWidth: 1,
              borderColor: Colors.grey[300] ?? Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Expanded(child: Text('Bộ lọc tìm kiếm')),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Thoát'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        _handleApplyFilterData();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Áp dụng'),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.showTime)
              FilterSection(
                name: 'Theo thời gian',
                child: Row(
                  children: [
                    Expanded(
                      child: DatePickerButton(
                        title: 'Ngày bắt đầu',
                        initialDate: _pickedStartDate,
                        onPickDate: _setStartDate,
                      ),
                    ),
                    Container(
                      width: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Divider(),
                    ),
                    Expanded(
                      child: DatePickerButton(
                        title: 'Ngày kết thúc',
                        initialDate: _pickedEndDate,
                        onPickDate: _setEndDate,
                      ),
                    ),
                  ],
                ),
              ),
            if (!widget.showTime) ...[
              FilterSection(
                name: 'Theo tên',
                child: BaseInput(
                  initialValue: widget.initialTargetName,
                  hintText: 'Nhập tên đối tượng',
                  backgroundColor: Colors.grey[300],
                  onChanged: _setTargetName,
                ),
              ),
              FilterSection(
                name: 'Theo dạng trang',
                child: WrapOptions(
                  builderItem: (index) {
                    final currentFbType = FbPageType.values[index];
                    final isSelected = _fbPageType == currentFbType;
                    return SelectableContainer(
                      content: currentFbType.title,
                      isSelected: isSelected,
                      onTap: () =>
                          _setFbPageType(isSelected ? null : currentFbType),
                    );
                  },
                  length: FbPageType.values.length,
                ),
              ),
            ],
            // const FilterSection(
            //   name: 'Theo đơn vị quản lý',
            //   child: UnitSelector(),
            // ),
          ],
        ));
  }
}

class DatePickerButton extends StatelessWidget {
  const DatePickerButton({
    super.key,
    required this.title,
    required this.onPickDate,
    this.initialDate,
  });

  final String title;
  final DateTime? initialDate;
  final void Function(DateTime) onPickDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        helpText: 'Chọn ${title.toLowerCase()}',
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());

    if (picked != null) {
      onPickDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = initialDate != null;

    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: hasValue ? Colors.white : Colors.grey[300],
          border: Border.all(
            color: hasValue ? AppColors.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
            initialDate != null ? DateFormat.yMd().format(initialDate!) : title,
            textAlign: TextAlign.center),
      ),
    );
  }
}

class FilterSection extends StatelessWidget {
  const FilterSection({
    super.key,
    required this.name,
    required this.child,
  });

  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BottomBorderContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      borderWidth: 1,
      borderColor: Colors.grey[300] ?? Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    this.filtered = false,
    this.onTap,
  });

  final bool filtered;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Badge(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            label: const Icon(
              Icons.check_circle,
              size: 16,
              color: Colors.green,
            ),
            backgroundColor: Colors.white,
            isLabelVisible: filtered,
            child: const Icon(Icons.filter_alt_outlined),
          ),
          const SizedBox(width: 2),
          const Text(
            'Lọc',
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}

extension on int {
  bool get isListMode => this == 0;
}
