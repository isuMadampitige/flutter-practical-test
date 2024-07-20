import 'package:flutter_practical_test/core/error/exceptions/custom_exception.dart';

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorized: ");
}
