import 'package:dartz/dartz.dart';
import 'package:flutter_practical_test/features/book_details/data/models/book_detail_model.dart';
import 'package:flutter_practical_test/features/book_details/domain/repositories/book_details_repository.dart';

import '../../../../core/error/failure.dart';

class BookDetailsFetch {
  final BookDetailsRepository repository;

  BookDetailsFetch(this.repository);

  Future<Either<Failure, BookDetail>> bookDetails(String isbn) async {
    return await repository.fetchDetails(isbn);
  }
}
