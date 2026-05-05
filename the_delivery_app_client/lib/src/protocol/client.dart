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
import 'dart:async' as _i2;
import 'package:the_delivery_app_client/src/protocol/feed/feed_chunk_response.dart'
    as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:uuid/uuid_value.dart' as _i5;
import 'package:the_delivery_app_client/src/protocol/greetings/greeting.dart'
    as _i6;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i7;
import 'protocol.dart' as _i8;

/// {@category Endpoint}
class EndpointCourierController extends _i1.EndpointRef {
  EndpointCourierController(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'courierController';

  _i2.Future<String> assignCourier(String requestJson) =>
      caller.callServerEndpoint<String>(
        'courierController',
        'assignCourier',
        {'requestJson': requestJson},
      );

  _i2.Future<String> updateDeliveryStatus(String requestJson) =>
      caller.callServerEndpoint<String>(
        'courierController',
        'updateDeliveryStatus',
        {'requestJson': requestJson},
      );

  _i2.Future<String> getAvailableCouriers() =>
      caller.callServerEndpoint<String>(
        'courierController',
        'getAvailableCouriers',
        {},
      );
}

/// {@category Endpoint}
class EndpointFavouritesController extends _i1.EndpointRef {
  EndpointFavouritesController(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'favouritesController';

  _i2.Future<String> getFavourites(int userId) =>
      caller.callServerEndpoint<String>(
        'favouritesController',
        'getFavourites',
        {'userId': userId},
      );

  _i2.Future<String> addFavourite(String requestJson) =>
      caller.callServerEndpoint<String>(
        'favouritesController',
        'addFavourite',
        {'requestJson': requestJson},
      );

  _i2.Future<String> removeFavourite(int favouriteId) =>
      caller.callServerEndpoint<String>(
        'favouritesController',
        'removeFavourite',
        {'favouriteId': favouriteId},
      );
}

/// {@category Endpoint}
class EndpointFeedController extends _i1.EndpointRef {
  EndpointFeedController(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'feedController';

  _i2.Future<_i3.FeedChunkResponse> getFeedChunk(
    int screenWidth,
    int screenHeight,
    int dpi,
    double dataTransferRate,
    double userLatitude,
    double userLongitude,
    int chunkSize,
    int chunkOffset,
    Map<String, dynamic>? filters,
  ) =>
      caller.callServerEndpoint<_i3.FeedChunkResponse>(
        'feedController',
        'getFeedChunk',
        {
          'screenWidth': screenWidth,
          'screenHeight': screenHeight,
          'dpi': dpi,
          'dataTransferRate': dataTransferRate,
          'userLatitude': userLatitude,
          'userLongitude': userLongitude,
          'chunkSize': chunkSize,
          'chunkOffset': chunkOffset,
          'filters': filters,
        },
      );

  _i2.Future<String> getSpecialDeals(
    int limit,
    String? city,
  ) =>
      caller.callServerEndpoint<String>(
        'feedController',
        'getSpecialDeals',
        {
          'limit': limit,
          'city': city,
        },
      );

  _i2.Future<String> search(
    String query,
    int limit,
    String? city,
  ) =>
      caller.callServerEndpoint<String>(
        'feedController',
        'search',
        {
          'query': query,
          'limit': limit,
          'city': city,
        },
      );
}

/// {@category Endpoint}
class EndpointOrderController extends _i1.EndpointRef {
  EndpointOrderController(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'orderController';

  _i2.Future<String> hello() => caller.callServerEndpoint<String>(
        'orderController',
        'hello',
        {},
      );

  _i2.Future<String> getOrder(int orderId) => caller.callServerEndpoint<String>(
        'orderController',
        'getOrder',
        {'orderId': orderId},
      );

  _i2.Future<String> getOrderDetails(String requestJson) =>
      caller.callServerEndpoint<String>(
        'orderController',
        'getOrderDetails',
        {'requestJson': requestJson},
      );

  _i2.Future<String> createOrder(String requestJson) =>
      caller.callServerEndpoint<String>(
        'orderController',
        'createOrder',
        {'requestJson': requestJson},
      );

  _i2.Future<String> processPayment(String requestJson) =>
      caller.callServerEndpoint<String>(
        'orderController',
        'processPayment',
        {'requestJson': requestJson},
      );

  _i2.Future<String> getHistory(
    int userId,
    int limit,
    int offset,
  ) =>
      caller.callServerEndpoint<String>(
        'orderController',
        'getHistory',
        {
          'userId': userId,
          'limit': limit,
          'offset': offset,
        },
      );

  _i2.Future<String> getTrackingInfo(String requestJson) =>
      caller.callServerEndpoint<String>(
        'orderController',
        'getTrackingInfo',
        {'requestJson': requestJson},
      );

  _i2.Future<String> updateCourierLocation(String requestJson) =>
      caller.callServerEndpoint<String>(
        'orderController',
        'updateCourierLocation',
        {'requestJson': requestJson},
      );
}

/// {@category Endpoint}
class EndpointRestaurantController extends _i1.EndpointRef {
  EndpointRestaurantController(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'restaurantController';

  _i2.Future<String> getRestaurant(int restaurantId) =>
      caller.callServerEndpoint<String>(
        'restaurantController',
        'getRestaurant',
        {'restaurantId': restaurantId},
      );

  _i2.Future<String> getMenu(int restaurantId) =>
      caller.callServerEndpoint<String>(
        'restaurantController',
        'getMenu',
        {'restaurantId': restaurantId},
      );

  _i2.Future<String> getReviews(
    int restaurantId,
    int limit,
    int offset,
  ) =>
      caller.callServerEndpoint<String>(
        'restaurantController',
        'getReviews',
        {
          'restaurantId': restaurantId,
          'limit': limit,
          'offset': offset,
        },
      );

  _i2.Future<String> getFeatured(int limit) =>
      caller.callServerEndpoint<String>(
        'restaurantController',
        'getFeatured',
        {'limit': limit},
      );
}

/// {@category Endpoint}
class EndpointReviewsController extends _i1.EndpointRef {
  EndpointReviewsController(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'reviewsController';

  _i2.Future<String> createReview(String requestJson) =>
      caller.callServerEndpoint<String>(
        'reviewsController',
        'createReview',
        {'requestJson': requestJson},
      );

  _i2.Future<String> getReviews(
    int foodId,
    int limit,
    int offset,
  ) =>
      caller.callServerEndpoint<String>(
        'reviewsController',
        'getReviews',
        {
          'foodId': foodId,
          'limit': limit,
          'offset': offset,
        },
      );

  _i2.Future<String> deleteReview(int reviewId) =>
      caller.callServerEndpoint<String>(
        'reviewsController',
        'deleteReview',
        {'reviewId': reviewId},
      );
}

/// {@category Endpoint}
class EndpointUserProfileController extends _i1.EndpointRef {
  EndpointUserProfileController(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userProfileController';

  _i2.Future<String> getProfile(int userId) =>
      caller.callServerEndpoint<String>(
        'userProfileController',
        'getProfile',
        {'userId': userId},
      );

  _i2.Future<String> updateProfile(String requestJson) =>
      caller.callServerEndpoint<String>(
        'userProfileController',
        'updateProfile',
        {'requestJson': requestJson},
      );

  _i2.Future<String> addAddress(String requestJson) =>
      caller.callServerEndpoint<String>(
        'userProfileController',
        'addAddress',
        {'requestJson': requestJson},
      );

  _i2.Future<String> deleteAddress(int addressId) =>
      caller.callServerEndpoint<String>(
        'userProfileController',
        'deleteAddress',
        {'addressId': addressId},
      );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointRef {
  EndpointEmailIdp(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// {@template email_account_base_endpoint.login}
  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  /// {@endtemplate}
  _i2.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) =>
      caller.callServerEndpoint<_i4.AuthSuccess>(
        'emailIdp',
        'login',
        {
          'email': email,
          'password': password,
        },
      );

  /// {@template email_account_base_endpoint.start_registration}
  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  /// {@endtemplate}
  _i2.Future<_i5.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i5.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// {@template email_account_base_endpoint.verify_registration_code}
  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  /// {@endtemplate}
  _i2.Future<String> verifyRegistrationCode({
    required _i5.UuidValue accountRequestId,
    required String verificationCode,
  }) =>
      caller.callServerEndpoint<String>(
        'emailIdp',
        'verifyRegistrationCode',
        {
          'accountRequestId': accountRequestId,
          'verificationCode': verificationCode,
        },
      );

  /// {@template email_account_base_endpoint.finish_registration}
  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  /// {@endtemplate}
  _i2.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) =>
      caller.callServerEndpoint<_i4.AuthSuccess>(
        'emailIdp',
        'finishRegistration',
        {
          'registrationToken': registrationToken,
          'password': password,
        },
      );

  /// {@template email_account_base_endpoint.start_password_reset}
  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  /// {@endtemplate}
  _i2.Future<_i5.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i5.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// {@template email_account_base_endpoint.verify_password_reset_code}
  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  /// {@endtemplate}
  _i2.Future<String> verifyPasswordResetCode({
    required _i5.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) =>
      caller.callServerEndpoint<String>(
        'emailIdp',
        'verifyPasswordResetCode',
        {
          'passwordResetRequestId': passwordResetRequestId,
          'verificationCode': verificationCode,
        },
      );

  /// {@template email_account_base_endpoint.finish_password_reset}
  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  /// {@endtemplate}
  _i2.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) =>
      caller.callServerEndpoint<void>(
        'emailIdp',
        'finishPasswordReset',
        {
          'finishPasswordResetToken': finishPasswordResetToken,
          'newPassword': newPassword,
        },
      );

  _i2.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
        'emailIdp',
        'hasAccount',
        {},
      );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i1.EndpointRef {
  EndpointJwtRefresh(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  _i2.Future<_i4.AuthSuccess> refreshAccessToken(
          {required String refreshToken}) =>
      caller.callServerEndpoint<_i4.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i6.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i6.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i7.Caller(client);
    serverpod_auth_core = _i4.Caller(client);
  }

  late final _i7.Caller serverpod_auth_idp;

  late final _i4.Caller serverpod_auth_core;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i8.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    courierController = EndpointCourierController(this);
    favouritesController = EndpointFavouritesController(this);
    feedController = EndpointFeedController(this);
    orderController = EndpointOrderController(this);
    restaurantController = EndpointRestaurantController(this);
    reviewsController = EndpointReviewsController(this);
    userProfileController = EndpointUserProfileController(this);
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointCourierController courierController;

  late final EndpointFavouritesController favouritesController;

  late final EndpointFeedController feedController;

  late final EndpointOrderController orderController;

  late final EndpointRestaurantController restaurantController;

  late final EndpointReviewsController reviewsController;

  late final EndpointUserProfileController userProfileController;

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'courierController': courierController,
        'favouritesController': favouritesController,
        'feedController': feedController,
        'orderController': orderController,
        'restaurantController': restaurantController,
        'reviewsController': reviewsController,
        'userProfileController': userProfileController,
        'emailIdp': emailIdp,
        'jwtRefresh': jwtRefresh,
        'greeting': greeting,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
        'serverpod_auth_idp': modules.serverpod_auth_idp,
        'serverpod_auth_core': modules.serverpod_auth_core,
      };
}
