import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/core/theme/colors.dart';
import 'package:tctt_mobile/core/utils/extensions.dart';
import 'package:tctt_mobile/features/member_manager/bloc/member_manager_bloc.dart';
import 'package:tctt_mobile/features/new_member/view/new_member_page.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/widgets/loader.dart';
import 'package:tctt_mobile/shared/widgets/rich_list_view.dart';
import 'package:user_repository/user_repository.dart';

class MemberItem extends StatelessWidget {
  const MemberItem({
    super.key,
    required String name,
    required String role,
    required VoidCallback? onPressed,
  })  : _name = name,
        _role = role;

  final String _name;
  final String _role;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                  'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8dXNlcnN8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _name,
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Color(0xFF14181B),
                        fontSize: 14,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        _role,
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: AppColors.primary,
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const Icon(
            //   Icons.more_vert,
            //   color: AppColors.primary,
            //   size: 24,
            // ),
          ],
        ),
      ),
    );
  }
}

class MemberManager extends StatelessWidget {
  const MemberManager(
      {super.key, required this.unitId, required this.currentUnitName});

  static Route<void> route(String unitId, String currentUnitName) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (context) => MemberManagerBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
          unitId: unitId,
        )..add(const UserFetchedEvent()),
        child: MemberManager(currentUnitName: currentUnitName, unitId: unitId),
      ),
    );
  }

  final String currentUnitName;
  final String unitId;

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
          'Thành viên',
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 4),
                    child: Text(
                      currentUnitName.capitalize(),
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Icon(
                            Icons.person_add_rounded,
                            color: Color(0xFF14181B),
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: Builder(builder: (context) {
                            return InkWell(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    NewMemberPage.route(
                                        unitId, currentUnitName));
                                if (!context.mounted) return;
                                context
                                    .read<MemberManagerBloc>()
                                    .add(const UserReFetchedEvent());
                              },
                              child: const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
                                child: Text(
                                  'Thêm thành viên',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF14181B),
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Expanded(
                      child: BlocBuilder<MemberManagerBloc, MemberManagerState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case FetchDataStatus.initial:
                          return const Loader();
                        default:
                          if (state.status.isLoading && state.users.isEmpty) {
                            return const Loader();
                          }
                          return RichListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            hasReachedMax: state.hasReachedMax,
                            itemCount: state.users.length,
                            onRefresh: () async {
                              context
                                  .read<MemberManagerBloc>()
                                  .add(const UserReFetchedEvent());
                            },
                            itemBuilder: (index) {
                              final currentUser = state.users[index];
                              return Dismissible(
                                key: Key(currentUser.id),
                                onDismissed: (direction) {
                                  context
                                      .read<MemberManagerBloc>()
                                      .add(UserDeletedEvent(currentUser.id));
                                },
                                background: Container(
                                  color: Colors.red,
                                  child: const Icon(Icons.delete,
                                      color: Colors.white),
                                ),
                                child: MemberItem(
                                    name: currentUser.name,
                                    role: currentUser.username,
                                    onPressed: () {}),
                              );
                            },
                            onReachedEnd: () {
                              context
                                  .read<MemberManagerBloc>()
                                  .add(const UserFetchedEvent());
                            },
                          );
                      }
                    },
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
