import 'package:flutter_practical_test/features/book/data/models/book_model.dart';
import '../repositories/favorites_repository.dart';

class AddFavoriteBook {
  final FavoritesRepository repository;

  AddFavoriteBook(this.repository);

  Future<void> addFavoriteBook(BookModel book) async {
    await repository.addFavoriteBook(book);
  }
}
