import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_test/features/book/presentation/bloc/book_event.dart';
import 'package:flutter_practical_test/features/book/presentation/bloc/book_state.dart';
import 'package:rxdart/rxdart.dart';
import '../../../home/domain/usecases/search_books.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final SearchBooks searchBooks;
  int currentPage = 1;
  // bool isFetching = false;
  String currentQuery = '';

  BookBloc(
    this.searchBooks,
  ) : super(BookInitial()) {
    on<OnSearchQuery>(
      _onSearchStarted,
      // transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<NextPage>(_onSearchNextPage);
    on<ResetItems>(_onResetItems);
  }

  void _onSearchStarted(OnSearchQuery event, Emitter<BookState> emit) async {
    // if (isFetching) return;

    emit(BookLoading());
    // isFetching = true;
    currentQuery = event.searchQuery;
    currentPage = 1;

    final books =
        await searchBooks.searchBooks(event.searchQuery, currentPage, 10);
    print("bclocBooks---$books");
    books.fold(
      (failure) {
        print("failure-");
        emit(BookError(failure.message));
      },
      (data) {
        print("dataloaded-");
        if (data.isNotEmpty) {
          emit(BookLoaded(result: data, hasReachedMax: data.length < 10));
          currentPage++;
        } else {
          emit(BookEmpty());
        }
      },
    );
  }

  void _onSearchNextPage(NextPage event, Emitter<BookState> emit) async {
    if (state is BookLoaded) {
      final currentState = state as BookLoaded;
      if (currentState.hasReachedMax) return;
      currentPage++;
      final books =
          await searchBooks.searchBooks(currentQuery, currentPage, 10);
      print("next page ---$books");

      books.fold(
        (failure) {
          print("failure-");
          emit(BookError(failure.message));
        },
        (data) {
          print("dataloaded-${data.length}");
          emit(data.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : BookLoaded(
                  result: currentState.result + data,
                  hasReachedMax: data.length < 10,
                ));
        },
      );
    }
  }

  void _onResetItems(ResetItems event, Emitter<BookState> emit) {
    currentPage = 1;
    currentQuery = '';
    emit(BookInitial());
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
