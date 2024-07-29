part of 'new_member_bloc.dart';

class NewMemberState extends Equatable {
  const NewMemberState({
    this.status = FormzSubmissionStatus.initial,
    this.name = const Content.pure(),
    this.username = const Content.pure(),
    this.password = const Password.pure(),
    this.repeatPass = const Password.pure(),
    this.role = ERole.member,
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Content name;
  final Content username;
  final Password password;
  final Password repeatPass;
  final ERole role;
  final bool isValid;

  NewMemberState copyWith({
    Content? name,
    Content? username,
    FormzSubmissionStatus? status,
    Password? password,
    Password? repeatPass,
    ERole? role,
    bool? isValid,
  }) {
    return NewMemberState(
      name: name ?? this.name,
      username: username ?? this.username,
      status: status ?? this.status,
      password: password ?? this.password,
      repeatPass: repeatPass ?? this.repeatPass,
      role: role ?? this.role,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        status,
        username,
        name,
        password,
        repeatPass,
        role,
        isValid,
      ];
}

extension NewMemberStateX on NewMemberState {
  bool get confirmPass => password == repeatPass;
}
