class Movie {
  final String title;
  final String id;
  final String posterUrl;
  final int year;
  final String description;

  Movie({
    required this.title,
    required this.id,
    required this.posterUrl,
    required this.year,
    required this.description,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['primaryTitle'] ?? 'Unknown Title',
      id: json['id'] ?? '',
      posterUrl: json['primaryImage'] ?? '',
      year: json['startYear'] ?? 0,
      description: json['description'] ?? 'NA',
    );
  }
}
