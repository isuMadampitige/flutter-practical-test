import 'package:equatable/equatable.dart';
import 'package:flutter_practical_test/features/book_details/data/models/book_detail_model.dart';

abstract class BookDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class BookDetailInitial extends BookDetailState {}

class BookDetailEmpty extends BookDetailState {}

class BookDetailLoading extends BookDetailState {}

class BookDetailLoaded extends BookDetailState {
  final BookDetail result;

  BookDetailLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class BooBookDetailError extends BookDetailState {
  final String message;

  BooBookDetailError(this.message);

  @override
  List<Object> get props => [message];
}
