import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/errors.dart';
import 'package:flutter_tdd/core/usecase/base_usecase.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd/features/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:equatable/equatable.dart';


class GetConcreteTriviaUseCase implements Usecase<NumberTrivia,Params> {
final NumberTriviaRepository repository;

  GetConcreteTriviaUseCase({this.repository});

  @override
  Future<Either<Errors, NumberTrivia>>  call (Params params) async{
    return await repository.getConcreteTrivia(params.number);
  }

}

class Params extends Equatable {
  final int number;

  Params({this.number});

  @override
  List<Object> get props => [number];

}