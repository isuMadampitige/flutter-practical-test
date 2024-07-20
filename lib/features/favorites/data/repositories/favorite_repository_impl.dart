import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_practical_test/core/error/failure.dart';
import 'package:flutter_practical_test/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:flutter_practical_test/features/book/data/models/book_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteRepositoryImpl implements FavoritesRepository {
  final SharedPreferences sharedPreferences;
  final String favoritesKey = 'favorite_books';

  FavoriteRepositoryImpl({required this.sharedPreferences});

  @override
  Future<List<BookModel>> getFavoriteBooks() async {
    final jsonString = sharedPreferences.getString(favoritesKey);
    if (jsonString != null) {
      final List decodedList = json.decode(jsonString) as List;
      return decodedList.map((json) => BookModel.fromJson(json)).toList();
    }
    return [];
  }

  @override
  Future<void> addFavoriteBook(BookModel book) async {
    final favorites = await getFavoriteBooks();
    favorites.add(book);
    final jsonString =
        json.encode(favorites.map((book) => book.toJson()).toList());
    await sharedPreferences.setString(favoritesKey, jsonString);
  }

  @override
  Future<void> removeFavoriteBook(BookModel book) async {
    final favorites = await getFavoriteBooks();
    favorites.removeWhere((b) => b.isbn13 == book.isbn13);
    final jsonString =
        json.encode(favorites.map((book) => book.toJson()).toList());
    await sharedPreferences.setString(favoritesKey, jsonString);
  }

  @override
  Future<Either<Failure, bool>> isBookInFavorites(BookModel book) async {
    try {
      List<BookModel> favorites = await getFavoriteBooks();
      final isFavorite = favorites.contains(book);
      return Right(isFavorite);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
