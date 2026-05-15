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
import 'package:serverpod/serverpod.dart' as _i1;
import '../application/controllers/courier_controller.dart' as _i2;
import '../application/controllers/favourites_controller.dart' as _i3;
import '../application/controllers/feed_controller.dart' as _i4;
import '../application/controllers/order_controller.dart' as _i5;
import '../application/controllers/restaurant_controller.dart' as _i6;
import '../application/controllers/reviews_controller.dart' as _i7;
import '../application/controllers/user_profile_controller.dart' as _i8;
import '../auth/email_idp_endpoint.dart' as _i9;
import '../auth/jwt_refresh_endpoint.dart' as _i10;
import '../greetings/greeting_endpoint.dart' as _i11;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i12;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i13;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i14;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'courierController': _i2.CourierControllerEndpoint()
        ..initialize(
          server,
          'courierController',
          null,
        ),
      'favouritesController': _i3.FavouritesController()
        ..initialize(
          server,
          'favouritesController',
          null,
        ),
      'feedController': _i4.FeedControllerEndpoint()
        ..initialize(
          server,
          'feedController',
          null,
        ),
      'orderController': _i5.OrderControllerEndpoint()
        ..initialize(
          server,
          'orderController',
          null,
        ),
      'restaurantController': _i6.RestaurantController()
        ..initialize(
          server,
          'restaurantController',
          null,
        ),
      'reviewsController': _i7.ReviewsController()
        ..initialize(
          server,
          'reviewsController',
          null,
        ),
      'userProfileController': _i8.UserProfileController()
        ..initialize(
          server,
          'userProfileController',
          null,
        ),
      'emailIdp': _i9.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i10.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'greeting': _i11.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['courierController'] = _i1.EndpointConnector(
      name: 'courierController',
      endpoint: endpoints['courierController']!,
      methodConnectors: {
        'assignCourier': _i1.MethodConnector(
          name: 'assignCourier',
          params: {
            'requestJson': _i1.ParameterDescription(
              name: 'requestJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courierController']
                          as _i2.CourierControllerEndpoint)
                      .assignCourier(
                        session,
                        params['requestJson'],
                      ),
        ),
        'updateDeliveryStatus': _i1.MethodConnector(
          name: 'updateDeliveryStatus',
          params: {
            'requestJson': _i1.ParameterDescription(
              name: 'requestJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courierController']
                          as _i2.CourierControllerEndpoint)
                      .updateDeliveryStatus(
                        session,
                        params['requestJson'],
                      ),
        ),
        'getAvailableCouriers': _i1.MethodConnector(
          name: 'getAvailableCouriers',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['courierController']
                          as _i2.CourierControllerEndpoint)
                      .getAvailableCouriers(session),
        ),
      },
    );
    connectors['favouritesController'] = _i1.EndpointConnector(
      name: 'favouritesController',
      endpoint: endpoints['favouritesController']!,
      methodConnectors: {
        'getFavourites': _i1.MethodConnector(
          name: 'getFavourites',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['favouritesController']
                          as _i3.FavouritesController)
                      .getFavourites(
                        session,
                        params['userId'],
                      ),
        ),
        'addFavourite': _i1.MethodConnector(
          name: 'addFavourite',
          params: {
            'requestJson': _i1.ParameterDescription(
              name: 'requestJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['favouritesController']
                          as _i3.FavouritesController)
                      .addFavourite(
                        session,
                        params['requestJson'],
                      ),
        ),
        'removeFavourite': _i1.MethodConnector(
          name: 'removeFavourite',
          params: {
            'favouriteId': _i1.ParameterDescription(
              name: 'favouriteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['favouritesController']
                          as _i3.FavouritesController)
                      .removeFavourite(
                        session,
                        params['favouriteId'],
                      ),
        ),
      },
    );
    connectors['feedController'] = _i1.EndpointConnector(
      name: 'feedController',
      endpoint: endpoints['feedController']!,
      methodConnectors: {
        'getFeedChunk': _i1.MethodConnector(
          name: 'getFeedChunk',
          params: {
            'screenWidth': _i1.ParameterDescription(
              name: 'screenWidth',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'screenHeight': _i1.ParameterDescription(
              name: 'screenHeight',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'dpi': _i1.ParameterDescription(
              name: 'dpi',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'dataTransferRate': _i1.ParameterDescription(
              name: 'dataTransferRate',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'userLatitude': _i1.ParameterDescription(
              name: 'userLatitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'userLongitude': _i1.ParameterDescription(
              name: 'userLongitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'chunkSize': _i1.ParameterDescription(
              name: 'chunkSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'chunkOffset': _i1.ParameterDescription(
              name: 'chunkOffset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'filters': _i1.ParameterDescription(
              name: 'filters',
              type: _i1.getType<Map<String, dynamic>?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['feedController'] as _i4.FeedControllerEndpoint)
                      .getFeedChunk(
                        session,
                        params['screenWidth'],
                        params['screenHeight'],
                        params['dpi'],
                        params['dataTransferRate'],
                        params['userLatitude'],
                        params['userLongitude'],
                        params['chunkSize'],
                        params['chunkOffset'],
                        params['filters'],
                      ),
        ),
        'getSpecialDeals': _i1.MethodConnector(
          name: 'getSpecialDeals',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'city': _i1.ParameterDescription(
              name: 'city',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['feedController'] as _i4.FeedControllerEndpoint)
                      .getSpecialDeals(
                        session,
                        params['limit'],
                        params['city'],
                      ),
        ),
        'search': _i1.MethodConnector(
          name: 'search',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'city': _i1.ParameterDescription(
              name: 'city',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['feedController'] as _i4.FeedControllerEndpoint)
                      .search(
                        session,
                        params['query'],
                        params['limit'],
                        params['city'],
                      ),
        ),
      },
    );
    connectors['orderController'] = _i1.EndpointConnector(
      name: 'orderController',
      endpoint: endpoints['orderController']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['orderController'] as _i5.OrderControllerEndpoint)
                      .hello(session),
        ),
        'getOrder': _i1.MethodConnector(
          name: 'getOrder',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['orderController'] as _i5.OrderControllerEndpoint)
                      .getOrder(
                        session,
                        params['orderId'],
                      ),
        ),
        'getOrderDetails': _i1.MethodConnector(
          name: 'getOrderDetails',
          params: {
            'requestJson': _i1.ParameterDescription(
              name: 'requestJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['orderController'] as _i5.OrderControllerEndpoint)
                      .getOrderDetails(
                        session,
                        params['requestJson'],
                      ),
        ),
        'createOrder': _i1.MethodConnector(
          name: 'createOrder',
          params: {
            'requestJson': _i1.ParameterDescription(
              name: 'requestJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['orderController'] as _i5.OrderControllerEndpoint)
                      .createOrder(
                        session,
                        params['requestJson'],
                      ),
        ),
        'processPayment': _i1.MethodConnector(
          name: 'processPayment',
          params: {
            'requestJson': _i1.ParameterDescription(
              name: 'requestJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['orderController'] as _i5.OrderControllerEndpoint)
                      .processPayment(
                        session,
                        params['requestJson'],
                      ),
        ),
        'getHistory': _i1.MethodConnector(
          name: 'getHistory',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['orderController'] as _i5.OrderControllerEndpoint)
                      .getHistory(
                        session,
                        params['userId'],
                        params['limit'],
                        params['offset'],
                      ),
        ),
        'getTrackingInfo': _i1.MethodConnector(
          name: 'getTrackingInfo',
          params: {
            'requestJson': _i1.ParameterDescription(
              name: 'requestJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['orderController'] as _i5.OrderControllerEndpoint)
                      .getTrackingInfo(
                        session,
                        params['requestJson'],
                      ),
        ),
        'updateCourierLocation': _i1.MethodConnector(
          name: 'updateCourierLocation',
          params: {
            'requestJson': _i1.ParameterDescription(
              name: 'requestJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['orderController'] as _i5.OrderControllerEndpoint)
                      .updateCourierLocation(
                        session,
                        params['requestJson'],
                      ),
        ),
      },
    );
    connectors['restaurantController'] = _i1.EndpointConnector(
      name: 'restaurantController',
      endpoint: endpoints['restaurantController']!,
      methodConnectors: {
        'getRestaurant': _i1.MethodConnector(
          name: 'getRestaurant',
          params: {
            'restaurantId': _i1.ParameterDescription(
              name: 'restaurantId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['restaurantController']
                          as _i6.RestaurantController)
                      .getRestaurant(
                        session,
                        params['restaurantId'],
                      ),
        ),
        'getMenu': _i1.MethodConnector(
          name: 'getMenu',
          params: {
            'restaurantId': _i1.ParameterDescription(
              name: 'restaurantId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['restaurantController']
                          as _i6.RestaurantController)
                      .getMenu(
                        session,
                        params['restaurantId'],
                      ),
        ),
        'getReviews': _i1.MethodConnector(
          name: 'getReviews',
          params: {
            'restaurantId': _i1.ParameterDescription(
              name: 'restaurantId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['restaurantController']
                          as _i6.RestaurantController)
                      .getReviews(
                        session,
                        params['restaurantId'],
                        params['limit'],
                        params['offset'],
                      ),
        ),
        'getFeatured': _i1.MethodConnector(
          name: 'getFeatured',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['restaurantController']
                          as _i6.RestaurantController)
                      .getFeatured(
                        session,
                        params['limit'],
                      ),
        ),
      },
    );
    connectors['reviewsController'] = _i1.EndpointConnector(
      name: 'reviewsController',
      endpoint: endpoints['reviewsController']!,
      methodConnectors: {
        'createReview': _i1.MethodConnector(
          name: 'createReview',
          params: {
            'requestJson': _i1.ParameterDescription(
              name: 'requestJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reviewsController'] as _i7.ReviewsController)
                      .createReview(
                        session,
                        params['requestJson'],
                      ),
        ),
        'getReviews': _i1.MethodConnector(
          name: 'getReviews',
          params: {
            'foodId': _i1.ParameterDescription(
              name: 'foodId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reviewsController'] as _i7.ReviewsController)
                      .getReviews(
                        session,
                        params['foodId'],
                        params['limit'],
                        params['offset'],
                      ),
        ),
        'deleteReview': _i1.MethodConnector(
          name: 'deleteReview',
          params: {
            'reviewId': _i1.ParameterDescription(
              name: 'reviewId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reviewsController'] as _i7.ReviewsController)
                      .deleteReview(
                        session,
                        params['reviewId'],
                      ),
        ),
      },
    );
    connectors['userProfileController'] = _i1.EndpointConnector(
      name: 'userProfileController',
      endpoint: endpoints['userProfileController']!,
      methodConnectors: {
        'getCurrentUser': _i1.MethodConnector(
          name: 'getCurrentUser',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileController']
                          as _i8.UserProfileController)
                      .getCurrentUser(session),
        ),
        'getProfile': _i1.MethodConnector(
          name: 'getProfile',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileController']
                          as _i8.UserProfileController)
                      .getProfile(
                        session,
                        params['userId'],
                      ),
        ),
        'updateProfile': _i1.MethodConnector(
          name: 'updateProfile',
          params: {
            'requestJson': _i1.ParameterDescription(
              name: 'requestJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileController']
                          as _i8.UserProfileController)
                      .updateProfile(
                        session,
                        params['requestJson'],
                      ),
        ),
        'addAddress': _i1.MethodConnector(
          name: 'addAddress',
          params: {
            'requestJson': _i1.ParameterDescription(
              name: 'requestJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileController']
                          as _i8.UserProfileController)
                      .addAddress(
                        session,
                        params['requestJson'],
                      ),
        ),
        'deleteAddress': _i1.MethodConnector(
          name: 'deleteAddress',
          params: {
            'addressId': _i1.ParameterDescription(
              name: 'addressId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileController']
                          as _i8.UserProfileController)
                      .deleteAddress(
                        session,
                        params['addressId'],
                      ),
        ),
      },
    );
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i9.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i9.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i9.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i9.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i9.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i9.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i9.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i9.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i10.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i11.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i12.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth'] = _i13.Endpoints()..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i14.Endpoints()
      ..initializeEndpoints(server);
  }
}
