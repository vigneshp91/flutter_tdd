import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_tdd/core/network/network_info.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker{}

void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker connectionChecker;

  setUp(() {
    connectionChecker = MockDataConnectionChecker();
    networkInfo  = NetworkInfoImpl(connectionChecker);
  });

  test("should return true if connected to internet",() async {

    final tConnectedValue = Future.value(true);
    when(connectionChecker.hasConnection)
    .thenAnswer((_) => tConnectedValue);

    final result = networkInfo.isConnected;

    expect(result,tConnectedValue);

  });

    test("should return false if not connected to internet",() async {

    final tConnectedValue = Future.value(false);
    when(connectionChecker.hasConnection)
    .thenAnswer((_) => tConnectedValue);

    final result = networkInfo.isConnected;

    expect(result,tConnectedValue);

  });
}
 