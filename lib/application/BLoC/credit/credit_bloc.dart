import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_final_test/application/use_cases/credit/get_credit_by_movie.dart';
import 'package:flutter_final_test/common/failure.dart';
import 'package:flutter_final_test/domain/credit/credit.dart';

part 'credit_event.dart';
part 'credit_state.dart';

class CreditsBloc extends Bloc<CreditEvent, CreditState> {
  final GetCreditByMovieUseCase getCreditByMovieUseCase;

  CreditsBloc({required this.getCreditByMovieUseCase})
      : super(CreditLoading()) {
    on<FetchCreditEvent>(_fetchCreditsEventHandler);
  }

  void _fetchCreditsEventHandler(
      FetchCreditEvent event, Emitter<CreditState> emit) async {
    emit(CreditLoading());

    final result = await getCreditByMovieUseCase
        .execute(GetCreditByMovieUseCaseInput(movieId: event.movieId));

    result.hasValue()
        ? emit(CreditLoaded(credit: result.value!))
        : emit(CreditFailed(failure: result.failure));
  }
}
