import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/errors.dart';
import 'package:flutter_tdd/core/error/exception.dart';
import 'package:flutter_tdd/core/network/network_info.dart';
import 'package:flutter_tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl mockRepository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    mockRepository = NumberTriviaRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestOnline(Function tests) {
    group("device online test group", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => (true));
      });
      tests();
    });
  }

  void runTestOffline(Function tests) {
    group("device offline test group", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => (false));
      });
      tests();
    });
  }

  group("getconcretetrivia  test group", () {
    final tNumber = 1;
    final tnumberTriviaModel = NumberTriviaModel("test", 1);
    final tNumberTriviaEntity = tnumberTriviaModel;

    runTestOnline(() {
      test("device is online", () async {
        mockRepository.getConcreteTrivia(tNumber);
        verify(mockNetworkInfo.isConnected);
      });

      test("should call remotedatasource when device is online", () async {
        when(mockRemoteDataSource.getConcreteTrivia(any))
            .thenAnswer((_) async => (tnumberTriviaModel));
        final result = await mockRepository.getConcreteTrivia(tNumber);
        verify(mockRemoteDataSource.getConcreteTrivia(tNumber));
        expect(result, Right(tNumberTriviaEntity));
      });

      test("should cache the data when data fetched from remote data source",
          () async {
        when(mockRemoteDataSource.getConcreteTrivia(any))
            .thenAnswer((_) async => (tnumberTriviaModel));
        // ignore: unused_local_variable
        final result = await mockRepository.getConcreteTrivia(tNumber);
        verify(mockLocalDataSource.setCachedTrivia(tNumberTriviaEntity));
      });

      test(
          "should return server excception when unable to fetch data from remote",
          () async {
        when(mockRemoteDataSource.getConcreteTrivia(any))
            .thenThrow(ServerException());
        final result = await mockRepository.getConcreteTrivia(tNumber);
        expect(result, Left(ServerError()));
        verifyZeroInteractions(mockLocalDataSource);
      });
    });

    runTestOffline(() {
      test("device is offline", () async {
        mockRepository.getConcreteTrivia(tNumber);
        verify(mockNetworkInfo.isConnected);
      });
      test("should call local data source when device is offline", () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => (false));
        when(mockLocalDataSource.getCachedTrivia())
            .thenAnswer((_) async => (tnumberTriviaModel));
        final result = await mockRepository.getConcreteTrivia(tNumber);
        verify(mockLocalDataSource.getCachedTrivia());
        expect(result, Right(tNumberTriviaEntity));
        verifyZeroInteractions(mockRemoteDataSource);
      });

      test("should return cache exception when cache data is not present",
          () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => (false));
        when(mockLocalDataSource.getCachedTrivia()).thenThrow(CacheException());
        final result = await mockRepository.getConcreteTrivia(tNumber);
        verify(mockLocalDataSource.getCachedTrivia());
        expect(result, Left(CacheError()));
        verifyZeroInteractions(mockRemoteDataSource);
      });
    });
  });

  group("getRandonTrivia Test group", () {
    final tNumber = 1;
    final tnumberTriviaModel = NumberTriviaModel("test", 1);
    final tNumberTriviaEntity = tnumberTriviaModel;

    runTestOnline(() {
      test("device is online", () async {
        mockRepository.getConcreteTrivia(tNumber);
        verify(mockNetworkInfo.isConnected);
      });

      test("should call remotedatasource when device is online", () async {
        when(mockRemoteDataSource.getRandomTrivia())
            .thenAnswer((_) async => (tnumberTriviaModel));
        final result = await mockRepository.getRandomTrivia();
        verify(mockRemoteDataSource.getRandomTrivia());
        expect(result, Right(tNumberTriviaEntity));
      });

      test("should cache the data when data fetched from remote data source",
          () async {
        when(mockRemoteDataSource.getRandomTrivia())
            .thenAnswer((_) async => (tnumberTriviaModel));
        // ignore: unused_local_variable
        final result = await mockRepository.getRandomTrivia();
        verify(mockLocalDataSource.setCachedTrivia(tNumberTriviaEntity));
      });

      test(
          "should return server excception when unable to fetch data from remote",
          () async {
        when(mockRemoteDataSource.getRandomTrivia())
            .thenThrow(ServerException());
        final result = await mockRepository.getRandomTrivia();
        expect(result, Left(ServerError()));
        verifyZeroInteractions(mockLocalDataSource);
      });
    });

    runTestOffline(() {
      test("device is offline", () async {
        mockRepository.getConcreteTrivia(tNumber);
        verify(mockNetworkInfo.isConnected);
      });
      test("should call local data source when device is offline", () async {
        when(mockLocalDataSource.getCachedTrivia())
            .thenAnswer((_) async => (tnumberTriviaModel));
        final result = await mockRepository.getRandomTrivia();
        verify(mockLocalDataSource.getCachedTrivia());
        expect(result, Right(tNumberTriviaEntity));
        verifyZeroInteractions(mockRemoteDataSource);
      });

      test("should return cache exception when cache data is not present",
          () async {
        when(mockLocalDataSource.getCachedTrivia()).thenThrow(CacheException());
        final result = await mockRepository.getRandomTrivia();
        verify(mockLocalDataSource.getCachedTrivia());
        expect(result, Left(CacheError()));
        verifyZeroInteractions(mockRemoteDataSource);
      });
    });
  });
}
