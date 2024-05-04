class GenreModel {
  GenreModel({
    required this.genres,
  });

  final List<Genre> genres;

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      genres: json["genres"] == null
          ? []
          : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
    );
  }
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json["id"],
      name: json["name"],
    );
  }
}
