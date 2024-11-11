import 'package:flutter_final_test/domain/actor/actor.dart';

class ActorMapper {
  static Actor fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['id'],
      adult: json['adult'],
      genre: json['genre'] ?? 0,
      known_for_department: json['known_for_department'],
      name: json['name'],
      original_name: json['original_name'],
      popularity: json['popularity'],
      profile_path: json['profile_path'] ?? '',
      cast_id: json['cast_id'],
      character: json['character'],
      credit_id: json['credit_id'],
      order: json['order'],
    );
  }

  static List<Actor> fromJsonList(dynamic jsonList) {
    return jsonList.map<Actor>((json) => fromJson(json)).toList();
  }
}
