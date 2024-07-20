import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_test/features/book/presentation/bloc/book_event.dart';
import 'package:flutter_practical_test/features/book/presentation/bloc/book_state.dart';
import 'package:rxdart/rxdart.dart';
import '../../../home/domain/usecases/search_books.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final SearchBooks searchBooks;

  BookBloc(this.searchBooks) : super(BookInitial()) {
    on<OnSearchQuery>(
      _mapEventToState,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  void _mapEventToState(OnSearchQuery event, Emitter<BookState> emit) async {
    emit(BookLoading());
    final books = await searchBooks.searchBooks(event.searchQuery);
    print("bclocBooks---$books");
    books.fold(
      (failure) {
        print("failure-");
        emit(BookError(failure.message));
      },
      (data) {
        print("dataloaded-");
        if (data.isNotEmpty) {
          emit(BookLoaded(data));
        } else {
          emit(BookEmpty());
        }
      },
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
