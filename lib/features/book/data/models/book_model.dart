import 'package:flutter_practical_test/features/book/domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  const BookModel({
    required super.title,
    required super.subtitle,
    required super.isbn13,
    required super.price,
    required super.image,
    required super.url,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        title: json['title'],
        subtitle: json['subtitle'],
        isbn13: json['isbn13'],
        price: json['price'],
        image: json['image'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'isbn13': isbn13,
        'price': price,
        'image': image,
        'url': url,
      };

  BookEntity toEntity() => BookEntity(
        title: title,
        subtitle: subtitle,
        isbn13: isbn13,
        price: price,
        image: image,
        url: url,
      );
}
