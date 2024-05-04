class FilterModel {
  FilterModel({
    this.year,
    this.genre,
    this.language,
    this.country,
    this.rating,
    this.quality,
    this.orderBy,
  });

  String? year;
  int? genre;
  String? language;
  String? country;
  String? rating;
  String? quality;
  String? orderBy;

  bool get isEmpty {
    return year == null &&
        genre == null &&
        language == null &&
        country == null &&
        rating == null &&
        quality == null &&
        orderBy == null;
  }

  FilterModel copyWith({
    String? year,
    int? genre,
    String? language,
    String? country,
    String? rating,
    String? quality,
    String? orderBy,
  }) {
    return FilterModel(
      year: year ?? this.year,
      genre: genre ?? this.genre,
      language: language ?? this.language,
      country: country ?? this.country,
      rating: rating ?? this.rating,
      quality: quality ?? this.quality,
      orderBy: orderBy ?? this.orderBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'release_date.gte': year,
      'with_genres': genre,
      'language': language,
      'country': country,
      'vote_average.gte': rating,
      'quality': quality,
      'orderBy': orderBy,
    };
  }

  factory FilterModel.fromMap(Map<String, dynamic> map) {
    return FilterModel(
      year: map['year'],
      genre: map['genre'],
      language: map['language'],
      country: map['country'],
      rating: map['rating'],
      quality: map['quality'],
      orderBy: map['orderBy'],
    );
  }

  @override
  String toString() {
    return 'FilterModel(year: $year, genre: $genre, language: $language, country: $country, rating: $rating, quality: $quality, orderBy: $orderBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterModel &&
        other.year == year &&
        other.genre == genre &&
        other.language == language &&
        other.country == country &&
        other.rating == rating &&
        other.quality == quality &&
        other.orderBy == orderBy;
  }

  @override
  int get hashCode {
    return year.hashCode ^
        genre.hashCode ^
        language.hashCode ^
        country.hashCode ^
        rating.hashCode ^
        quality.hashCode ^
        orderBy.hashCode;
  }
}
