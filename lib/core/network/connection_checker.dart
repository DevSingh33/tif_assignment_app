import 'package:internet_connection_checker/internet_connection_checker.dart';

///Using the internet connection checker as a contract class so we can easily swap it other packages(if we need to)
abstract class ConnectionChecker {
  Future<bool> get isConnected;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnectionChecker internetConnectionChecker;
  ConnectionCheckerImpl({required this.internetConnectionChecker});

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
