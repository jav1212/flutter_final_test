import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_final_test/application/use_cases/trending/get_trendings.dart';
import 'package:flutter_final_test/common/failure.dart';
import 'package:flutter_final_test/domain/treding/treding.dart';

part 'trending_event.dart';
part 'trending_state.dart';

class TrendingsBloc extends Bloc<TrendingsEvent, TrendingsState> {
  final GetTrendingsUseCase getTrendingsUseCase;
  int currentPage = 1;

  TrendingsBloc({required this.getTrendingsUseCase})
      : super(const TrendingsLoading(page: 1)) {
    on<FetchTrendingsEvent>(_fetchTrendingsEventHandler);
  }

  void _fetchTrendingsEventHandler(
      FetchTrendingsEvent event, Emitter<TrendingsState> emit) async {
    try {
      emit(TrendingsLoading(page: event.page));

      final result = await getTrendingsUseCase.execute(
        GetTrendingUseCaseInput(page: event.page),
      );

      if (result.hasValue()) {
        currentPage = event.page; // Actualiza la página actual
        emit(TrendingsLoaded(
          trending: result.value!,
          page: event.page,
        ));
      } else {
        emit(TrendingsFailed(
          failure: result.failure!,
          page: event.page,
        ));
      }
    } catch (e) {
      emit(TrendingsFailed(
        failure: const UnknownFailure(),
        page: currentPage,
      ));
    }
  }
}
