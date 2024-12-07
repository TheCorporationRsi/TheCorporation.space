// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_division_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateDivisionRequest extends UpdateDivisionRequest {
  @override
  final String divisionTitle;
  @override
  final String? logo;
  @override
  final String? motto;
  @override
  final String? newTitle;
  @override
  final int? securityLevel;

  factory _$UpdateDivisionRequest(
          [void Function(UpdateDivisionRequestBuilder)? updates]) =>
      (new UpdateDivisionRequestBuilder()..update(updates))._build();

  _$UpdateDivisionRequest._(
      {required this.divisionTitle,
      this.logo,
      this.motto,
      this.newTitle,
      this.securityLevel})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        divisionTitle, r'UpdateDivisionRequest', 'divisionTitle');
  }

  @override
  UpdateDivisionRequest rebuild(
          void Function(UpdateDivisionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateDivisionRequestBuilder toBuilder() =>
      new UpdateDivisionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateDivisionRequest &&
        divisionTitle == other.divisionTitle &&
        logo == other.logo &&
        motto == other.motto &&
        newTitle == other.newTitle &&
        securityLevel == other.securityLevel;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, divisionTitle.hashCode);
    _$hash = $jc(_$hash, logo.hashCode);
    _$hash = $jc(_$hash, motto.hashCode);
    _$hash = $jc(_$hash, newTitle.hashCode);
    _$hash = $jc(_$hash, securityLevel.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateDivisionRequest')
          ..add('divisionTitle', divisionTitle)
          ..add('logo', logo)
          ..add('motto', motto)
          ..add('newTitle', newTitle)
          ..add('securityLevel', securityLevel))
        .toString();
  }
}

class UpdateDivisionRequestBuilder
    implements Builder<UpdateDivisionRequest, UpdateDivisionRequestBuilder> {
  _$UpdateDivisionRequest? _$v;

  String? _divisionTitle;
  String? get divisionTitle => _$this._divisionTitle;
  set divisionTitle(String? divisionTitle) =>
      _$this._divisionTitle = divisionTitle;

  String? _logo;
  String? get logo => _$this._logo;
  set logo(String? logo) => _$this._logo = logo;

  String? _motto;
  String? get motto => _$this._motto;
  set motto(String? motto) => _$this._motto = motto;

  String? _newTitle;
  String? get newTitle => _$this._newTitle;
  set newTitle(String? newTitle) => _$this._newTitle = newTitle;

  int? _securityLevel;
  int? get securityLevel => _$this._securityLevel;
  set securityLevel(int? securityLevel) =>
      _$this._securityLevel = securityLevel;

  UpdateDivisionRequestBuilder() {
    UpdateDivisionRequest._defaults(this);
  }

  UpdateDivisionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _divisionTitle = $v.divisionTitle;
      _logo = $v.logo;
      _motto = $v.motto;
      _newTitle = $v.newTitle;
      _securityLevel = $v.securityLevel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateDivisionRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UpdateDivisionRequest;
  }

  @override
  void update(void Function(UpdateDivisionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateDivisionRequest build() => _build();

  _$UpdateDivisionRequest _build() {
    final _$result = _$v ??
        new _$UpdateDivisionRequest._(
            divisionTitle: BuiltValueNullFieldError.checkNotNull(
                divisionTitle, r'UpdateDivisionRequest', 'divisionTitle'),
            logo: logo,
            motto: motto,
            newTitle: newTitle,
            securityLevel: securityLevel);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
