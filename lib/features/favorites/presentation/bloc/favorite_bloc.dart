import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_test/features/favorites/domain/usecases/add_favorite_books.dart';
import 'package:flutter_practical_test/features/favorites/domain/usecases/fetch_favorites.dart';
import 'package:flutter_practical_test/features/favorites/domain/usecases/remove_favorite_books.dart';
import 'package:flutter_practical_test/features/favorites/presentation/bloc/favorite_event.dart';
import 'package:flutter_practical_test/features/favorites/presentation/bloc/favorite_state.dart';
import 'package:flutter_practical_test/features/favorites/presentation/bloc/is_favorite_book.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FetchFavorites fetchFavorites;
  final AddFavoriteBook addFavoriteBook;
  final RemoveFavoriteBook removeFavoriteBook;
  final CheckIfBookIsFavoriteUseCase checkIfBookIsFavoriteUseCase;

  FavoriteBloc(
      {required this.fetchFavorites,
      required this.addFavoriteBook,
      required this.removeFavoriteBook,
      required this.checkIfBookIsFavoriteUseCase})
      : super(FavoriteInitial()) {
    on<LoadFavoriteBooks>(_onLoadFavoriteBooks);
    on<AddBookToFavorites>(_onAddBookToFavorites);
    on<RemoveBookFromFavorites>(_onRemoveBookFromFavorites);
    on<CheckIfBookIsFavorite>(_onCheckIfBookIsFavorite);
  }

  void _onLoadFavoriteBooks(
      LoadFavoriteBooks event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      final books = await fetchFavorites.getFavoriteBooks();
      emit(FavoriteLoaded(
        books,
        event.isFav,
      ));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  void _onAddBookToFavorites(
      AddBookToFavorites event, Emitter<FavoriteState> emit) async {
    try {
      await addFavoriteBook.addFavoriteBook(event.book);
      // emit(BookIsFavorite(false));

      add(LoadFavoriteBooks(true));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  void _onRemoveBookFromFavorites(
      RemoveBookFromFavorites event, Emitter<FavoriteState> emit) async {
    try {
      await removeFavoriteBook.removeFavoriteBook(event.book);
      // emit(BookIsFavorite(true));

      add(LoadFavoriteBooks(false));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> _onCheckIfBookIsFavorite(
      CheckIfBookIsFavorite event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    final result =
        await checkIfBookIsFavoriteUseCase.isBookInFavorites(event.book);
    result.fold(
      (failure) => emit(FavoriteError(failure.message)),
      (isFavorite) => emit(BookIsFavorite(isFavorite)),
    );
  }
}
