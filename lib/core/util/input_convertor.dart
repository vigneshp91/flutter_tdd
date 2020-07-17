import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/errors.dart';

class Inputconvertor {
  Either<Errors, int> convertStringtiInt(String text) {
    try {
      final result = int.parse(text);
      if (result < 0) throw FormatException();
      return Right(result);
    } on FormatException {
      return Left(InvalidInputError());
    }
  }
}
