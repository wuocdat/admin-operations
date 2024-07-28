import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:formz/formz.dart';
import 'package:tctt_mobile/core/theme/colors.dart';
import 'package:tctt_mobile/core/utils/extensions.dart';
import 'package:tctt_mobile/features/member_manager/view/member_manager_page.dart';
import 'package:tctt_mobile/features/unit_manager/bloc/unit_manager_bloc.dart';
import 'package:tctt_mobile/features/unit_manager/widgets/create_unit_container.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/widgets/rich_list_view.dart';
import 'package:units_repository/units_repository.dart';

class UnitItem extends StatelessWidget {
  const UnitItem({
    super.key,
    required String text,
    required VoidCallback? onPressed,
  })  : _text = text,
        _onPressed = onPressed;

  final String _text;
  final VoidCallback? _onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 0,
              color: Color(0xFFE0E3E7),
              offset: Offset(0.0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(0),
          shape: BoxShape.rectangle,
        ),
        child: InkWell(
          onTap: _onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 4,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Text(
                      _text,
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WhiteButton extends StatelessWidget {
  const WhiteButton({
    super.key,
    required String text,
    required IconData icon,
    required VoidCallback? onPressed,
  })  : _text = text,
        _icon = icon,
        _onPressed = onPressed;

  final String _text;
  final IconData _icon;
  final VoidCallback? _onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        child: ElevatedButton(
          onPressed: _onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            elevation: 1,
            textStyle: const TextStyle(
                fontSize: 13,
                fontFamily: 'Plus Jakarta Sans',
                letterSpacing: 0,
                fontWeight: FontWeight.bold),
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primary,
            minimumSize: const Size(0, 28),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _icon,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(_text),
            ],
          ),
        ),
      ),
    );
  }
}

class UnitManagerPage extends StatelessWidget {
  const UnitManagerPage({super.key});

  static Route<void> route(String unitId, String unitTypeId) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (context) => UnitManagerBloc(
          unitsRepository: RepositoryProvider.of<UnitsRepository>(context),
        )..add(ChildUnitsFetchedEvent(
            parentUnitId: unitId, parentUnitTypeId: unitTypeId)),
        child: MultiBlocListener(
          listeners: [
            BlocListener<UnitManagerBloc, UnitManagerState>(
              listenWhen: (previous, current) =>
                  previous.formStatus != current.formStatus,
              listener: (context, state) {
                switch (state.formStatus) {
                  case FormzSubmissionStatus.success:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tạo mới thành công'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    break;
                  case FormzSubmissionStatus.failure:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tạo mới thất bại'),
                      ),
                    );
                    break;
                  default:
                    break;
                }
              },
            ),
            BlocListener<UnitManagerBloc, UnitManagerState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                switch (state.status) {
                  // case FetchDataStatus.success:
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content: Text('Đã xóa'),
                  //       backgroundColor: Colors.green,
                  //     ),
                  //   );
                  //   context.read<UnitManagerBloc>().add(ChildUnitsFetchedEvent(
                  //       parentUnitId: state.currentUnit.id,
                  //       parentUnitTypeId: state.currentUnit.type["_id"]));
                  //   break;
                  case FetchDataStatus.failure:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Thất bại'),
                      ),
                    );
                    break;
                  default:
                    break;
                }
              },
            ),
          ],
          child: const UnitManagerPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Danh bạ đơn vị',
          style: TextStyle(
            fontFamily: 'Urbanest',
            letterSpacing: 0,
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<UnitManagerBloc, UnitManagerState>(
        builder: (context, state) {
          return FloatingActionButton.small(
            onPressed: () async {
              final reload = await showModalBottomSheet<bool>(
                context: context,
                isScrollControlled: true,
                builder: (_) {
                  return BlocProvider.value(
                    value: BlocProvider.of<UnitManagerBloc>(context),
                    child: BlocBuilder<UnitManagerBloc, UnitManagerState>(
                      builder: (context, state) {
                        return CreateUnitContainer(
                          initialUnitName: state.unitName.value,
                          initialUnitTypeId: state.unitTypeId,
                        );
                      },
                    ),
                  );
                },
              );

              if (!context.mounted) return;

              if (reload ?? false) {
                context.read<UnitManagerBloc>().add(ChildUnitsFetchedEvent(
                    parentUnitId: state.currentUnit.id,
                    parentUnitTypeId: state.currentUnit.type["_id"]));
              }
            },
            child: const Icon(Icons.add),
          );
        },
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocSelector<UnitManagerBloc, UnitManagerState, String>(
                    selector: (state) {
                      return state.currentUnit.name;
                    },
                    builder: (context, unitName) {
                      return Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                        child: Text(
                          unitName,
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocSelector<UnitManagerBloc, UnitManagerState, Unit>(
                        selector: (state) {
                          return state.currentUnit;
                        },
                        builder: (context, unit) {
                          return WhiteButton(
                            text: 'Thành viên',
                            icon: Icons.group,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MemberManager.route(unit.id,
                                      "${unit.type["name"]} ${unit.name}"));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<UnitManagerBloc, UnitManagerState>(
                      builder: (context, state) {
                        return RichListView(
                          hasReachedMax: true,
                          itemCount: state.childUnits.length,
                          onReachedEnd: () {},
                          itemBuilder: (index) {
                            final currentUnit = state.childUnits[index];
                            return Slidable(
                              key: ValueKey(index),
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) {
                                      Navigator.push(
                                          context,
                                          MemberManager.route(
                                            state.currentUnit.id,
                                            "${currentUnit.type["name"]} ${currentUnit.name}",
                                          ));
                                    },
                                    backgroundColor: const Color(0xFF2ecc71),
                                    foregroundColor: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      bottomLeft: Radius.circular(4),
                                    ),
                                    icon: Icons.manage_accounts,
                                    label: 'Thành viên',
                                  ),
                                ],
                              ),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) {
                                      context.read<UnitManagerBloc>().add(
                                          UnitDeletedEvent(currentUnit.id));
                                    },
                                    backgroundColor: const Color(0xFFe74c3c),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Xoá',
                                  ),
                                  // const SlidableAction(
                                  //   onPressed: null,
                                  //   backgroundColor: Color(0xFF3498db),
                                  //   foregroundColor: Colors.white,
                                  //   borderRadius: BorderRadius.only(
                                  //     topRight: Radius.circular(4),
                                  //     bottomRight: Radius.circular(4),
                                  //   ),
                                  //   icon: Icons.edit,
                                  //   label: 'Sửa',
                                  // ),
                                ],
                              ),
                              child: UnitItem(
                                text:
                                    "${currentUnit.type["name"]} ${currentUnit.name}"
                                        .capitalize(),
                                onPressed: () {
                                  context
                                      .read<UnitManagerBloc>()
                                      .add(ChildUnitsFetchedEvent(
                                        parentUnitId: currentUnit.id,
                                        parentUnitTypeId:
                                            currentUnit.type["_id"],
                                      ));
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
