import 'package:flutter_practical_test/core/error/exceptions/custom_exception.dart';

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}
