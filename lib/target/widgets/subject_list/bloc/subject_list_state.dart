part of 'subject_list_bloc.dart';

sealed class SubjectListState extends Equatable {
  const SubjectListState();
  
  @override
  List<Object> get props => [];
}

final class SubjectListInitial extends SubjectListState {}
