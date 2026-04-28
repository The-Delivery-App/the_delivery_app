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
import '../application/controllers/favourites_controller.dart' as _i2;
import '../application/controllers/feed_controller.dart' as _i3;
import '../application/controllers/order_controller.dart' as _i4;
import '../application/controllers/restaurant_controller.dart' as _i5;
import '../application/controllers/reviews_controller.dart' as _i6;
import '../application/controllers/user_profile_controller.dart' as _i7;
import '../auth/email_idp_endpoint.dart' as _i8;
import '../auth/jwt_refresh_endpoint.dart' as _i9;
import '../greetings/greeting_endpoint.dart' as _i10;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i11;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i12;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'favouritesController': _i2.FavouritesController()
        ..initialize(
          server,
          'favouritesController',
          null,
        ),
      'feedController': _i3.FeedController()
        ..initialize(
          server,
          'feedController',
          null,
        ),
      'orderController': _i4.OrderController()
        ..initialize(
          server,
          'orderController',
          null,
        ),
      'restaurantController': _i5.RestaurantController()
        ..initialize(
          server,
          'restaurantController',
          null,
        ),
      'reviewsController': _i6.ReviewsController()
        ..initialize(
          server,
          'reviewsController',
          null,
        ),
      'userProfileController': _i7.UserProfileController()
        ..initialize(
          server,
          'userProfileController',
          null,
        ),
      'emailIdp': _i8.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i9.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'greeting': _i10.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['favouritesController'] = _i1.EndpointConnector(
      name: 'favouritesController',
      endpoint: endpoints['favouritesController']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['favouritesController']
                          as _i2.FavouritesController)
                      .hello(session),
        ),
      },
    );
    connectors['feedController'] = _i1.EndpointConnector(
      name: 'feedController',
      endpoint: endpoints['feedController']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['feedController'] as _i3.FeedController)
                  .hello(session),
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
              ) async => (endpoints['orderController'] as _i4.OrderController)
                  .hello(session),
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
                          as _i5.RestaurantController)
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
                          as _i5.RestaurantController)
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
                          as _i5.RestaurantController)
                      .getReviews(
                        session,
                        params['restaurantId'],
                        params['limit'],
                        params['offset'],
                      ),
        ),
      },
    );
    connectors['reviewsController'] = _i1.EndpointConnector(
      name: 'reviewsController',
      endpoint: endpoints['reviewsController']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reviewsController'] as _i6.ReviewsController)
                      .hello(session),
        ),
      },
    );
    connectors['userProfileController'] = _i1.EndpointConnector(
      name: 'userProfileController',
      endpoint: endpoints['userProfileController']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileController']
                          as _i7.UserProfileController)
                      .hello(session),
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
              ) async => (endpoints['emailIdp'] as _i8.EmailIdpEndpoint).login(
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
              ) async => (endpoints['emailIdp'] as _i8.EmailIdpEndpoint)
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
              ) async => (endpoints['emailIdp'] as _i8.EmailIdpEndpoint)
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
              ) async => (endpoints['emailIdp'] as _i8.EmailIdpEndpoint)
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
              ) async => (endpoints['emailIdp'] as _i8.EmailIdpEndpoint)
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
              ) async => (endpoints['emailIdp'] as _i8.EmailIdpEndpoint)
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
              ) async => (endpoints['emailIdp'] as _i8.EmailIdpEndpoint)
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
              ) async => (endpoints['emailIdp'] as _i8.EmailIdpEndpoint)
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
              ) async => (endpoints['jwtRefresh'] as _i9.JwtRefreshEndpoint)
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
              ) async => (endpoints['greeting'] as _i10.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i11.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i12.Endpoints()
      ..initializeEndpoints(server);
  }
}
