part of 'trending_bloc.dart';

abstract class TrendingsEvent extends Equatable {
  const TrendingsEvent();

  @override
  List<Object?> get props => [];
}

class FetchTrendingsEvent extends TrendingsEvent {
  final int page;

  const FetchTrendingsEvent({required this.page});

  @override
  List<Object?> get props => [page];
}
