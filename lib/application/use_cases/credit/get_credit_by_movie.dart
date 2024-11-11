import 'package:flutter_final_test/common/result.dart';
import 'package:flutter_final_test/common/use_case.dart';
import 'package:flutter_final_test/domain/credit/credit.dart';
import 'package:flutter_final_test/domain/credit/repository/credit_repository.dart';

class GetCreditByMovieUseCaseInput extends IUseCaseInput {
  final int movieId;
  GetCreditByMovieUseCaseInput({required this.movieId});
}

class GetCreditByMovieUseCase
    extends IUseCase<GetCreditByMovieUseCaseInput, Credit> {
  final CreditRepository creditRepository;

  GetCreditByMovieUseCase({required this.creditRepository});

  @override
  Future<Result<Credit>> execute(GetCreditByMovieUseCaseInput params) async {
    return await creditRepository.getCreditByMovie(params.movieId);
  }
}
