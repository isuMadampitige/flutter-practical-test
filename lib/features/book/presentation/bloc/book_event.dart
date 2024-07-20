import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OnSearchQuery extends BookEvent {
  final String searchQuery;
  OnSearchQuery(this.searchQuery);
}
