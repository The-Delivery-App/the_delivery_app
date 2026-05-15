/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class RestaurantPlace
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RestaurantPlace._({
    this.id,
    required this.restId,
    this.name,
    required this.city,
    required this.country,
    required this.postcode,
    required this.addressLine1,
    this.addressLine2,
    required this.latitude,
    required this.longitude,
  });

  factory RestaurantPlace({
    int? id,
    required int restId,
    String? name,
    required String city,
    required String country,
    required String postcode,
    required String addressLine1,
    String? addressLine2,
    required double latitude,
    required double longitude,
  }) = _RestaurantPlaceImpl;

  factory RestaurantPlace.fromJson(Map<String, dynamic> jsonSerialization) {
    return RestaurantPlace(
      id: jsonSerialization['id'] as int?,
      restId: jsonSerialization['restId'] as int,
      name: jsonSerialization['name'] as String?,
      city: jsonSerialization['city'] as String,
      country: jsonSerialization['country'] as String,
      postcode: jsonSerialization['postcode'] as String,
      addressLine1: jsonSerialization['addressLine1'] as String,
      addressLine2: jsonSerialization['addressLine2'] as String?,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
    );
  }

  static final t = RestaurantPlaceTable();

  static const db = RestaurantPlaceRepository._();

  @override
  int? id;

  int restId;

  String? name;

  String city;

  String country;

  String postcode;

  String addressLine1;

  String? addressLine2;

  double latitude;

  double longitude;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RestaurantPlace]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RestaurantPlace copyWith({
    int? id,
    int? restId,
    String? name,
    String? city,
    String? country,
    String? postcode,
    String? addressLine1,
    String? addressLine2,
    double? latitude,
    double? longitude,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'restId': restId,
      if (name != null) 'name': name,
      'city': city,
      'country': country,
      'postcode': postcode,
      'addressLine1': addressLine1,
      if (addressLine2 != null) 'addressLine2': addressLine2,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'restId': restId,
      if (name != null) 'name': name,
      'city': city,
      'country': country,
      'postcode': postcode,
      'addressLine1': addressLine1,
      if (addressLine2 != null) 'addressLine2': addressLine2,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static RestaurantPlaceInclude include() {
    return RestaurantPlaceInclude._();
  }

  static RestaurantPlaceIncludeList includeList({
    _i1.WhereExpressionBuilder<RestaurantPlaceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RestaurantPlaceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RestaurantPlaceTable>? orderByList,
    RestaurantPlaceInclude? include,
  }) {
    return RestaurantPlaceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RestaurantPlace.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RestaurantPlace.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RestaurantPlaceImpl extends RestaurantPlace {
  _RestaurantPlaceImpl({
    int? id,
    required int restId,
    String? name,
    required String city,
    required String country,
    required String postcode,
    required String addressLine1,
    String? addressLine2,
    required double latitude,
    required double longitude,
  }) : super._(
          id: id,
          restId: restId,
          name: name,
          city: city,
          country: country,
          postcode: postcode,
          addressLine1: addressLine1,
          addressLine2: addressLine2,
          latitude: latitude,
          longitude: longitude,
        );

  /// Returns a shallow copy of this [RestaurantPlace]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RestaurantPlace copyWith({
    Object? id = _Undefined,
    int? restId,
    Object? name = _Undefined,
    String? city,
    String? country,
    String? postcode,
    String? addressLine1,
    Object? addressLine2 = _Undefined,
    double? latitude,
    double? longitude,
  }) {
    return RestaurantPlace(
      id: id is int? ? id : this.id,
      restId: restId ?? this.restId,
      name: name is String? ? name : this.name,
      city: city ?? this.city,
      country: country ?? this.country,
      postcode: postcode ?? this.postcode,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 is String? ? addressLine2 : this.addressLine2,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

class RestaurantPlaceTable extends _i1.Table<int?> {
  RestaurantPlaceTable({super.tableRelation})
      : super(tableName: 'restaurant_place') {
    restId = _i1.ColumnInt(
      'restId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    city = _i1.ColumnString(
      'city',
      this,
    );
    country = _i1.ColumnString(
      'country',
      this,
    );
    postcode = _i1.ColumnString(
      'postcode',
      this,
    );
    addressLine1 = _i1.ColumnString(
      'addressLine1',
      this,
    );
    addressLine2 = _i1.ColumnString(
      'addressLine2',
      this,
    );
    latitude = _i1.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _i1.ColumnDouble(
      'longitude',
      this,
    );
  }

  late final _i1.ColumnInt restId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString city;

  late final _i1.ColumnString country;

  late final _i1.ColumnString postcode;

  late final _i1.ColumnString addressLine1;

  late final _i1.ColumnString addressLine2;

  late final _i1.ColumnDouble latitude;

  late final _i1.ColumnDouble longitude;

  @override
  List<_i1.Column> get columns => [
        id,
        restId,
        name,
        city,
        country,
        postcode,
        addressLine1,
        addressLine2,
        latitude,
        longitude,
      ];
}

class RestaurantPlaceInclude extends _i1.IncludeObject {
  RestaurantPlaceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => RestaurantPlace.t;
}

class RestaurantPlaceIncludeList extends _i1.IncludeList {
  RestaurantPlaceIncludeList._({
    _i1.WhereExpressionBuilder<RestaurantPlaceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RestaurantPlace.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RestaurantPlace.t;
}

class RestaurantPlaceRepository {
  const RestaurantPlaceRepository._();

  /// Returns a list of [RestaurantPlace]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<RestaurantPlace>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RestaurantPlaceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RestaurantPlaceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RestaurantPlaceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<RestaurantPlace>(
      where: where?.call(RestaurantPlace.t),
      orderBy: orderBy?.call(RestaurantPlace.t),
      orderByList: orderByList?.call(RestaurantPlace.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [RestaurantPlace] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<RestaurantPlace?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RestaurantPlaceTable>? where,
    int? offset,
    _i1.OrderByBuilder<RestaurantPlaceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RestaurantPlaceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<RestaurantPlace>(
      where: where?.call(RestaurantPlace.t),
      orderBy: orderBy?.call(RestaurantPlace.t),
      orderByList: orderByList?.call(RestaurantPlace.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [RestaurantPlace] by its [id] or null if no such row exists.
  Future<RestaurantPlace?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<RestaurantPlace>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [RestaurantPlace]s in the list and returns the inserted rows.
  ///
  /// The returned [RestaurantPlace]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<RestaurantPlace>> insert(
    _i1.Session session,
    List<RestaurantPlace> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<RestaurantPlace>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [RestaurantPlace] and returns the inserted row.
  ///
  /// The returned [RestaurantPlace] will have its `id` field set.
  Future<RestaurantPlace> insertRow(
    _i1.Session session,
    RestaurantPlace row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RestaurantPlace>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RestaurantPlace]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RestaurantPlace>> update(
    _i1.Session session,
    List<RestaurantPlace> rows, {
    _i1.ColumnSelections<RestaurantPlaceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RestaurantPlace>(
      rows,
      columns: columns?.call(RestaurantPlace.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RestaurantPlace]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RestaurantPlace> updateRow(
    _i1.Session session,
    RestaurantPlace row, {
    _i1.ColumnSelections<RestaurantPlaceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RestaurantPlace>(
      row,
      columns: columns?.call(RestaurantPlace.t),
      transaction: transaction,
    );
  }

  /// Deletes all [RestaurantPlace]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RestaurantPlace>> delete(
    _i1.Session session,
    List<RestaurantPlace> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RestaurantPlace>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RestaurantPlace].
  Future<RestaurantPlace> deleteRow(
    _i1.Session session,
    RestaurantPlace row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RestaurantPlace>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RestaurantPlace>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RestaurantPlaceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RestaurantPlace>(
      where: where(RestaurantPlace.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RestaurantPlaceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RestaurantPlace>(
      where: where?.call(RestaurantPlace.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
