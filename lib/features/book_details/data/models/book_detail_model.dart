import 'package:flutter_practical_test/features/book_details/domain/entity/book_detail_entity.dart';

class BookDetail extends BookDetailEntity {
  const BookDetail({
    required super.title,
    required super.image,
    required super.isbn13,
    required super.price,
    required super.subtitle,
    required super.url,
    required super.authors,
    required super.desc,
    required super.error,
    required super.isbn10,
    required super.pages,
    required super.publisher,
    required super.rating,
    required super.year,
  });

  factory BookDetail.fromJson(Map<String, dynamic> json) => BookDetail(
        title: json['title'],
        subtitle: json['subtitle'],
        isbn13: json['isbn13'],
        price: json['price'],
        image: json['image'],
        url: json['url'],
        authors: json['authors'],
        desc: json['desc'],
        error: json['error'],
        isbn10: json['isbn10'],
        pages: json['pages'],
        rating: json['rating'],
        year: json['year'],
        publisher: json['publisher'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'isbn13': isbn13,
        'price': price,
        'image': image,
        'url': url,
        'authors': authors,
        'desc': desc,
        'error': error,
        'isbn10': isbn10,
        'pages': pages,
        'publisher': publisher,
        'rating': rating,
        'year': year
      };

  BookDetailEntity toEntity() => BookDetailEntity(
      title: title,
      subtitle: subtitle,
      isbn13: isbn13,
      price: price,
      image: image,
      url: url,
      authors: authors,
      desc: desc,
      error: error,
      isbn10: isbn10,
      pages: pages,
      publisher: publisher,
      rating: rating,
      year: year);
}
