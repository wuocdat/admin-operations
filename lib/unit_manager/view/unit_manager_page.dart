import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tctt_mobile/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/member_manager/view/member_manager_page.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/theme/colors.dart';
import 'package:tctt_mobile/unit_manager/bloc/unit_manager_bloc.dart';
import 'package:tctt_mobile/widgets/contained_button.dart';
import 'package:tctt_mobile/widgets/empty_list_message.dart';
import 'package:tctt_mobile/widgets/loader.dart';
import 'package:tctt_mobile/widgets/rich_list_view.dart';
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

class UnitManager extends StatelessWidget {
  const UnitManager({super.key, required this.parentId});

  final String parentId;

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
          child: BlocProvider(
            create: (context) => UnitManagerBloc(
                repository: RepositoryProvider.of<UnitsRepository>(context))
              ..add(UnitFetchedEvent(parentId)),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return Container(
                  color: Colors.white,
                  child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 12, 0, 12),
                            child: Text(
                              state.user.unit.name,
                              style: const TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 12, 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                WhiteCustomtButton(
                                    text: 'Thành viên',
                                    icon: Icons.group,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                            MemberManager(unitId: state.user.unit.id)));
                                    }),
                                const SizedBox(width: 16),
                                CustomButton(
                                    text: 'Thêm đơn vị',
                                    icon: Icons.add,
                                    onPressed: () {}),
                              ],
                            ),
                          ),
                          Expanded(child:
                              BlocBuilder<UnitManagerBloc, UnitManagerState>(
                                  builder: (context, state) {
                            switch (state.status) {
                              case FetchDataStatus.initial:
                                return const Loader();
                              default:
                                if (state.status.isLoading &&
                                    state.units.isEmpty) {
                                  return const Loader();
                                }
                                if (state.units.isEmpty) {
                                  return const EmptyListMessage(
                                    message: "co du lieu",
                                  );
                                }
                                return RichListView(
                                  hasReachedMax: state.hasReachedMax,
                                  itemCount: state.units.length,
                                  itemBuilder: (index) => CustomPadding(
                                    text: state.units[index].name,
                                    onPressed: () {},
                                    // onPressed: () async {}
                                  ),
                                  onReachedEnd: () {
                                    // context.read<UnitManagerBloc>().add(const UnitFetchedEvent(state.units.id));;);
                                  },
                                );
                            }
                          }))
                        ],
                      )),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
