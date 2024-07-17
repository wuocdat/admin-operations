import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/core/theme/colors.dart';
import 'package:tctt_mobile/features/unit_manager/bloc/unit_manager_bloc.dart';
import 'package:tctt_mobile/shared/widgets/contained_button.dart';
import 'package:tctt_mobile/shared/widgets/rich_list_view.dart';
import 'package:units_repository/units_repository.dart';

class CustomPadding extends StatelessWidget {
  const CustomPadding({
    super.key,
    required String text,
    required VoidCallback? onPressed,
  }) : _text = text;

  final String _text;

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
              const Icon(
                Icons.more_vert,
                color: Colors.black,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WhiteCustomtButton extends StatelessWidget {
  const WhiteCustomtButton({
    super.key,
    required String text,
    required IconData icon,
    required VoidCallback? onPressed,
  })  : _text = text,
        _icon = icon;

  final String _text;
  final IconData _icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            elevation: 6,
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

  static Route<void> route(String unitId) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (context) => UnitManagerBloc(
            unitsRepository: RepositoryProvider.of<UnitsRepository>(context))
          ..add(ChildUnitsFetchedEvent(parentUnitId: unitId)),
        child: const UnitManagerPage(),
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
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        WhiteCustomtButton(
                            text: 'Thành viên',
                            icon: Icons.group,
                            onPressed: () {}),
                        const SizedBox(width: 16),
                        CustomButton(
                            text: 'Thêm đơn vị',
                            icon: Icons.add,
                            onPressed: () {}),
                      ],
                    ),
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
                            return CustomPadding(
                                text: currentUnit.name, onPressed: () {});
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
