import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_final_test/common/result.dart';
import 'package:flutter_final_test/domain/treding/repository/trending_repository.dart';
import 'package:flutter_final_test/domain/treding/treding.dart';
import 'package:flutter_final_test/infrastucture/datasources/api/api_connection_manager.dart';
import 'package:flutter_final_test/infrastucture/mappers/trending/trending_mapper.dart';

class TrendingRepositoryImpl extends TrendingRepository {
  final IApiConnectionManager _apiConnectionManager;

  TrendingRepositoryImpl({required IApiConnectionManager apiConnectionManager})
      : _apiConnectionManager = apiConnectionManager;

  @override
  Future<Result<Trending>> getTrendingByPage(int? page) async {
    return await _apiConnectionManager.request<Trending>(
        'movie/popular', 'GET', (data) => TrendingMapper.fromJson(data),
        queryParameters: {
          'api_key': dotenv.env['API_KEY']!,
          'page': page,
        });
  }
}
