/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

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
import 'db_schema/order_item.dart' as _i11;
import 'db_schema/order_status.dart' as _i12;
import 'db_schema/order_status_history.dart' as _i13;
import 'db_schema/payment.dart' as _i14;
import 'db_schema/restaurant.dart' as _i15;
import 'db_schema/restaurant_place.dart' as _i16;
import 'db_schema/special_deals.dart' as _i17;
import 'db_schema/split_payment_participant.dart' as _i18;
import 'db_schema/tag.dart' as _i19;
import 'db_schema/user.dart' as _i20;
import 'db_schema/user_favourite.dart' as _i21;
import 'feed/feed_chunk_response.dart' as _i22;
import 'feed/filtered_feed_response.dart' as _i23;
import 'feed/food_item_response.dart' as _i24;
import 'feed/municipalities_response.dart' as _i25;
import 'feed/restaurant_response.dart' as _i26;
import 'greetings/greeting.dart' as _i27;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i28;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i29;
export 'db_schema/address.dart';
export 'db_schema/basket.dart';
export 'db_schema/basket_food.dart';
export 'db_schema/courier.dart';
export 'db_schema/food_deal.dart';
export 'db_schema/food_item.dart';
export 'db_schema/food_review.dart';
export 'db_schema/food_tag.dart';
export 'db_schema/order.dart';
export 'db_schema/order_item.dart';
export 'db_schema/order_status.dart';
export 'db_schema/order_status_history.dart';
export 'db_schema/payment.dart';
export 'db_schema/restaurant.dart';
export 'db_schema/restaurant_place.dart';
export 'db_schema/special_deals.dart';
export 'db_schema/split_payment_participant.dart';
export 'db_schema/tag.dart';
export 'db_schema/user.dart';
export 'db_schema/user_favourite.dart';
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

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
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
    if (t == _i11.OrderItem) {
      return _i11.OrderItem.fromJson(data) as T;
    }
    if (t == _i12.OrderStatus) {
      return _i12.OrderStatus.fromJson(data) as T;
    }
    if (t == _i13.OrderStatusHistory) {
      return _i13.OrderStatusHistory.fromJson(data) as T;
    }
    if (t == _i14.Payment) {
      return _i14.Payment.fromJson(data) as T;
    }
    if (t == _i15.Restaurant) {
      return _i15.Restaurant.fromJson(data) as T;
    }
    if (t == _i16.RestaurantPlace) {
      return _i16.RestaurantPlace.fromJson(data) as T;
    }
    if (t == _i17.SpecialDeals) {
      return _i17.SpecialDeals.fromJson(data) as T;
    }
    if (t == _i18.SplitPaymentParticipant) {
      return _i18.SplitPaymentParticipant.fromJson(data) as T;
    }
    if (t == _i19.Tag) {
      return _i19.Tag.fromJson(data) as T;
    }
    if (t == _i20.User) {
      return _i20.User.fromJson(data) as T;
    }
    if (t == _i21.UserFavourite) {
      return _i21.UserFavourite.fromJson(data) as T;
    }
    if (t == _i22.FeedChunkResponse) {
      return _i22.FeedChunkResponse.fromJson(data) as T;
    }
    if (t == _i23.FilteredFeedResponse) {
      return _i23.FilteredFeedResponse.fromJson(data) as T;
    }
    if (t == _i24.FoodItemResponse) {
      return _i24.FoodItemResponse.fromJson(data) as T;
    }
    if (t == _i25.MunicipalitiesResponse) {
      return _i25.MunicipalitiesResponse.fromJson(data) as T;
    }
    if (t == _i26.RestaurantResponse) {
      return _i26.RestaurantResponse.fromJson(data) as T;
    }
    if (t == _i27.Greeting) {
      return _i27.Greeting.fromJson(data) as T;
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
    if (t == _i1.getType<_i11.OrderItem?>()) {
      return (data != null ? _i11.OrderItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.OrderStatus?>()) {
      return (data != null ? _i12.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.OrderStatusHistory?>()) {
      return (data != null ? _i13.OrderStatusHistory.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.Payment?>()) {
      return (data != null ? _i14.Payment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Restaurant?>()) {
      return (data != null ? _i15.Restaurant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.RestaurantPlace?>()) {
      return (data != null ? _i16.RestaurantPlace.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.SpecialDeals?>()) {
      return (data != null ? _i17.SpecialDeals.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.SplitPaymentParticipant?>()) {
      return (data != null ? _i18.SplitPaymentParticipant.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.Tag?>()) {
      return (data != null ? _i19.Tag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.User?>()) {
      return (data != null ? _i20.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.UserFavourite?>()) {
      return (data != null ? _i21.UserFavourite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.FeedChunkResponse?>()) {
      return (data != null ? _i22.FeedChunkResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.FilteredFeedResponse?>()) {
      return (data != null ? _i23.FilteredFeedResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.FoodItemResponse?>()) {
      return (data != null ? _i24.FoodItemResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.MunicipalitiesResponse?>()) {
      return (data != null ? _i25.MunicipalitiesResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.RestaurantResponse?>()) {
      return (data != null ? _i26.RestaurantResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.Greeting?>()) {
      return (data != null ? _i27.Greeting.fromJson(data) : null) as T;
    }
    if (t == List<_i24.FoodItemResponse>) {
      return (data as List)
          .map((e) => deserialize<_i24.FoodItemResponse>(e))
          .toList() as T;
    }
    if (t == List<_i26.RestaurantResponse>) {
      return (data as List)
          .map((e) => deserialize<_i26.RestaurantResponse>(e))
          .toList() as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    try {
      return _i28.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i29.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.Address) {
      return 'Address';
    }
    if (data is _i3.Basket) {
      return 'Basket';
    }
    if (data is _i4.BasketFood) {
      return 'BasketFood';
    }
    if (data is _i5.Courier) {
      return 'Courier';
    }
    if (data is _i6.FoodDeal) {
      return 'FoodDeal';
    }
    if (data is _i7.FoodItem) {
      return 'FoodItem';
    }
    if (data is _i8.FoodReview) {
      return 'FoodReview';
    }
    if (data is _i9.FoodTag) {
      return 'FoodTag';
    }
    if (data is _i10.Order) {
      return 'Order';
    }
    if (data is _i11.OrderItem) {
      return 'OrderItem';
    }
    if (data is _i12.OrderStatus) {
      return 'OrderStatus';
    }
    if (data is _i13.OrderStatusHistory) {
      return 'OrderStatusHistory';
    }
    if (data is _i14.Payment) {
      return 'Payment';
    }
    if (data is _i15.Restaurant) {
      return 'Restaurant';
    }
    if (data is _i16.RestaurantPlace) {
      return 'RestaurantPlace';
    }
    if (data is _i17.SpecialDeals) {
      return 'SpecialDeals';
    }
    if (data is _i18.SplitPaymentParticipant) {
      return 'SplitPaymentParticipant';
    }
    if (data is _i19.Tag) {
      return 'Tag';
    }
    if (data is _i20.User) {
      return 'User';
    }
    if (data is _i21.UserFavourite) {
      return 'UserFavourite';
    }
    if (data is _i22.FeedChunkResponse) {
      return 'FeedChunkResponse';
    }
    if (data is _i23.FilteredFeedResponse) {
      return 'FilteredFeedResponse';
    }
    if (data is _i24.FoodItemResponse) {
      return 'FoodItemResponse';
    }
    if (data is _i25.MunicipalitiesResponse) {
      return 'MunicipalitiesResponse';
    }
    if (data is _i26.RestaurantResponse) {
      return 'RestaurantResponse';
    }
    if (data is _i27.Greeting) {
      return 'Greeting';
    }
    className = _i28.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i29.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'OrderItem') {
      return deserialize<_i11.OrderItem>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i12.OrderStatus>(data['data']);
    }
    if (dataClassName == 'OrderStatusHistory') {
      return deserialize<_i13.OrderStatusHistory>(data['data']);
    }
    if (dataClassName == 'Payment') {
      return deserialize<_i14.Payment>(data['data']);
    }
    if (dataClassName == 'Restaurant') {
      return deserialize<_i15.Restaurant>(data['data']);
    }
    if (dataClassName == 'RestaurantPlace') {
      return deserialize<_i16.RestaurantPlace>(data['data']);
    }
    if (dataClassName == 'SpecialDeals') {
      return deserialize<_i17.SpecialDeals>(data['data']);
    }
    if (dataClassName == 'SplitPaymentParticipant') {
      return deserialize<_i18.SplitPaymentParticipant>(data['data']);
    }
    if (dataClassName == 'Tag') {
      return deserialize<_i19.Tag>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i20.User>(data['data']);
    }
    if (dataClassName == 'UserFavourite') {
      return deserialize<_i21.UserFavourite>(data['data']);
    }
    if (dataClassName == 'FeedChunkResponse') {
      return deserialize<_i22.FeedChunkResponse>(data['data']);
    }
    if (dataClassName == 'FilteredFeedResponse') {
      return deserialize<_i23.FilteredFeedResponse>(data['data']);
    }
    if (dataClassName == 'FoodItemResponse') {
      return deserialize<_i24.FoodItemResponse>(data['data']);
    }
    if (dataClassName == 'MunicipalitiesResponse') {
      return deserialize<_i25.MunicipalitiesResponse>(data['data']);
    }
    if (dataClassName == 'RestaurantResponse') {
      return deserialize<_i26.RestaurantResponse>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i27.Greeting>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i28.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i29.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
