part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
}

class Initital extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class Loading extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class Success extends NumberTriviaState {
  final NumberTrivia result;

  Success({@required this.result});
  @override
  List<Object> get props => [this.result];
}

class Error extends NumberTriviaState {
  final String errorMsg;

  Error({@required this.errorMsg});
  @override
  List<Object> get props => [this.errorMsg];
}