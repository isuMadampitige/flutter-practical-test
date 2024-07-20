import 'package:equatable/equatable.dart';

abstract class BookDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OnBookDetails extends BookDetailEvent {
  final String data;
  OnBookDetails(this.data);
}
