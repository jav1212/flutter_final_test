part of 'credit_bloc.dart';

abstract class CreditState extends Equatable {
  final Failure? failure;
  const CreditState({this.failure});

  @override
  List<Object?> get props => [];
}

class CreditLoading extends CreditState {}

class CreditLoaded extends CreditState {
  final Credit credit;

  const CreditLoaded({
    required this.credit,
  });

  @override
  List<Object?> get props => [credit];
}

class CreditFailed extends CreditState {
  const CreditFailed({required super.failure});
}
