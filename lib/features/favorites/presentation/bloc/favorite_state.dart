import 'package:equatable/equatable.dart';
import 'package:flutter_practical_test/features/book/data/models/book_model.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteEmpty extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<BookModel> result;
  final bool? isFavorite;

  FavoriteLoaded(this.result, this.isFavorite);

  @override
  List<Object> get props => [result];
  List<bool?> get props2 => [isFavorite];
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);

  @override
  List<Object> get props => [message];
}

class BookIsFavorite extends FavoriteState {
  final bool isFavorite;
  BookIsFavorite(this.isFavorite);
}
