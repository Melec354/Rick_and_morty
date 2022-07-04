import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_update1/core/error/exepsion.dart';
import 'package:rick_and_morty_update1/feature/data/models/person_model.dart';
import 'package:http/http.dart' as http;

abstract class PersonRemoteDataSource {
  Future<List<PersonModel>> getAllPersons(int page);
  Future<List<PersonModel>> searchPerson(int page, String query);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonFromUrl(
      "https://rickandmortyapi.com/api/character/?page=$page");

  @override
  Future<List<PersonModel>> searchPerson(int page, String query) =>
      _getPersonFromUrl(
          "https://rickandmortyapi.com/api/character/?page=$page&name=$query");

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    if (kDebugMode) {
      print(url);
    }
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
