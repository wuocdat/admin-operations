import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/conversation/view/conversation_page.dart';
import 'package:tctt_mobile/search_user/bloc/search_user_bloc.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/widgets/border_container.dart';
import 'package:tctt_mobile/widgets/chips.dart';
import 'package:tctt_mobile/widgets/inputs.dart';
import 'package:tctt_mobile/widgets/loading_overlay.dart';
import 'package:tctt_mobile/widgets/rich_list_view.dart';
import 'package:user_repository/user_repository.dart';

class SearchUser extends StatelessWidget {
  const SearchUser({super.key});

  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => SearchUserBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
        ),
        child: const SearchUser(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BlocBuilder<SearchUserBloc, SearchUserState>(
          builder: (context, state) {
            return IconButton(
              icon: Icon(
                state.groupMode ? Icons.close : Icons.chevron_left,
                size: state.groupMode ? 24 : 30,
              ),
              onPressed: () {
                if (state.groupMode) {
                  context.read<SearchUserBloc>().add(const ModeChangedEvent());
                } else if (!state.creatingStatus.isLoading) {
                  Navigator.pop(context);
                }
              },
            );
          },
        ),
        backgroundColor: Colors.white,
        title: BlocBuilder<SearchUserBloc, SearchUserState>(
          builder: (context, state) {
            return state.groupMode
                ? ListTile(
                    title: const Text('Nhóm mới'),
                    subtitle: Text('Đã chọn: ${state.pickedUsers.length}'),
                    contentPadding: const EdgeInsets.all(0),
                  )
                : SearchInput(
                    readOnly: state.creatingStatus.isLoading,
                    hintText: "Tìm tên hoặc số điện thoại",
                    onChanged: (text) => context
                        .read<SearchUserBloc>()
                        .add(SearchInputChangeEvent(text)),
                  );
          },
        ),
        actions: [
          BlocBuilder<SearchUserBloc, SearchUserState>(
            buildWhen: (previous, current) =>
                previous.groupMode != current.groupMode,
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: state.groupMode
                    ? TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Tạo',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    : TextButton(
                        // onPressed: !state.creatingStatus.isLoading
                        //     ? () => context
                        //         .read<SearchUserBloc>()
                        //         .add(const ModeChangedEvent())
                        //     : null,
                        onPressed: () => ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(const SnackBar(
                              content: Text('Tính năng đang được phát triển'))),
                        child: const Text('Tạo nhóm'),
                      ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<SearchUserBloc, SearchUserState>(
          listener: (context, state) {
            if (state.creatingStatus.isSuccess &&
                state.conversationId != null) {
              Navigator.pushReplacement(
                  context, ConversationPage.route(state.conversationId!));
            }
          },
          builder: (context, state) {
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  if (state.groupMode) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: BaseInput(
                        hintText: "Đặt tên nhóm",
                        onChanged: (text) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: BaseInput(
                        leading: const Icon(Icons.search),
                        backgroundColor: Colors.grey[100],
                        hintText: "Tìm tên hoặc số điện thoại",
                        onChanged: (text) => context
                            .read<SearchUserBloc>()
                            .add(SearchInputChangeEvent(text)),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: <Widget>[
                          ...state.pickedUsers.map(
                            (e) => CloseChip(
                              text: e.username,
                              onClose: () => context
                                  .read<SearchUserBloc>()
                                  .add(CheckBoxStatusChangeEvent(false, e)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                  Expanded(
                    child: LoadingOverlay(
                      opacity: 0.1,
                      overlayColor: Colors.grey,
                      isLoading: state.status.isLoading ||
                          state.creatingStatus.isLoading,
                      child: RichListView(
                        hasReachedMax: state.hasReachedMax,
                        itemCount: state.users.length,
                        itemBuilder: (index) {
                          final currentUser = state.users[index];
                          return UserItem(
                            currentUser: currentUser,
                            showCheckBox: state.groupMode,
                            isPicked: state.pickedUsers.contains(currentUser),
                          );
                        },
                        onReachedEnd: () => context
                            .read<SearchUserBloc>()
                            .add(const UserFetchedEvent()),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.currentUser,
    required this.showCheckBox,
    required this.isPicked,
  });

  final ShortProfile currentUser;
  final bool showCheckBox;
  final bool isPicked;

  @override
  Widget build(BuildContext context) {
    return BottomBorderContainer(
      borderWidth: 1,
      borderColor: Colors.grey[300] ?? Colors.grey,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 0, right: 0),
        leading: showCheckBox
            ? Checkbox(
                shape: const CircleBorder(),
                value: isPicked,
                onChanged: (value) => context
                    .read<SearchUserBloc>()
                    .add(CheckBoxStatusChangeEvent(value ?? true, currentUser)),
              )
            : null,
        title: Text(currentUser.username),
        subtitle: Text(currentUser.name),
        onTap: () {
          if (!showCheckBox) {
            context.read<SearchUserBloc>().add(
                  OneByOneConversationCreatedEvent(currentUser.id),
                );
          } else {
            context
                .read<SearchUserBloc>()
                .add(CheckBoxStatusChangeEvent(!isPicked, currentUser));
          }
        },
      ),
    );
  }
}
