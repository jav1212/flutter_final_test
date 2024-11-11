import 'package:flutter_final_test/common/result.dart';
import 'package:flutter_final_test/domain/credit/credit.dart';

abstract class CreditRepository {
  Future<Result<Credit>> getCreditByMovie(int movieId);
}
