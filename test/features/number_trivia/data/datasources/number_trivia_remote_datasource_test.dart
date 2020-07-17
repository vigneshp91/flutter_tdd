import 'dart:convert';

import 'package:flutter_tdd/core/error/exception.dart';
import 'package:flutter_tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient httpclient;
  NumberTriviaRemoteDataSource remoteDataSource;

  setUp(() {
    httpclient = MockHttpClient();
    remoteDataSource = NumberTriviaRemoteDataSourceImpl(client: httpclient);
  });

  group("getConcreteTrivia from remote", () {
    test("should hit get endpoint to get concrete number trivia", () async {
      final expectedValue =
          NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
      final tNumber = 42;
      when(httpclient.get(any, headers: anyNamed("headers")))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
      final result = await remoteDataSource.getConcreteTrivia(tNumber);
      verify(httpclient.get('http://numbersapi.com/$tNumber',
          headers: {'Content-Type': 'application/json'}));
      expect(result, expectedValue);
    });

    test("should throw serverexcception on error", () async {
      final expectedValue =
          NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
      final tNumber = 42;
      when(httpclient.get(any, headers: anyNamed("headers")))
          .thenAnswer((_) async => http.Response("error", 400));

      final result = remoteDataSource.getConcreteTrivia;

      // verify(httpclient.get('http://numbersapi.com/$tNumber',
      //     headers: {'Content-Type': 'application/json'}));
      expect(() => result(tNumber), throwsA(isInstanceOf<ServerException>()));
    });
  });

   group("getRandomTrivia from remote", () {
    test("should hit get endpoint to get Random number trivia", () async {
      final expectedValue =
          NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
      final tNumber = 42;
      when(httpclient.get(any, headers: anyNamed("headers")))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
      final result = await remoteDataSource.getRandomTrivia();
      verify(httpclient.get('http://numbersapi.com/random/trivia',
          headers: {'Content-Type': 'application/json'}));
      expect(result, expectedValue);
    });

    test("should throw serverexcception on error", () async {
      final expectedValue =
          NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
      final tNumber = 42;
      when(httpclient.get(any, headers: anyNamed("headers")))
          .thenAnswer((_) async => http.Response("error", 400));

      final result = remoteDataSource.getRandomTrivia;

      // verify(httpclient.get('http://numbersapi.com/$tNumber',
      //     headers: {'Content-Type': 'application/json'}));
      expect(() => result(), throwsA(isInstanceOf<ServerException>()));
    });
  });

}
