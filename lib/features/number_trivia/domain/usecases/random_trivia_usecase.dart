
import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/errors.dart';
import 'package:flutter_tdd/core/usecase/base_usecase.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd/features/number_trivia/domain/repositories/number_trivia_repo.dart';

class GetRandomTriviaUseCase implements Usecase<NumberTrivia,NoParams> {
  NumberTriviaRepository repository;
  
  GetRandomTriviaUseCase({this.repository});

//call methor will be called when constructor is called
@override
  Future<Either<Errors, NumberTrivia>>  call(NoParams params) async{
    return await repository.getRandomTrivia();
  }

}