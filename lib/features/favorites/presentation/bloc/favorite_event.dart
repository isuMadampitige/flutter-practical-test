import 'package:equatable/equatable.dart';
import '../../../book/data/models/book_model.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoriteBooks extends FavoriteEvent {
  final bool isFav;

  const LoadFavoriteBooks(this.isFav);

  @override
  List<Object> get props => [isFav];
}

class AddBookToFavorites extends FavoriteEvent {
  final BookModel book;

  const AddBookToFavorites(this.book);

  @override
  List<Object> get props => [book];
}

class RemoveBookFromFavorites extends FavoriteEvent {
  final BookModel book;

  const RemoveBookFromFavorites(this.book);

  @override
  List<Object> get props => [book];
}

class CheckIfBookIsFavorite extends FavoriteEvent {
  final BookModel book;
  const CheckIfBookIsFavorite(this.book);

  @override
  List<Object> get props => [book];
}
