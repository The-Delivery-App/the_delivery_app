/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'db_schema/address.dart' as _i2;
import 'db_schema/basket.dart' as _i3;
import 'db_schema/basket_food.dart' as _i4;
import 'db_schema/courier.dart' as _i5;
import 'db_schema/food_deal.dart' as _i6;
import 'db_schema/food_item.dart' as _i7;
import 'db_schema/food_review.dart' as _i8;
import 'db_schema/food_tag.dart' as _i9;
import 'db_schema/order.dart' as _i10;
import 'db_schema/order_status.dart' as _i11;
import 'db_schema/order_status_history.dart' as _i12;
import 'db_schema/payment.dart' as _i13;
import 'db_schema/restaurant.dart' as _i14;
import 'db_schema/restaurant_place.dart' as _i15;
import 'db_schema/special_deals.dart' as _i16;
import 'db_schema/tag.dart' as _i17;
import 'db_schema/user.dart' as _i18;
import 'feed/feed_chunk_response.dart' as _i19;
import 'feed/filtered_feed_response.dart' as _i20;
import 'feed/food_item_response.dart' as _i21;
import 'feed/municipalities_response.dart' as _i22;
import 'feed/restaurant_response.dart' as _i23;
import 'greetings/greeting.dart' as _i24;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i25;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i26;
export 'db_schema/address.dart';
export 'db_schema/basket.dart';
export 'db_schema/basket_food.dart';
export 'db_schema/courier.dart';
export 'db_schema/food_deal.dart';
export 'db_schema/food_item.dart';
export 'db_schema/food_review.dart';
export 'db_schema/food_tag.dart';
export 'db_schema/order.dart';
export 'db_schema/order_status.dart';
export 'db_schema/order_status_history.dart';
export 'db_schema/payment.dart';
export 'db_schema/restaurant.dart';
export 'db_schema/restaurant_place.dart';
export 'db_schema/special_deals.dart';
export 'db_schema/tag.dart';
export 'db_schema/user.dart';
export 'feed/feed_chunk_response.dart';
export 'feed/filtered_feed_response.dart';
export 'feed/food_item_response.dart';
export 'feed/municipalities_response.dart';
export 'feed/restaurant_response.dart';
export 'greetings/greeting.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.Address) {
      return _i2.Address.fromJson(data) as T;
    }
    if (t == _i3.Basket) {
      return _i3.Basket.fromJson(data) as T;
    }
    if (t == _i4.BasketFood) {
      return _i4.BasketFood.fromJson(data) as T;
    }
    if (t == _i5.Courier) {
      return _i5.Courier.fromJson(data) as T;
    }
    if (t == _i6.FoodDeal) {
      return _i6.FoodDeal.fromJson(data) as T;
    }
    if (t == _i7.FoodItem) {
      return _i7.FoodItem.fromJson(data) as T;
    }
    if (t == _i8.FoodReview) {
      return _i8.FoodReview.fromJson(data) as T;
    }
    if (t == _i9.FoodTag) {
      return _i9.FoodTag.fromJson(data) as T;
    }
    if (t == _i10.Order) {
      return _i10.Order.fromJson(data) as T;
    }
    if (t == _i11.OrderStatus) {
      return _i11.OrderStatus.fromJson(data) as T;
    }
    if (t == _i12.OrderStatusHistory) {
      return _i12.OrderStatusHistory.fromJson(data) as T;
    }
    if (t == _i13.Payment) {
      return _i13.Payment.fromJson(data) as T;
    }
    if (t == _i14.Restaurant) {
      return _i14.Restaurant.fromJson(data) as T;
    }
    if (t == _i15.RestaurantPlace) {
      return _i15.RestaurantPlace.fromJson(data) as T;
    }
    if (t == _i16.SpecialDeals) {
      return _i16.SpecialDeals.fromJson(data) as T;
    }
    if (t == _i17.Tag) {
      return _i17.Tag.fromJson(data) as T;
    }
    if (t == _i18.User) {
      return _i18.User.fromJson(data) as T;
    }
    if (t == _i19.FeedChunkResponse) {
      return _i19.FeedChunkResponse.fromJson(data) as T;
    }
    if (t == _i20.FilteredFeedResponse) {
      return _i20.FilteredFeedResponse.fromJson(data) as T;
    }
    if (t == _i21.FoodItemResponse) {
      return _i21.FoodItemResponse.fromJson(data) as T;
    }
    if (t == _i22.MunicipalitiesResponse) {
      return _i22.MunicipalitiesResponse.fromJson(data) as T;
    }
    if (t == _i23.RestaurantResponse) {
      return _i23.RestaurantResponse.fromJson(data) as T;
    }
    if (t == _i24.Greeting) {
      return _i24.Greeting.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Address?>()) {
      return (data != null ? _i2.Address.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Basket?>()) {
      return (data != null ? _i3.Basket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.BasketFood?>()) {
      return (data != null ? _i4.BasketFood.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Courier?>()) {
      return (data != null ? _i5.Courier.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.FoodDeal?>()) {
      return (data != null ? _i6.FoodDeal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.FoodItem?>()) {
      return (data != null ? _i7.FoodItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.FoodReview?>()) {
      return (data != null ? _i8.FoodReview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.FoodTag?>()) {
      return (data != null ? _i9.FoodTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Order?>()) {
      return (data != null ? _i10.Order.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.OrderStatus?>()) {
      return (data != null ? _i11.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.OrderStatusHistory?>()) {
      return (data != null ? _i12.OrderStatusHistory.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.Payment?>()) {
      return (data != null ? _i13.Payment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Restaurant?>()) {
      return (data != null ? _i14.Restaurant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.RestaurantPlace?>()) {
      return (data != null ? _i15.RestaurantPlace.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.SpecialDeals?>()) {
      return (data != null ? _i16.SpecialDeals.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Tag?>()) {
      return (data != null ? _i17.Tag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.User?>()) {
      return (data != null ? _i18.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.FeedChunkResponse?>()) {
      return (data != null ? _i19.FeedChunkResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.FilteredFeedResponse?>()) {
      return (data != null ? _i20.FilteredFeedResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.FoodItemResponse?>()) {
      return (data != null ? _i21.FoodItemResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.MunicipalitiesResponse?>()) {
      return (data != null ? _i22.MunicipalitiesResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.RestaurantResponse?>()) {
      return (data != null ? _i23.RestaurantResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.Greeting?>()) {
      return (data != null ? _i24.Greeting.fromJson(data) : null) as T;
    }
    if (t == List<_i21.FoodItemResponse>) {
      return (data as List)
              .map((e) => deserialize<_i21.FoodItemResponse>(e))
              .toList()
          as T;
    }
    if (t == List<_i23.RestaurantResponse>) {
      return (data as List)
              .map((e) => deserialize<_i23.RestaurantResponse>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    if (t == _i1.getType<Map<String, dynamic>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
                )
              : null)
          as T;
    }
    try {
      return _i25.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i26.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Address => 'Address',
      _i3.Basket => 'Basket',
      _i4.BasketFood => 'BasketFood',
      _i5.Courier => 'Courier',
      _i6.FoodDeal => 'FoodDeal',
      _i7.FoodItem => 'FoodItem',
      _i8.FoodReview => 'FoodReview',
      _i9.FoodTag => 'FoodTag',
      _i10.Order => 'Order',
      _i11.OrderStatus => 'OrderStatus',
      _i12.OrderStatusHistory => 'OrderStatusHistory',
      _i13.Payment => 'Payment',
      _i14.Restaurant => 'Restaurant',
      _i15.RestaurantPlace => 'RestaurantPlace',
      _i16.SpecialDeals => 'SpecialDeals',
      _i17.Tag => 'Tag',
      _i18.User => 'User',
      _i19.FeedChunkResponse => 'FeedChunkResponse',
      _i20.FilteredFeedResponse => 'FilteredFeedResponse',
      _i21.FoodItemResponse => 'FoodItemResponse',
      _i22.MunicipalitiesResponse => 'MunicipalitiesResponse',
      _i23.RestaurantResponse => 'RestaurantResponse',
      _i24.Greeting => 'Greeting',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'the_delivery_app.',
        '',
      );
    }

    switch (data) {
      case _i2.Address():
        return 'Address';
      case _i3.Basket():
        return 'Basket';
      case _i4.BasketFood():
        return 'BasketFood';
      case _i5.Courier():
        return 'Courier';
      case _i6.FoodDeal():
        return 'FoodDeal';
      case _i7.FoodItem():
        return 'FoodItem';
      case _i8.FoodReview():
        return 'FoodReview';
      case _i9.FoodTag():
        return 'FoodTag';
      case _i10.Order():
        return 'Order';
      case _i11.OrderStatus():
        return 'OrderStatus';
      case _i12.OrderStatusHistory():
        return 'OrderStatusHistory';
      case _i13.Payment():
        return 'Payment';
      case _i14.Restaurant():
        return 'Restaurant';
      case _i15.RestaurantPlace():
        return 'RestaurantPlace';
      case _i16.SpecialDeals():
        return 'SpecialDeals';
      case _i17.Tag():
        return 'Tag';
      case _i18.User():
        return 'User';
      case _i19.FeedChunkResponse():
        return 'FeedChunkResponse';
      case _i20.FilteredFeedResponse():
        return 'FilteredFeedResponse';
      case _i21.FoodItemResponse():
        return 'FoodItemResponse';
      case _i22.MunicipalitiesResponse():
        return 'MunicipalitiesResponse';
      case _i23.RestaurantResponse():
        return 'RestaurantResponse';
      case _i24.Greeting():
        return 'Greeting';
    }
    className = _i25.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i26.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Address') {
      return deserialize<_i2.Address>(data['data']);
    }
    if (dataClassName == 'Basket') {
      return deserialize<_i3.Basket>(data['data']);
    }
    if (dataClassName == 'BasketFood') {
      return deserialize<_i4.BasketFood>(data['data']);
    }
    if (dataClassName == 'Courier') {
      return deserialize<_i5.Courier>(data['data']);
    }
    if (dataClassName == 'FoodDeal') {
      return deserialize<_i6.FoodDeal>(data['data']);
    }
    if (dataClassName == 'FoodItem') {
      return deserialize<_i7.FoodItem>(data['data']);
    }
    if (dataClassName == 'FoodReview') {
      return deserialize<_i8.FoodReview>(data['data']);
    }
    if (dataClassName == 'FoodTag') {
      return deserialize<_i9.FoodTag>(data['data']);
    }
    if (dataClassName == 'Order') {
      return deserialize<_i10.Order>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i11.OrderStatus>(data['data']);
    }
    if (dataClassName == 'OrderStatusHistory') {
      return deserialize<_i12.OrderStatusHistory>(data['data']);
    }
    if (dataClassName == 'Payment') {
      return deserialize<_i13.Payment>(data['data']);
    }
    if (dataClassName == 'Restaurant') {
      return deserialize<_i14.Restaurant>(data['data']);
    }
    if (dataClassName == 'RestaurantPlace') {
      return deserialize<_i15.RestaurantPlace>(data['data']);
    }
    if (dataClassName == 'SpecialDeals') {
      return deserialize<_i16.SpecialDeals>(data['data']);
    }
    if (dataClassName == 'Tag') {
      return deserialize<_i17.Tag>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i18.User>(data['data']);
    }
    if (dataClassName == 'FeedChunkResponse') {
      return deserialize<_i19.FeedChunkResponse>(data['data']);
    }
    if (dataClassName == 'FilteredFeedResponse') {
      return deserialize<_i20.FilteredFeedResponse>(data['data']);
    }
    if (dataClassName == 'FoodItemResponse') {
      return deserialize<_i21.FoodItemResponse>(data['data']);
    }
    if (dataClassName == 'MunicipalitiesResponse') {
      return deserialize<_i22.MunicipalitiesResponse>(data['data']);
    }
    if (dataClassName == 'RestaurantResponse') {
      return deserialize<_i23.RestaurantResponse>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i24.Greeting>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i25.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i26.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i25.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i26.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
