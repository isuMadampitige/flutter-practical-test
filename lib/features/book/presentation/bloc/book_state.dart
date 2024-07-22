import 'package:equatable/equatable.dart';
import 'package:flutter_practical_test/features/book/data/models/book_model.dart';

abstract class BookState extends Equatable {
  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookEmpty extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<BookModel> result;
  final bool hasReachedMax;

  BookLoaded({required this.result, this.hasReachedMax = false});

  BookLoaded copyWith({
    List<BookModel>? result,
    bool? hasReachedMax,
  }) {
    return BookLoaded(
      result: result ?? this.result,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [result, hasReachedMax];
}

class BookError extends BookState {
  final String message;

  BookError(this.message);

  @override
  List<Object> get props => [message];
}
