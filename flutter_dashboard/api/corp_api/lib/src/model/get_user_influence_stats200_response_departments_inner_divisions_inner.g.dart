// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_influence_stats200_response_departments_inner_divisions_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner
    extends GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner {
  @override
  final String? divisionTitle;
  @override
  final int? influence;
  @override
  final int? lifetimeInfluence;

  factory _$GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner(
          [void Function(
                  GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerBuilder)?
              updates]) =>
      (GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerBuilder()
            ..update(updates))
          ._build();

  _$GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner._(
      {this.divisionTitle, this.influence, this.lifetimeInfluence})
      : super._();
  @override
  GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner rebuild(
          void Function(
                  GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerBuilder
      toBuilder() =>
          GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner &&
        divisionTitle == other.divisionTitle &&
        influence == other.influence &&
        lifetimeInfluence == other.lifetimeInfluence;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, divisionTitle.hashCode);
    _$hash = $jc(_$hash, influence.hashCode);
    _$hash = $jc(_$hash, lifetimeInfluence.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner')
          ..add('divisionTitle', divisionTitle)
          ..add('influence', influence)
          ..add('lifetimeInfluence', lifetimeInfluence))
        .toString();
  }
}

class GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerBuilder
    implements
        Builder<GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner,
            GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerBuilder> {
  _$GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner? _$v;

  String? _divisionTitle;
  String? get divisionTitle => _$this._divisionTitle;
  set divisionTitle(String? divisionTitle) =>
      _$this._divisionTitle = divisionTitle;

  int? _influence;
  int? get influence => _$this._influence;
  set influence(int? influence) => _$this._influence = influence;

  int? _lifetimeInfluence;
  int? get lifetimeInfluence => _$this._lifetimeInfluence;
  set lifetimeInfluence(int? lifetimeInfluence) =>
      _$this._lifetimeInfluence = lifetimeInfluence;

  GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerBuilder() {
    GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner._defaults(
        this);
  }

  GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _divisionTitle = $v.divisionTitle;
      _influence = $v.influence;
      _lifetimeInfluence = $v.lifetimeInfluence;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner other) {
    _$v = other
        as _$GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner;
  }

  @override
  void update(
      void Function(
              GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner build() =>
      _build();

  _$GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner _build() {
    final _$result = _$v ??
        _$GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner._(
          divisionTitle: divisionTitle,
          influence: influence,
          lifetimeInfluence: lifetimeInfluence,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
