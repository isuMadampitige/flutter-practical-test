import 'package:dartz/dartz.dart';
import 'package:flutter_practical_test/features/book/data/models/book_model.dart';

import '../../../../core/error/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<BookModel>>> searchBooks(String query);
}
