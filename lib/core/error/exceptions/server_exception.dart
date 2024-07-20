import 'package:flutter_practical_test/core/error/exceptions/custom_exception.dart';

class ServerException extends CustomException {
  ServerException([String? message]) : super(message, "Server exception: ");
}
