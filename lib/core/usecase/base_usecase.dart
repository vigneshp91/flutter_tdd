import 'package:dartz/dartz.dart';
import '../error/errors.dart';
import 'package:equatable/equatable.dart';


abstract class Usecase<Type,Params> {
  Future<Either<Errors, Type>>  call(Params params);

}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}