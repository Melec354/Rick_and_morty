import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_update1/feature/domain/entities/person_entities.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PersonEmpty extends PersonState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PersonLoading extends PersonState {
  final List<PersonEntity> oldPersonList;
  final bool isFirstFetch;

  const PersonLoading(this.oldPersonList, {this.isFirstFetch = false});

  @override
  // TODO: implement props
  List<Object?> get props => [oldPersonList];
}

class PersonLoaded extends PersonState {
  final List<PersonEntity> personList;

  const PersonLoaded(this.personList);

  @override
  // TODO: implement props
  List<Object?> get props => [personList];
}

class PersonError extends PersonState {
  final String message;

  const PersonError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
