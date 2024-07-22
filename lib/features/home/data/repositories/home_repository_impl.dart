import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_practical_test/features/home/data/datasources/home_remote_datasorce.dart';
import 'package:flutter_practical_test/features/book/data/models/book_model.dart';
import 'package:flutter_practical_test/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/exceptions/server_exception.dart';
import '../../../../core/error/failure.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasorce homeRemoteDatasorce;
  HomeRepositoryImpl(this.homeRemoteDatasorce);

  @override
  Future<Either<Failure, List<BookModel>>> searchBooks(
      String query, int page, int limit) async {
    try {
      final apiResponse =
          await homeRemoteDatasorce.searchBooks(query, page, limit);
      print("apiResponse---${apiResponse.length}");
      return Right(apiResponse);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
