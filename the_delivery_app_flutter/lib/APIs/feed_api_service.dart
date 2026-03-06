import 'dart:convert';
import 'dart:io';

import '../dtos/feed_portion_dto.dart';
import '../dtos/food_dto.dart';
import '../dtos/price_tier_info_dto.dart';
import '../models/food_filters.dart';
import '../models/location.dart';
import 'i_food_api_service.dart';

class FeedAPIService implements IFoodApiService {
  final String _baseUrl;
  final HttpClient _httpClient;

  FeedAPIService({required String baseUrl})
    : _baseUrl = baseUrl,
      _httpClient = HttpClient();

  Future<Map<String, dynamic>> _get(
    String path,
    Map<String, String> queryParams,
  ) async {
    final uri = Uri.parse(
      '$_baseUrl$path',
    ).replace(queryParameters: queryParams);
    final request = await _httpClient.getUrl(uri);
    final response = await request.close();
    final body = await response.transform(utf8.decoder).join();
    return jsonDecode(body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> _post(
    String path,
    Map<String, dynamic> payload,
  ) async {
    final uri = Uri.parse('$_baseUrl$path');
    final request = await _httpClient.postUrl(uri);
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.write(jsonEncode(payload));
    final response = await request.close();
    final body = await response.transform(utf8.decoder).join();
    return jsonDecode(body) as Map<String, dynamic>;
  }

  @override
  Future<FeedPortionDTO> fetchFeedPortion({
    required String sessionId,
    required Location location,
    FoodFilter? filter,
  }) async {
    final payload = <String, dynamic>{
      'session_id': sessionId,
      'latitude': location.latitude,
      'longitude': location.longitude,
      if (filter != null)
        'filter': {
          if (filter.priceTier != null) 'price_tier': filter.priceTier,
          if (filter.discounted != null) 'discounted': filter.discounted,
          if (filter.category != null) 'category': filter.category,
        },
    };
    final json = await _post('/feed/portion', payload);
    return FeedPortionDTO.fromJson(json);
  }

  @override
  Future<List<FoodDTO>> fetchFoodChunk({required List<String> foodIds}) async {
    final json = await _post('/feed/chunk', {'food_ids': foodIds});
    final items = json['items'] as List<dynamic>;
    return items
        .map((e) => FoodDTO.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<FoodDTO>> search({
    required String query,
    required Location location,
  }) async {
    final json = await _get('/feed/search', {
      'query': query,
      'lat': location.latitude.toString(),
      'lng': location.longitude.toString(),
    });
    final items = json['items'] as List<dynamic>;
    return items
        .map((e) => FoodDTO.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PriceTierInfoDTO> fetchPriceTierInfo({
    required Location location,
  }) async {
    final json = await _get('/feed/price-tiers', {
      'lat': location.latitude.toString(),
      'lng': location.longitude.toString(),
    });
    return PriceTierInfoDTO.fromJson(json);
  }
}
