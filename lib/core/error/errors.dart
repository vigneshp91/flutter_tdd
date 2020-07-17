import 'package:equatable/equatable.dart';


class Errors extends Equatable{
  final List properties;

  Errors([this.properties = const <dynamic> []]);

  @override
  List<Object> get props => [properties];

}

class ServerError extends Errors{}
class CacheError extends Errors{}
class InvalidInputError extends Errors{}