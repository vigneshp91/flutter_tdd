import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/usecase/base_usecase.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd/features/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:flutter_tdd/features/number_trivia/domain/usecases/random_trivia_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository{}
  
 
 void main(){
   GetRandomTriviaUseCase  randomUsecase;
   MockNumberTriviaRepository mockRepo;

 
  setUp(() {
    mockRepo = MockNumberTriviaRepository();
    randomUsecase = new GetRandomTriviaUseCase(repository: mockRepo);
  });

  final testNumber = 50;
  final response = NumberTrivia("test",testNumber);


   test("should get random trivia for the number from the repository",() async {
    when(mockRepo.getRandomTrivia()).thenAnswer((_) async => Right(response));
    final result = await randomUsecase(NoParams());
    expect(result,Right(response));
    verify(mockRepo.getRandomTrivia());
    verifyNoMoreInteractions(mockRepo);


  });
 }
