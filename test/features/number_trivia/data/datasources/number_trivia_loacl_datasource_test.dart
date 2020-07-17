import 'dart:convert';

import 'package:flutter_tdd/core/constants/constants.dart';
import 'package:flutter_tdd/core/error/exception.dart';
import 'package:flutter_tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../fixtures/fixture_reader.dart';




class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {

  MockSharedPreferences sharedPreferences;
  NumberTriviaLocalDataSource localDataSource;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localDataSource = NumberTriviaLocalDataSourceImpl(sharedPreferences);
  });

  test("get number trivia from cache", ()async{
    final expectedValue = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    when(sharedPreferences.getString(Constant.CACHED_NUMBER_TRIVIA))
    .thenReturn(fixture('trivia.json'));

    final result = await localDataSource.getCachedTrivia();
    verify(sharedPreferences.getString(Constant.CACHED_NUMBER_TRIVIA));
    expect(result,equals(expectedValue));
  });

    test("set number trivia to cache", ()async{
    final tValue = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    when(sharedPreferences.setString(Constant.CACHED_NUMBER_TRIVIA,tValue.toJson().toString()))
    .thenAnswer((_) => Future.value(true));

    final result = await localDataSource.setCachedTrivia(tValue);
    verify(sharedPreferences.setString(Constant.CACHED_NUMBER_TRIVIA,any));
   // expect(result,equals(expectedValue));
  });

    test("get exception from getCachedTrivia if value not exist", ()async{

    when(sharedPreferences.getString(Constant.CACHED_NUMBER_TRIVIA))
    .thenReturn(null);

    //final call = localDataSource.getCachedTrivia();
   // verify(sharedPreferences.getString(Constant.CACHED_NUMBER_TRIVIA));
    expect(()=>localDataSource.getCachedTrivia(),throwsA(isInstanceOf<CacheException>()));
  });
}
