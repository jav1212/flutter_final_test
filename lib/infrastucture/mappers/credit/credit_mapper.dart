import 'package:flutter_final_test/domain/credit/credit.dart';
import 'package:flutter_final_test/infrastucture/mappers/actor/actor_mapper.dart';

class CreditMapper {
  static Credit fromJson(Map<String, dynamic> json) {
    return Credit(
      id: json["id"],
      cast: ActorMapper.fromJsonList(json["cast"]),
    );
  }
}
