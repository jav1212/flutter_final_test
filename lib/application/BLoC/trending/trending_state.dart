part of 'trending_bloc.dart';

abstract class TrendingsState extends Equatable {
  final Failure? failure;
  final int page;

  const TrendingsState({this.failure, required this.page});

  @override
  List<Object?> get props => [failure, page];
}

class TrendingsLoading extends TrendingsState {
  const TrendingsLoading({required super.page});
}

class TrendingsLoaded extends TrendingsState {
  final Trending trending;

  const TrendingsLoaded({
    required this.trending,
    required super.page,
  });

  @override
  List<Object?> get props => [trending, page];
}

class TrendingsFailed extends TrendingsState {
  const TrendingsFailed({required Failure super.failure, required super.page});
}
