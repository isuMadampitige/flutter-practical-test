import 'package:dio/dio.dart';
import 'package:flutter_practical_test/features/book/data/models/book_model.dart';
import '../../../../core/error/exceptions/server_exception.dart';
import '../../../../core/network/api_config.dart';
import '../../../../core/network/api_services.dart';

abstract class HomeRemoteDatasorce {
  Future<List<BookModel>> searchBooks(String query);
}

class HomeRemoteDatasorceImpl extends HomeRemoteDatasorce {
  HomeRemoteDatasorceImpl();

  @override
  Future<List<BookModel>> searchBooks(String query) async {
    try {
      String endpoint = "${APIConfig.searchBooks}$query";
      Response<dynamic> response = await ApiService().postRequest(
        endpoint,
        // data: {
        //   // 'query': 'mongodb',
        //   // 'page': 10,
        //   // 'limit': 5,
        // },
      );

      if (response.data != null && response.statusCode == 200) {
        return List<BookModel>.from(
            response.data['books'].map((model) => BookModel.fromJson(model)));
      } else {
        throw Exception("Fail to fetch data");
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
