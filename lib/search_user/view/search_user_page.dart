import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/search_user/bloc/search_user_bloc.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/widgets/border_container.dart';
import 'package:tctt_mobile/widgets/inputs.dart';
import 'package:tctt_mobile/widgets/loader.dart';
import 'package:tctt_mobile/widgets/rich_list_view.dart';
import 'package:user_repository/user_repository.dart';

class SearchUser extends StatelessWidget {
  const SearchUser({super.key});

  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => SearchUserBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context)),
        child: const SearchUser(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Builder(builder: (context) {
          return SearchInput(
            onChanged: (text) => context
                .read<SearchUserBloc>()
                .add(SearchInputChangeEvent(text)),
          );
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(onPressed: () {}, child: const Text('Tạo nhóm')),
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<SearchUserBloc, SearchUserState>(
          builder: (context, state) {
            switch (state.status) {
              case FetchDataStatus.loading:
                return const Loader();
              case FetchDataStatus.failure:
                return const Text('Đã xảy ra lỗi');
              default:
                return Container(
                  color: Colors.white,
                  child: RichListView(
                    hasReachedMax: true,
                    itemCount: state.users.length,
                    itemBuilder: (index) {
                      final currentUser = state.users[index];
                      return BottomBorderContainer(
                        borderWidth: 1,
                        borderColor: Colors.grey[300] ?? Colors.grey,
                        child: ListTile(
                          title: Text(currentUser.username),
                          subtitle: Text(currentUser.name),
                        ),
                      );
                    },
                    onReachedEnd: () {},
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
