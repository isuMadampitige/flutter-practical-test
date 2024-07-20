import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/book_detail_model.dart';

abstract class BookDetailsRepository {
  Future<Either<Failure, BookDetail>> fetchDetails(String isbn);
}
