import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_update1/feature/domain/entities/person_entities.dart';

abstract class PersonSearchState extends Equatable {
  const PersonSearchState();
  @override
  List<Object?> get props => [];
}

class PersonEmpty extends PersonSearchState {}

class PersonSearchLoading extends PersonSearchState {
  final List<PersonEntity> oldPersonList;
  final bool isFirstFetch;

  const PersonSearchLoading(this.oldPersonList, {this.isFirstFetch = false});

  @override
  // TODO: implement props
  List<Object?> get props => [oldPersonList];
}

class PersonSearchLoaded extends PersonSearchState {
  final List<PersonEntity> persons;
  final String oldQuery;
  final bool isFullList;

  const PersonSearchLoaded(this.oldQuery, this.isFullList,
      {required this.persons});
  @override
  List<Object?> get props => [persons, oldQuery, isFullList];
}

class PersonSearchError extends PersonSearchState {
  final String message;

  const PersonSearchError({required this.message});
  @override
  List<Object?> get props => [message];
}
