import 'package:flutter_final_test/common/result.dart';

abstract class IUseCaseInput {}

abstract class IUseCase<I extends IUseCaseInput, O> {
  Future<Result<O>> execute(I params);
}
