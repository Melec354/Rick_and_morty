import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_update1/core/usecases/usecase.dart';
import 'package:rick_and_morty_update1/feature/domain/repositories/person_repository.dart';

import '../../../core/error/failure.dart';
import '../entities/person_entities.dart';

class SearchAllPersons extends UseCase<List<PersonEntity>, SearchPersonParams> {
  final PersonRepository personRepository;

  SearchAllPersons(this.personRepository);

  Future<Either<Failure, List<PersonEntity>>> call(
      SearchPersonParams params) async {
    return await personRepository.searchPerson(params.page, params.query);
  }
}

class SearchPersonParams extends Equatable {
  final String query;
  final int page;

  const SearchPersonParams({required this.page, required this.query});

  @override
  // TODO: implement props
  List<Object?> get props => [query, page];
}
