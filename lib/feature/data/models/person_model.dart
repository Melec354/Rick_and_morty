import 'package:rick_and_morty_update1/feature/data/models/location_model.dart';
import 'package:rick_and_morty_update1/feature/domain/entities/person_entities.dart';

class PersonModel extends PersonEntity {
  const PersonModel(
      {required int id,
      required String name,
      required String status,
      required String species,
      required String type,
      required String gender,
      required origin,
      required location,
      required String image,
      required List<String> episode,
      required DateTime created})
      : super(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: origin,
            location: location,
            image: image,
            episode: episode,
            created: created);

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      gender: json['gender'],
      species: json['species'],
      created: DateTime.parse(json['created'] as String),
      status: json['status'],
      origin: json["origin"] != null
          ? LocationModel.fromJson(json['origin'])
          : null,
      image: json['image'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      episode:
          (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin,
      'location': location,
      'image': image,
      'episode': episode,
      'created': created.toIso8601String()
    };
  }
}
