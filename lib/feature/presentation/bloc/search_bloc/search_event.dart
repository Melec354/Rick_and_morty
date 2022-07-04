import 'package:equatable/equatable.dart';

abstract class PersonSearchEvent extends Equatable {
  const PersonSearchEvent();
  @override
  List<Object?> get props => [];
}

class SearchPerson extends PersonSearchEvent {
  final String personQuery;

  const SearchPerson(this.personQuery);

}