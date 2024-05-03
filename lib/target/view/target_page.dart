import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/target/cubit/target_cubit.dart';
import 'package:tctt_mobile/target/widgets/bad_subject/bad_subject.dart';
import 'package:tctt_mobile/target/widgets/media_chanel/media_chanel.dart';
import 'package:tctt_mobile/widgets/border_container.dart';
import 'package:tctt_mobile/widgets/head_bar.dart';
import 'package:tctt_mobile/widgets/inputs.dart';

class TargetPage extends StatelessWidget {
  const TargetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TargetCubit(),
      child: BlocBuilder<TargetCubit, TargetState>(
        builder: (context, state) {
          return Column(
            children: [
              HeadBar<TargetOptions>(
                label: "Đối tượng và Kênh truyền thông của ta",
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
                action: FilterButton(
                  onTap: () {
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return FilterContent();
                      },
                    );
                  },
                ),
              ),
              Expanded(child: getCorrespondingItem(state.selectedOption)),
            ],
          );
        },
      ),
    );
  }
}

class FilterContent extends StatelessWidget {
  const FilterContent({
    super.key,
  });

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
                        onPressed: () {}, child: const Text('Thiết lập lại')),
                    const SizedBox(width: 8),
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Áp dụng')),
                  ],
                ),
              ),
            ),
            FilterSection(
              name: 'Theo tên',
              child: BaseInput(
                hintText: 'Nhập tên đối tượng',
                backgroundColor: Colors.grey[300],
              ),
            ),
            const FilterSection(
                name: 'Theo dạng trang',
                child: SelectableContainer(
                  content: 'Trang cá nhân',
                  isSelected: true,
                )),
          ],
        ));
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

Widget getCorrespondingItem(TargetOptions option) {
  switch (option) {
    case TargetOptions.subject:
      return const BadSubject();
    case TargetOptions.chanel:
      return const MediaChanel();
  }
}
