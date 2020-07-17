
import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/errors.dart';
import 'package:flutter_tdd/core/util/input_convertor.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  Inputconvertor convertor;

setUp((){
    convertor = Inputconvertor();
});

test("conver string to number", () {

  final testValue = "123";

  final result = convertor.convertStringtiInt(testValue);

  expect(result,Right(123));


});

test("conver string to number error", () {

  final testValue = "123aa";

  final result = convertor.convertStringtiInt(testValue);

  expect(result,Left(InvalidInputError()));


});

}