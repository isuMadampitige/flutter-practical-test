import 'package:equatable/equatable.dart';

class BookDetailEntity extends Equatable {
  const BookDetailEntity(
      {required this.title,
      required this.image,
      required this.isbn13,
      required this.price,
      required this.subtitle,
      required this.url,
      required this.authors,
      required this.desc,
      required this.error,
      required this.isbn10,
      required this.pages,
      required this.publisher,
      required this.rating,
      required this.year});

  final String title;
  final String subtitle;
  final String isbn13;
  final String price;
  final String image;
  final String url;
  final String error;
  final String authors;
  final String publisher;
  final String isbn10;
  final String pages;
  final String year;
  final String rating;
  final String desc;
  // final String pdf;

  @override
  List<Object?> get props => [
        title,
        subtitle,
        isbn13,
        price,
        image,
        url,
        error,
        authors,
        publisher,
        isbn10,
        pages,
        year,
        rating,
        desc,
      ];
}
