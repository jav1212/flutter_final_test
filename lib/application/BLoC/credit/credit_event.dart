part of 'credit_bloc.dart';

abstract class CreditEvent {}

class FetchCreditEvent extends CreditEvent {
  final int movieId;

  FetchCreditEvent({required this.movieId});
}
