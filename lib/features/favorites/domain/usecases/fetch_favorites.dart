import 'package:flutter_practical_test/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:flutter_practical_test/features/book/data/models/book_model.dart';

class FetchFavorites {
  final FavoritesRepository repository;

  FetchFavorites(this.repository);

  Future<List<BookModel>> getFavoriteBooks() async {
    return await repository.getFavoriteBooks();
  }
}
