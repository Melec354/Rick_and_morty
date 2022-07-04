import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_update1/core/error/exepsion.dart';
import 'package:rick_and_morty_update1/core/error/failure.dart';
import 'package:rick_and_morty_update1/core/platform/network_info.dart';
import 'package:rick_and_morty_update1/feature/data/datasources/person_local_datasource.dart';
import 'package:rick_and_morty_update1/feature/data/datasources/person_remote_datasource.dart';
import 'package:rick_and_morty_update1/feature/domain/entities/person_entities.dart';
import 'package:rick_and_morty_update1/feature/domain/repositories/person_repository.dart';

import '../models/person_model.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPerson(int page) async {
    return await _getPersons(() => remoteDataSource.getAllPersons(page));
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(
      int page, String query) async {
    return await _getPersons(() => remoteDataSource.searchPerson(page, query));
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationPerson = await localDataSource.getLastPersonsFromCache();
        return Right(locationPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
