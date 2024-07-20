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

  BookLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class BookError extends BookState {
  final String message;

  BookError(this.message);

  @override
  List<Object> get props => [message];
}
