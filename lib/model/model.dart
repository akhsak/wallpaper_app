// class Photo {
//   final int id;
//   final String photographer;
//   final String imageUrl;

//   Photo({
//     required this.id,
//     required this.photographer,
//     required this.imageUrl,
//   });

//   // Factory method to create a Photo instance from JSON data
//   factory Photo.fromJson(Map<String, dynamic> json) {
//     return Photo(
//       id: json['id'] as int,
//       photographer: json['photographer'] as String,
//       imageUrl: json['src']['medium'] as String, // Use 'medium' size for the grid
//     );
//   }
// }
class PhotoResponse {
  final int page;
  final int perPage;
  final List<Photo> photos;
  final String? nextPage;

  PhotoResponse({
    required this.page,
    required this.perPage,
    required this.photos,
    this.nextPage,
  });

  factory PhotoResponse.fromJson(Map<String, dynamic> json) {
    return PhotoResponse(
      page: json['page'],
      perPage: json['per_page'],
      photos: List<Photo>.from(json['photos'].map((photo) => Photo.fromJson(photo))),
      nextPage: json['next_page'],
    );
  }
}

class Photo {
  final int id;
  final int width;
  final int height;
  final String url;
  final String photographer;
  final String photographerUrl;
  final int photographerId;
  final String avgColor;
  final Src src;
  final bool liked;
  final String alt;

  Photo({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.avgColor,
    required this.src,
    required this.liked,
    required this.alt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      photographer: json['photographer'],
      photographerUrl: json['photographer_url'],
      photographerId: json['photographer_id'],
      avgColor: json['avg_color'],
      src: Src.fromJson(json['src']),
      liked: json['liked'],
      alt: json['alt'],
    );
  }
}

class Src {
  final String original;
  final String large2x;
  final String large;
  final String medium;
  final String small;
  final String portrait;
  final String landscape;
  final String tiny;

  Src({
    required this.original,
    required this.large2x,
    required this.large,
    required this.medium,
    required this.small,
    required this.portrait,
    required this.landscape,
    required this.tiny,
  });

  factory Src.fromJson(Map<String, dynamic> json) {
    return Src(
      original: json['original'],
      large2x: json['large2x'],
      large: json['large'],
      medium: json['medium'],
      small: json['small'],
      portrait: json['portrait'],
      landscape: json['landscape'],
      tiny: json['tiny'],
    );
  }
}