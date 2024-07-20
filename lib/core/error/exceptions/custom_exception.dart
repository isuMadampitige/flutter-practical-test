// ignore_for_file: prefer_typing_uninitialized_variables

class CustomException implements Exception {
  final message;
  final prefix;

  CustomException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}
