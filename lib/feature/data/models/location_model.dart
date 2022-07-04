import 'package:rick_and_morty_update1/feature/domain/entities/person_entities.dart';

class LocationModel extends LocationEntity {
  LocationModel({required String name, required String url})
      : super(name: name, url: url);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(url: json['url'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
    };
  }
}
