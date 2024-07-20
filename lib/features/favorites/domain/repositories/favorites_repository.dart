import 'package:dartz/dartz.dart';
import 'package:flutter_practical_test/features/book/data/models/book_model.dart';

import '../../../../core/error/failure.dart';

abstract class FavoritesRepository {
  Future<List<BookModel>> getFavoriteBooks();
  Future<void> addFavoriteBook(BookModel book);
  Future<void> removeFavoriteBook(BookModel book);
  Future<Either<Failure, bool>> isBookInFavorites(BookModel book);
}
