import 'package:flutter_practical_test/core/error/exceptions/custom_exception.dart';

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}
