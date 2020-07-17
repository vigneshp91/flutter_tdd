import 'package:flutter/foundation.dart';
import 'package:flutter_tdd/core/error/exception.dart';
import 'package:flutter_tdd/core/network/network_info.dart';
import 'package:flutter_tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/features/number_trivia/domain/repositories/number_trivia_repo.dart';

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Errors, NumberTrivia>> getConcreteTrivia(int number) async {
    return await _getNumberTrivia(() {
      return remoteDataSource.getConcreteTrivia(number);
    });
  }

  @override
  Future<Either<Errors, NumberTrivia>> getRandomTrivia() async {
    return await _getNumberTrivia(() {
      return remoteDataSource.getRandomTrivia();
    });
  }

  Future<Either<Errors, NumberTrivia>> _getNumberTrivia(
      Future<NumberTrivia> Function() getRandomOrConcreteTrivia) async {
    // when network is present
    if (await networkInfo.isConnected) {
      try {
        final result = await getRandomOrConcreteTrivia();
        localDataSource.setCachedTrivia(result);
        return Right(result);
      } on ServerException {
        return Left(ServerError());
      }
    } else {
      // when network is not present
      try {
        final result = await localDataSource.getCachedTrivia();
        localDataSource.setCachedTrivia(result);
        return Right(result);
      } on CacheException {
        return Left(CacheError());
      }
    }
  }
}
