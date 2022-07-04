import 'package:flutter/material.dart';
import 'package:rick_and_morty_update1/feature/domain/entities/person_entities.dart';
import 'package:rick_and_morty_update1/feature/presentation/pages/person_detail_screen.dart';
import 'package:rick_and_morty_update1/feature/presentation/widgets/person_cache_image_widget.dart';

class SearchResult extends StatelessWidget {
  final PersonEntity personResult;

  const SearchResult({Key? key, required this.personResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonDetailPage(person: personResult)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Container(
                child: PersonCacheImage(
                    imageUrl: personResult.image,
                    width: double.infinity,
                    heigth: double.infinity),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                personResult.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                personResult.location.name,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
