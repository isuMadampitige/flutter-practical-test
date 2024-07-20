import 'package:dio/dio.dart';
import 'package:flutter_practical_test/features/book_details/data/models/book_detail_model.dart';
import '../../../../core/error/exceptions/server_exception.dart';
import '../../../../core/network/api_config.dart';
import '../../../../core/network/api_services.dart';

abstract class BookDetailRemote {
  Future<BookDetail> fetchDetails(String isbn);
}

class BookDetailRemoteImpl extends BookDetailRemote {
  BookDetailRemoteImpl();

  @override
  Future<BookDetail> fetchDetails(String isbn) async {
    try {
      String endpoint = "${APIConfig.bookDetails}$isbn";
      Response<dynamic> response = await ApiService().postRequest(
        endpoint,
      );

      if (response.data != null && response.statusCode == 200) {
        return BookDetail.fromJson(response.data);
      } else {
        throw Exception("Fail to fetch data");
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
