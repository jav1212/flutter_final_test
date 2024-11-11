import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_final_test/common/result.dart';
import 'package:flutter_final_test/domain/credit/credit.dart';
import 'package:flutter_final_test/domain/credit/repository/credit_repository.dart';
import 'package:flutter_final_test/infrastucture/datasources/api/api_connection_manager.dart';
import 'package:flutter_final_test/infrastucture/mappers/credit/credit_mapper.dart';

class CreditRepositoryImpl extends CreditRepository {
  final IApiConnectionManager _apiConnectionManager;

  CreditRepositoryImpl({required IApiConnectionManager apiConnectionManager})
      : _apiConnectionManager = apiConnectionManager;

  @override
  Future<Result<Credit>> getCreditByMovie(int movieId) async {
    return await _apiConnectionManager.request<Credit>(
      'movie/$movieId/credits',
      'GET',
      (data) => CreditMapper.fromJson(data),
      queryParameters: {
        'api_key': dotenv.env['API_KEY']!,
      },
    );
  }
}
