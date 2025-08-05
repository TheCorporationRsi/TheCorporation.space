// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_influence_stats200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetUserInfluenceStats200Response
    extends GetUserInfluenceStats200Response {
  @override
  final BuiltList<GetUserInfluenceStats200ResponseDepartmentsInner>?
      departments;
  @override
  final int? generalInfluence;
  @override
  final int? lifetimeGeneralInfluence;
  @override
  final int? totalInfluence;
  @override
  final int? totalLifetimeInfluence;

  factory _$GetUserInfluenceStats200Response(
          [void Function(GetUserInfluenceStats200ResponseBuilder)? updates]) =>
      (GetUserInfluenceStats200ResponseBuilder()..update(updates))._build();

  _$GetUserInfluenceStats200Response._(
      {this.departments,
      this.generalInfluence,
      this.lifetimeGeneralInfluence,
      this.totalInfluence,
      this.totalLifetimeInfluence})
      : super._();
  @override
  GetUserInfluenceStats200Response rebuild(
          void Function(GetUserInfluenceStats200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetUserInfluenceStats200ResponseBuilder toBuilder() =>
      GetUserInfluenceStats200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetUserInfluenceStats200Response &&
        departments == other.departments &&
        generalInfluence == other.generalInfluence &&
        lifetimeGeneralInfluence == other.lifetimeGeneralInfluence &&
        totalInfluence == other.totalInfluence &&
        totalLifetimeInfluence == other.totalLifetimeInfluence;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, departments.hashCode);
    _$hash = $jc(_$hash, generalInfluence.hashCode);
    _$hash = $jc(_$hash, lifetimeGeneralInfluence.hashCode);
    _$hash = $jc(_$hash, totalInfluence.hashCode);
    _$hash = $jc(_$hash, totalLifetimeInfluence.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetUserInfluenceStats200Response')
          ..add('departments', departments)
          ..add('generalInfluence', generalInfluence)
          ..add('lifetimeGeneralInfluence', lifetimeGeneralInfluence)
          ..add('totalInfluence', totalInfluence)
          ..add('totalLifetimeInfluence', totalLifetimeInfluence))
        .toString();
  }
}

class GetUserInfluenceStats200ResponseBuilder
    implements
        Builder<GetUserInfluenceStats200Response,
            GetUserInfluenceStats200ResponseBuilder> {
  _$GetUserInfluenceStats200Response? _$v;

  ListBuilder<GetUserInfluenceStats200ResponseDepartmentsInner>? _departments;
  ListBuilder<GetUserInfluenceStats200ResponseDepartmentsInner>
      get departments => _$this._departments ??=
          ListBuilder<GetUserInfluenceStats200ResponseDepartmentsInner>();
  set departments(
          ListBuilder<GetUserInfluenceStats200ResponseDepartmentsInner>?
              departments) =>
      _$this._departments = departments;

  int? _generalInfluence;
  int? get generalInfluence => _$this._generalInfluence;
  set generalInfluence(int? generalInfluence) =>
      _$this._generalInfluence = generalInfluence;

  int? _lifetimeGeneralInfluence;
  int? get lifetimeGeneralInfluence => _$this._lifetimeGeneralInfluence;
  set lifetimeGeneralInfluence(int? lifetimeGeneralInfluence) =>
      _$this._lifetimeGeneralInfluence = lifetimeGeneralInfluence;

  int? _totalInfluence;
  int? get totalInfluence => _$this._totalInfluence;
  set totalInfluence(int? totalInfluence) =>
      _$this._totalInfluence = totalInfluence;

  int? _totalLifetimeInfluence;
  int? get totalLifetimeInfluence => _$this._totalLifetimeInfluence;
  set totalLifetimeInfluence(int? totalLifetimeInfluence) =>
      _$this._totalLifetimeInfluence = totalLifetimeInfluence;

  GetUserInfluenceStats200ResponseBuilder() {
    GetUserInfluenceStats200Response._defaults(this);
  }

  GetUserInfluenceStats200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _departments = $v.departments?.toBuilder();
      _generalInfluence = $v.generalInfluence;
      _lifetimeGeneralInfluence = $v.lifetimeGeneralInfluence;
      _totalInfluence = $v.totalInfluence;
      _totalLifetimeInfluence = $v.totalLifetimeInfluence;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetUserInfluenceStats200Response other) {
    _$v = other as _$GetUserInfluenceStats200Response;
  }

  @override
  void update(void Function(GetUserInfluenceStats200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetUserInfluenceStats200Response build() => _build();

  _$GetUserInfluenceStats200Response _build() {
    _$GetUserInfluenceStats200Response _$result;
    try {
      _$result = _$v ??
          _$GetUserInfluenceStats200Response._(
            departments: _departments?.build(),
            generalInfluence: generalInfluence,
            lifetimeGeneralInfluence: lifetimeGeneralInfluence,
            totalInfluence: totalInfluence,
            totalLifetimeInfluence: totalLifetimeInfluence,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'departments';
        _departments?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GetUserInfluenceStats200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
