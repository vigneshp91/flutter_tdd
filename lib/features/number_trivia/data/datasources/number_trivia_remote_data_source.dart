import 'dart:convert';

import 'package:flutter_tdd/core/error/exception.dart';
import 'package:flutter_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';



abstract class NumberTriviaRemoteDataSource {

  Future<NumberTrivia> getConcreteTrivia(int number);
  Future<NumberTrivia> getRandomTrivia();

}


class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  
  final http.Client client;
  NumberTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<NumberTrivia> getConcreteTrivia(int number)  async {
      return _getNumberTrivia('http://numbersapi.com/$number');
  }

  @override
  Future<NumberTrivia> getRandomTrivia() async {
    return _getNumberTrivia('http://numbersapi.com/random/trivia');
   
  }

  NumberTriviaModel getParsedValue(String response) {
    return NumberTriviaModel.fromJson(json.decode(response));
    
  }

Future<NumberTrivia> _getNumberTrivia(String url) async{
  final result = await client.get(url,
    headers: {'Content-Type': 'application/json'});
    if(result.statusCode == 200) {
        return Future.value(getParsedValue(result.body));
    }else{
      throw ServerException();
    }
}




}