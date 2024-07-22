import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OnSearchQuery extends BookEvent {
  final String searchQuery;
  final int page;

  OnSearchQuery(this.searchQuery, this.page);

  @override
  List<Object> get props => [searchQuery, page];
}

class ResetItems extends BookEvent {}

class NextPage extends BookEvent {}
