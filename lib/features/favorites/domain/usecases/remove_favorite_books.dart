import 'package:flutter_practical_test/features/book/data/models/book_model.dart';
import '../repositories/favorites_repository.dart';

class RemoveFavoriteBook {
  final FavoritesRepository repository;

  RemoveFavoriteBook(this.repository);

  Future<void> removeFavoriteBook(BookModel book) async {
    await repository.removeFavoriteBook(book);
  }
}
