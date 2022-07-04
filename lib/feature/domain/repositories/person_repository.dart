import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_update1/feature/domain/entities/person_entities.dart';

import '../../../core/error/failure.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllPerson(int page);
  Future<Either<Failure, List<PersonEntity>>> searchPerson(
      int page, String query);
}
