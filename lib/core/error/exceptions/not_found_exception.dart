import 'package:flutter_practical_test/core/error/exceptions/custom_exception.dart';

class NotFoundDataException extends CustomException {
  NotFoundDataException([String? message]) : super(message, "No Data Found: ");
}
