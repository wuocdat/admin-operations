import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/target/cubit/target_cubit.dart';
import 'package:tctt_mobile/target/widgets/bad_subject/bad_subject.dart';
import 'package:tctt_mobile/target/widgets/media_chanel/media_chanel.dart';
import 'package:tctt_mobile/widgets/head_bar.dart';

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
                        return FractionallySizedBox(
                            heightFactor: 0.9,
                            child: ListView(
                              children: const [],
                            ));
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
