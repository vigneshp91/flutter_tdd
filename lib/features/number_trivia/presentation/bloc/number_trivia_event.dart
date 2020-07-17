part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
  
}

class GetRandomNumberEvent extends NumberTriviaEvent {
  @override
  List<Object> get props => [];

}

class GetConcreteNumberEvent extends NumberTriviaEvent{
  final String number;
  GetConcreteNumberEvent(this.number);
  @override
  List<Object> get props => [this.number];

}

