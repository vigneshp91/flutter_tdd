import 'dart:convert';

import 'package:flutter_tdd/core/constants/constants.dart';
import 'package:flutter_tdd/core/error/exception.dart';
import 'package:flutter_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getCachedTrivia();
  Future<void> setCachedTrivia(NumberTriviaModel trivia);


}

class NumberTriviaLocalDataSourceImpl extends NumberTriviaLocalDataSource{

  final SharedPreferences preferences;

  NumberTriviaLocalDataSourceImpl(this.preferences);
  @override
  Future<NumberTriviaModel> getCachedTrivia() {
    final saved_value = preferences.getString(Constant.CACHED_NUMBER_TRIVIA);
    
    if(saved_value == null || saved_value.isEmpty) {
        throw CacheException();
    }

    return Future.value(NumberTriviaModel.fromJson(
      json.decode(saved_value)));
  }

  @override
  Future<void> setCachedTrivia(NumberTriviaModel trivia) {
   return preferences.setString(Constant.CACHED_NUMBER_TRIVIA, trivia.toJson().toString());
  }

}