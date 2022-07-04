import 'package:flutter/material.dart';
import 'package:rick_and_morty_update1/common/app_colors.dart';
import 'package:rick_and_morty_update1/feature/presentation/widgets/person_cache_image_widget.dart';

import '../../domain/entities/person_entities.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;

  const PersonDetailPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              person.name,
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Container(
              child: PersonCacheImage(
                  imageUrl: person.image, width: 260, heigth: 260),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: person.status == "Alive" ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  person.status,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                )
              ],
            ),
            const SizedBox(height: 16),
            if (person.type.isNotEmpty) ...buildText("Type", person.type),
            ...buildText("Gender", person.gender),
            ...buildText(
                "Number of episodes", person.episode.length.toString()),
            ...buildText("Species", person.species),
            ...buildText("Last know location", person.location.name),
            ...buildText("Origin", person.origin.name),
            ...buildText("Was created", person.location.name),
            ...buildText("Last know location", person.created.toString()),
          ],
        ),
      ),
    );
  }

  List<Widget> buildText(String text, String value) {
    return [
      Text(
        text,
        style: TextStyle(color: AppColors.greyColor),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: TextStyle(color: Colors.white),
      ),
      const SizedBox(height: 12),
    ];
  }
}
