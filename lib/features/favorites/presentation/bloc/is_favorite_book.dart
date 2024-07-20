import 'package:dartz/dartz.dart';
import 'package:flutter_practical_test/features/book/data/models/book_model.dart';
import 'package:flutter_practical_test/features/favorites/domain/repositories/favorites_repository.dart';

import '../../../../core/error/failure.dart';

class CheckIfBookIsFavoriteUseCase {
  final FavoritesRepository repository;

  CheckIfBookIsFavoriteUseCase(this.repository);

  Future<Either<Failure, bool>> isBookInFavorites(BookModel book) {
    return repository.isBookInFavorites(book);
  }
}
