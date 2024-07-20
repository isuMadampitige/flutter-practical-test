import 'package:dartz/dartz.dart';
import 'package:flutter_practical_test/features/book/data/models/book_model.dart';
import 'package:flutter_practical_test/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failure.dart';

class SearchBooks {
  final HomeRepository repository;

  SearchBooks(this.repository);

  Future<Either<Failure, List<BookModel>>> searchBooks(String query) async {
    return await repository.searchBooks(query);
  }
}
