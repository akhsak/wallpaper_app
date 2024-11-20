import 'package:dio/dio.dart';
import 'package:wallpaper_app/model/model.dart';

class PexelsService {
  final String _baseUrl = 'https://api.pexels.com/v1/curated?per_page=80';
  final String _apiKey =
      'JJ71EPRp9mENolqJqTOrmixC51Ds7COsU08gFIAZb3oaD4PFaRv4WxQO';
  final Dio _dio = Dio();

  PexelsService() {
    _dio.options.headers['Authorization'] = _apiKey;
  }

  Future<List<Photo>> fetchPhotos(int page) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {'page': page, 'per_page': 15},
      );
      final List<dynamic> photosJson = response.data['photos'];
      return photosJson.map((json) => Photo.fromJson(json)).toList();
    } catch (e) {
      print('Error in fetchPhotos: $e');
      throw Exception('Failed to load photos: $e');
    }
  }
}
