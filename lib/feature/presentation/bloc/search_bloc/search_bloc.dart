import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_update1/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty_update1/feature/presentation/bloc/search_bloc/search_state.dart';
import 'dart:async';

import '../../../../core/error/failure.dart';
import '../../../domain/entities/person_entities.dart';
import '../../../domain/usecases/search_person.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchAllPersons searchPerson;

  int page = 1;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty()) {
    on<SearchPerson>(_onEvent);
  }

  FutureOr<void> _onEvent(
      SearchPerson event, Emitter<PersonSearchState> emit) async {
    final currentState = state;
    var oldPerson = <PersonEntity>[];
    var oldQuery = '';
    bool isFullList = false;
    if (currentState is PersonSearchLoaded) {
      oldPerson = currentState.persons;
      oldQuery = currentState.oldQuery;
      isFullList = currentState.isFullList;
    }

    if (oldQuery != '' && oldQuery != event.personQuery) {
      page = 1;
      oldPerson = <PersonEntity>[];
      isFullList = false;
    }

    if (isFullList && oldQuery == event.personQuery) {
      emit(PersonSearchLoaded(event.personQuery, true, persons: oldPerson));
      return;
    }

    emit(PersonSearchLoading(oldPerson, isFirstFetch: page == 1));

    final failureOrPerson = await searchPerson(
        SearchPersonParams(query: event.personQuery, page: page));
    emit(failureOrPerson.fold((failure) {
      if (oldPerson.isEmpty) {
        return PersonSearchError(message: _mapFailureToMessage(failure));
      } else {
        return PersonSearchLoaded(event.personQuery, true, persons: oldPerson);
      }
    }, (person) {
      page++;
      final persons = (state as PersonSearchLoading).oldPersonList;
      persons.addAll(person);
      return PersonSearchLoaded(event.personQuery, false, persons: persons);
    }));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
