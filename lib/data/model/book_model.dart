class Book {
  final int? id;
  final String title;
  final String author;
  final int year;
  final double rating;
  final String category;
  final String image;
  final String description;
  final bool favorite;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.year,
    required this.rating,
    required this.category,
    required this.image,
    required this.description,
    this.favorite = false,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'author': author,
      'year': year,
      'rating': rating,
      'category': category,
      'image': image,
      'description': description,
      'favorite': favorite ? 1 : 0,
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Extract a Book object from a Map object (from SQLite)
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      year: map['year'],
      rating: map['rating'],
      category: map['category'],
      image: map['image'],
      description: map['description'],
      favorite: map['favorite'] == 1,
    );
  }

  Book copyWith({
    int? id,
    String? title,
    String? author,
    int? year,
    double? rating,
    String? category,
    String? image,
    String? description,
    bool? favorite,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      year: year ?? this.year,
      rating: rating ?? this.rating,
      category: category ?? this.category,
      image: image ?? this.image,
      description: description ?? this.description,
      favorite: favorite ?? this.favorite,
    );
  }
}
