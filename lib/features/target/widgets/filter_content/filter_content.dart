import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tctt_mobile/core/theme/colors.dart';
import 'package:tctt_mobile/core/utils/constants.dart';
import 'package:tctt_mobile/features/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/features/target/cubit/target_cubit.dart';
import 'package:tctt_mobile/features/target/models/filter_data.dart';
import 'package:tctt_mobile/features/target/widgets/filter_content/cubit/filter_content_cubit.dart';
import 'package:tctt_mobile/features/target/widgets/unit_selector/unit_selector.dart';
import 'package:tctt_mobile/features/target/widgets/wrap_options.dart';
import 'package:tctt_mobile/shared/widgets/border_container.dart';
import 'package:tctt_mobile/shared/widgets/inputs.dart';
import 'package:units_repository/units_repository.dart';

class FilterContent extends StatefulWidget {
  const FilterContent({
    super.key,
    required this.onApplyFilterData,
    required this.showTime,
    required this.initialTargetName,
    this.initialEndDate,
    this.initialStartDate,
    this.selectedFbPageType,
    required this.currentUnit,
    required this.stepUnitsList,
    required this.subUnitsList,
  });

  final void Function(FilterData) onApplyFilterData;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final bool showTime;
  final FbPageType? selectedFbPageType;
  final String initialTargetName;
  final Unit currentUnit;
  final List<Unit> stepUnitsList;
  final List<Unit> subUnitsList;

  @override
  State<FilterContent> createState() => _FilterContentState();
}

class _FilterContentState extends State<FilterContent> {
  final _targetNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _targetNameController.text = widget.initialTargetName;
  }

  void _handleApplyFilterData(FilterContentState state) {
    final data = FilterData(
      startDate: state.pickedStartDate ??
          DateTime.now().subtract(const Duration(days: defaultDayDuration)),
      endDate: state.pickedEndDate ?? DateTime.now(),
      fbPageType: state.fbPageType,
      targetName: _targetNameController.text,
      currentUnit: state.currentUnit,
      stepUnitsList: state.stepUnitsList,
      subUnitsList: state.subUnitsList,
    );
    widget.onApplyFilterData(data);
  }

  @override
  Widget build(BuildContext context) {
    final currentUnit =
        context.select((AuthenticationBloc bloc) => bloc.state.user.unit);

    return BlocProvider(
      create: (context) => FilterContentCubit(
        unitRepository: RepositoryProvider.of<UnitsRepository>(context),
        startDate: widget.initialStartDate,
        endDate: widget.initialEndDate,
        fbPageType: widget.selectedFbPageType,
        currentUnit: widget.currentUnit,
        stepUnitsList: widget.stepUnitsList,
        subUnitsList: widget.subUnitsList,
      )..fetchUnits(widget.currentUnit.id.isEmpty ? currentUnit : null),
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: ListView(
          children: [
            BlocBuilder<FilterContentCubit, FilterContentState>(
              builder: (context, state) {
                return BottomBorderContainer(
                  borderWidth: 1,
                  borderColor: Colors.grey[300] ?? Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Expanded(child: Text('Bộ lọc tìm kiếm')),
                        OutlinedButton(
                          onPressed: () {
                            context
                                .read<FilterContentCubit>()
                                .resetStateFilter(currentUnit);
                            _targetNameController.clear();
                          },
                          child: const Text('Đặt lại'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            _handleApplyFilterData(state);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Áp dụng'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (widget.showTime)
              BlocBuilder<FilterContentCubit, FilterContentState>(
                buildWhen: (previous, current) =>
                    previous.pickedStartDate != current.pickedStartDate ||
                    previous.pickedEndDate != current.pickedEndDate,
                builder: (context, state) {
                  return FilterSection(
                    name: 'Theo thời gian',
                    child: Row(
                      children: [
                        Expanded(
                          child: DatePickerButton(
                            title: 'Ngày bắt đầu',
                            initialDate: state.pickedStartDate,
                            onPickDate: context
                                .read<FilterContentCubit>()
                                .updateStartDate,
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
                            initialDate: state.pickedEndDate,
                            onPickDate: context
                                .read<FilterContentCubit>()
                                .updateEndDate,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            if (!widget.showTime) ...[
              FilterSection(
                name: 'Theo tên',
                child: BaseInput(
                  controller: _targetNameController,
                  hintText: 'Nhập tên đối tượng',
                  backgroundColor: Colors.grey[300],
                ),
              ),
              BlocBuilder<FilterContentCubit, FilterContentState>(
                buildWhen: (previous, current) =>
                    previous.fbPageType != current.fbPageType,
                builder: (context, state) {
                  return FilterSection(
                    name: 'Theo dạng trang',
                    child: WrapOptions(
                      builderItem: (index) {
                        final currentFbType = FbPageType.values[index];
                        final isSelected = state.fbPageType == currentFbType;
                        return SelectableContainer(
                          content: currentFbType.title,
                          isSelected: isSelected,
                          onTap: () => context
                              .read<FilterContentCubit>()
                              .updateFbPageType(
                                  isSelected ? null : currentFbType),
                        );
                      },
                      length: FbPageType.values.length,
                    ),
                  );
                },
              ),
            ],
            BlocBuilder<FilterContentCubit, FilterContentState>(
              builder: (context, state) {
                return FilterSection(
                  name: 'Theo đơn vị quản lý',
                  child: UnitSelector(
                    currentUnit: state.currentUnit,
                    stepUnitsList: state.stepUnitsList,
                    subUnitsList: state.subUnitsList,
                    onSelectUnit: context.read<FilterContentCubit>().fetchUnits,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
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
            label: Icon(
              Icons.check_circle,
              size: 16,
              color: Theme.of(context).primaryColor,
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
