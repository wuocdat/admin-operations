import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/features/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/features/search_user_by_unit/bloc/search_user_by_unit_bloc.dart';
import 'package:tctt_mobile/features/search_user_by_unit/widgets/unit_selector.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/widgets/border_container.dart';
import 'package:tctt_mobile/shared/widgets/loader.dart';
import 'package:tctt_mobile/shared/widgets/loading_overlay.dart';
import 'package:tctt_mobile/shared/widgets/rich_list_view.dart';
import 'package:units_repository/units_repository.dart';
import 'package:user_repository/user_repository.dart';

class SearchUserByUnitPage extends StatelessWidget {
  const SearchUserByUnitPage({super.key});

  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => SearchUserByUnitBloc(
          unitsRepository: RepositoryProvider.of<UnitsRepository>(context),
          userRepository: RepositoryProvider.of<UserRepository>(context),
        )..add(const RootUserFetchedEvent()),
        child: const SearchUserByUnitPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId =
        context.select((AuthenticationBloc bloc) => bloc.state.user.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Người dùng theo đơn vị',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Urbanist',
                letterSpacing: 0,
              ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<SearchUserByUnitBloc, SearchUserByUnitState>(
            builder: (context, state) {
              return (state.isInitialLoading)
                  ? const Loader()
                  : Column(
                      children: [
                        UnitSelector(
                          currentUnit: state.currentUnit,
                          stepUnitsList: state.stepUnitsList,
                          subUnitsList: state.subUnitsList,
                          onSelectUnit: (selectedUnit) {
                            context.read<SearchUserByUnitBloc>().add(
                                UnitSelectedEvent(selectedUnit: selectedUnit));
                          },
                        ),
                        Expanded(
                          child: LoadingOverlay(
                            opacity: 0.1,
                            overlayColor: Colors.grey,
                            isLoading: state.status.isLoading,
                            child: RichListView(
                              hasReachedMax: true,
                              itemCount: state.users.length,
                              itemBuilder: (index) {
                                final currentUser = state.users[index];
                                return (currentUserId == currentUser.id)
                                    ? Container()
                                    : UserItem(currentUser: currentUser);
                              },
                              onReachedEnd: () {},
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.currentUser,
  });

  final ShortProfile currentUser;

  @override
  Widget build(BuildContext context) {
    return BottomBorderContainer(
      borderWidth: 1,
      borderColor: Colors.grey[300] ?? Colors.grey,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 0, right: 0),
        title: Text(currentUser.username),
        subtitle: Text(currentUser.name),
        onTap: () {},
      ),
    );
  }
}

extension on SearchUserByUnitState {
  bool get isInitialLoading => status.isLoading && stepUnitsList.isEmpty;
}
