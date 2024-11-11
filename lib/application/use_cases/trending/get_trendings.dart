import 'package:flutter_final_test/common/result.dart';
import 'package:flutter_final_test/common/use_case.dart';
import 'package:flutter_final_test/domain/treding/repository/trending_repository.dart';
import 'package:flutter_final_test/domain/treding/treding.dart';

class GetTrendingUseCaseInput extends IUseCaseInput {
  final int page;
  GetTrendingUseCaseInput({required this.page});
}

class GetTrendingsUseCase extends IUseCase<GetTrendingUseCaseInput, Trending> {
  final TrendingRepository trendingRepository;

  GetTrendingsUseCase({required this.trendingRepository});

  @override
  Future<Result<Trending>> execute(GetTrendingUseCaseInput params) async {
    return await trendingRepository.getTrendingByPage(params.page);
  }
}
