import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/target/widgets/bad_subject/cubit/bad_subject_cubit.dart';
import 'package:tctt_mobile/target/widgets/subject_actions/subject_actions.dart';
import 'package:tctt_mobile/target/widgets/subject_list/subject_list.dart';
import 'package:tctt_mobile/widgets/toggle_options.dart';

class BadSubject extends StatelessWidget {
  const BadSubject({super.key});

  static const List<Widget> _widgetOptions = [
    SubjectList(),
    SubjectActions(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BadSubjectCubit(),
      child: BlocBuilder<BadSubjectCubit, int>(
        builder: (context, currentSelectedIndex) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: ToggleOptions(
                    selectedIndex: currentSelectedIndex,
                    items: SubjectViewOption.values
                        .map((e) => Text(e.title))
                        .toList(),
                    onPressed: (int index) {
                      context.read<BadSubjectCubit>().changeOptionIndex(index);
                    },
                  ),
                ),
              ),
              Expanded(
                child: _widgetOptions.elementAt(currentSelectedIndex),
              ),
            ],
          );
        },
      ),
    );
  }
}
