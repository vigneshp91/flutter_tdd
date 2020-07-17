import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd/features/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:flutter_tdd/features/number_trivia/domain/usecases/concrete_trivia_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository{}
  
 
 void main(){
   GetConcreteTriviaUseCase  concreteUsecase;
   MockNumberTriviaRepository mockRepo;

 
  setUp(() {
    mockRepo = MockNumberTriviaRepository();
    concreteUsecase = new GetConcreteTriviaUseCase(repository: mockRepo);
  });

  final testNumber = 50;
  final response = NumberTrivia("test",testNumber);

  test("should get trivia for the number from the repository",() async {
    when(mockRepo.getConcreteTrivia(any)).thenAnswer((_) async => Right(response));
    final result = await concreteUsecase(Params(number: testNumber));
    expect(result,Right(response));
    verify(mockRepo.getConcreteTrivia(testNumber));
    verifyNoMoreInteractions(mockRepo);


  });

 }
