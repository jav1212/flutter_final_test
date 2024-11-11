import 'package:flutter_final_test/common/result.dart';
import 'package:flutter_final_test/domain/actor/actor.dart';

abstract class ActorRepository {
  Future<Result<List<Actor>>> getActorsByMovie(String movieId);
}
