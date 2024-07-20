import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_test/features/book_details/presentaion/bloc/book_details_event.dart';
import 'package:flutter_practical_test/features/book_details/presentaion/bloc/book_details_state.dart';
import '../../domain/usecases/book_details.dart';

class BookDetaisBloc extends Bloc<BookDetailEvent, BookDetailState> {
  final BookDetailsFetch bookDetailsFetch;

  BookDetaisBloc(this.bookDetailsFetch) : super(BookDetailEmpty()) {
    on<OnBookDetails>(_mapEventToState);
  }

  void _mapEventToState(
      OnBookDetails event, Emitter<BookDetailState> emit) async {
    emit(BookDetailLoading());
    final books = await bookDetailsFetch.bookDetails(event.data);
    print("details---$books");
    books.fold(
      (failure) {
        emit(BooBookDetailError(failure.message));
      },
      (data) {
        emit(BookDetailLoaded(data));
      },
    );
  }
}
