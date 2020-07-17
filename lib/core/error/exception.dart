
import 'package:equatable/equatable.dart';

 class Failures extends Equatable {
  @override
  List<Object> get props => const<dynamic>[];
  
}

class ServerException extends Failures {}
class CacheException extends Failures{}
