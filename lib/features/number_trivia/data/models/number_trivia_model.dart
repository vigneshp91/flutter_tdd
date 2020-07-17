
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia{
  
  NumberTriviaModel(String text, int number) : super(text, number);

  factory NumberTriviaModel.fromJson(Map<String,dynamic> jsonMap) {
    return NumberTriviaModel(jsonMap["text"],
     (jsonMap["number"] as num).toInt()
     );
  }

   Map<String,dynamic> toJson() {
    return {'number':number, 'text':text};
  }

}