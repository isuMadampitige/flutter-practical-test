import '../enums/server_type.dart';

class APIConfig {
  static var mainUrl;

  static serverUrlInitialize({required ServerType type}) {
    switch (type) {
      case ServerType.prod:
        mainUrl = 'ADD URL HERE';
        break;
      case ServerType.dev:
        mainUrl = "https://api.itbook.store/1.0/search/mongodb";
        break;
      case ServerType.stag:
        mainUrl = '';
        break;
    }
  }

  static var searchBooks = "/search/";
  static var bookDetails = "/books/";
}
