import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_practical_test/features/book_details/domain/repositories/book_details_repository.dart';
import '../../../../core/error/exceptions/server_exception.dart';
import '../../../../core/error/failure.dart';
import '../datasources/book_detail_remote.dart';
import '../models/book_detail_model.dart';

class BookDetailsRepositoryImpl implements BookDetailsRepository {
  final BookDetailRemote bookDetailRemote;
  BookDetailsRepositoryImpl(this.bookDetailRemote);

  @override
  Future<Either<Failure, BookDetail>> fetchDetails(String isbn) async {
    try {
      final apiResponse = await bookDetailRemote.fetchDetails(isbn);
      print("apiResponse---$apiResponse");
      return Right(apiResponse);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
