import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/core/utils/extensions.dart';
import 'package:tctt_mobile/features/unit_manager/bloc/unit_manager_bloc.dart';
import 'package:tctt_mobile/shared/widgets/contained_button.dart';
import 'package:tctt_mobile/shared/widgets/dopdown.dart';
import 'package:tctt_mobile/shared/widgets/inputs.dart';
import 'package:tctt_mobile/shared/widgets/label_text.dart';

class CreateUnitContainer extends StatefulWidget {
  const CreateUnitContainer({
    super.key,
    required this.initialUnitName,
    required this.initialUnitTypeId,
  });

  final String initialUnitName;
  final String? initialUnitTypeId;

  @override
  State<CreateUnitContainer> createState() => _CreateUnitContainerState();
}

class _CreateUnitContainerState extends State<CreateUnitContainer> {
  late TextEditingController _unitTextController;

  @override
  void initState() {
    _unitTextController = TextEditingController(text: widget.initialUnitName);
    super.initState();
  }

  @override
  void dispose() {
    _unitTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return BlocBuilder<UnitManagerBloc, UnitManagerState>(
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.only(top: 24, left: 12, right: 12, bottom: bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const MediumLabelText("Thêm đơn vị mới"),
              const SizedBox(height: 24),
              BorderInput(
                controller: _unitTextController,
                labelText: 'Tên đơn vị',
                onChanged: (name) => context
                    .read<UnitManagerBloc>()
                    .add(UnitNameChangedEvent(name)),
              ),
              const SizedBox(height: 24),
              BorderDropdown<String?>(
                labelText: "Loại đơn vị",
                items: state.childUnitTypes
                    .map(
                      (e) => DropdownMenuEntry(
                        value: e.id,
                        label: e.name.isEmpty ? "Khác" : e.name.capitalize(),
                      ),
                    )
                    .toList(),
                initialSelection: widget.initialUnitTypeId,
                onSelected: (type) => type != null
                    ? context
                        .read<UnitManagerBloc>()
                        .add(UnitTypeIdChangedEvent(type))
                    : null,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Thoát")),
                  const SizedBox(width: 24),
                  ContainedButton(
                    onPressed: state.isValid
                        ? () {
                            context
                                .read<UnitManagerBloc>()
                                .add(NewUnitCreatedEvent(
                                  state.unitName.value,
                                  state.currentUnit.id,
                                  state.unitTypeId!,
                                ));
                            Navigator.of(context).pop(true);
                          }
                        : null,
                    text: "Thêm",
                    width: 100,
                    height: 35,
                  )
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
