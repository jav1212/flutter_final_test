import 'package:flutter_final_test/common/result.dart';
import 'package:flutter_final_test/domain/treding/treding.dart';

abstract class TrendingRepository {
  Future<Result<Trending>> getTrendingByPage(int? page);
}
