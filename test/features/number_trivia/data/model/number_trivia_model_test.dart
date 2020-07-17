import 'dart:convert';

import 'package:flutter_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final testNumberModel = NumberTriviaModel("test", 1);
  test("number trivia model test", () async {
    expect(testNumberModel, isA<NumberTrivia>());
  });

  group("Json conversion test group", () {
    test("fromJson test with integer number", () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture("trivia.json"));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, testNumberModel);
    });

    test("fromJson test with double number", () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture("trivia_double.json"));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, testNumberModel);
    });
  });

  group("toJson", () {
    test("tojson test", () async {
      final actualResult =
          testNumberModel.toJson();
      final expectedResult = {'number': 1,'text': "test"};
      expect(actualResult, expectedResult);
    });
  });
}
