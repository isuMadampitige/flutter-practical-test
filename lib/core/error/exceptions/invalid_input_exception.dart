import 'package:flutter_practical_test/core/error/exceptions/custom_exception.dart';

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
