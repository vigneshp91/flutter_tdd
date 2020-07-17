import 'package:flutter_tdd/core/error/errors.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

abstract class NumberTriviaRepository {

  Future<Either<Errors, NumberTrivia>> getConcreteTrivia(int number);
  Future<Either<Errors, NumberTrivia>> getRandomTrivia();

}