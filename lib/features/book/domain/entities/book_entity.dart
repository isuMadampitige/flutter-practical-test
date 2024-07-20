import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  const BookEntity(
      {required this.title,
      required this.image,
      required this.isbn13,
      required this.price,
      required this.subtitle,
      required this.url});

  final String title;
  final String subtitle;
  final String isbn13;
  final String price;
  final String image;
  final String url;

  @override
  List<Object?> get props => [
        title,
        subtitle,
        image,
        isbn13,
        price,
        url,
      ];
}
