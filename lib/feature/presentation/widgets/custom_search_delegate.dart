import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_update1/feature/domain/entities/person_entities.dart';
import 'package:rick_and_morty_update1/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty_update1/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty_update1/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty_update1/feature/presentation/widgets/search_result.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomSearchDelegate extends SearchDelegate {
  int page = 1;

  CustomSearchDelegate() : super(searchFieldLabel: 'Search for character....');
  final _suggestions = ['Rick', 'Morty', 'Summer', 'Beth', 'Jerry'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_outlined),
      tooltip: 'Back',
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final scrollController = ScrollController();

    void setupScrollController(BuildContext context, personQuery) {
      scrollController.addListener(() {
        if (scrollController.position.atEdge) {
          if (scrollController.position.pixels != 0) {
            BlocProvider.of<PersonSearchBloc>(context)
                .add(SearchPerson(personQuery));
            //context.read<PersonSearchBloc>().searchPerson(personQuery);
          }
        }
      });
    }

    BlocProvider.of<PersonSearchBloc>(context).add(SearchPerson(query));
    setupScrollController(context, query);

    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
        builder: (context, state) {
      List<PersonEntity> person = [];
      List<PersonEntity> oldPerson = [];
      bool isLoading = false;
      bool isFullList = false;
      String oldQuery = '';

      if (state is PersonSearchLoading && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is PersonSearchLoading) {
        person = state.oldPersonList;
        isLoading = true;
      } else if (state is PersonSearchLoaded) {
        isFullList = state.isFullList;
        isLoading = true;
        person = state.persons;
        oldQuery = state.oldQuery;

        if (person.isEmpty) {
          return _showErrorText('No Characters with that name found');
        }
        oldPerson = state.persons;
      } else if (state is PersonSearchError) {
        return _showErrorText(state.message);
      }

      if (isFullList && query == oldQuery) {
        Fluttertoast.showToast(msg: 'All characters loaded');
      }

      return Container(
        child: ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < person.length) {
              PersonEntity result = person[index];
              return SearchResult(personResult: result);
            } else if (isFullList) {
              return Container();
            } else {
              Timer(const Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
          itemCount:
              person.isNotEmpty ? person.length + (isLoading ? 1 : 0) : 0,
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[400],
            );
          },
        ),
      );
    });
  }

  Widget _showErrorText(String errorMessage) {
    return Container(
      color: Colors.black,
      child: Text(
        errorMessage,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }
    return ListView.separated(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Container(
            child: TextButton(
              onPressed: () {
                query = _suggestions[index];
              },
              child: Text(
                _suggestions[index],
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: _suggestions.length);
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
