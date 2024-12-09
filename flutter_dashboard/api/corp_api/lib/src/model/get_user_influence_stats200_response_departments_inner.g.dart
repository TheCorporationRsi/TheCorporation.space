// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_influence_stats200_response_departments_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetUserInfluenceStats200ResponseDepartmentsInner
    extends GetUserInfluenceStats200ResponseDepartmentsInner {
  @override
  final String? color;
  @override
  final String? departmentTitle;
  @override
  final BuiltList<
          GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner>?
      divisions;
  @override
  final int? influence;
  @override
  final int? lifetimeInfluence;

  factory _$GetUserInfluenceStats200ResponseDepartmentsInner(
          [void Function(
                  GetUserInfluenceStats200ResponseDepartmentsInnerBuilder)?
              updates]) =>
      (new GetUserInfluenceStats200ResponseDepartmentsInnerBuilder()
            ..update(updates))
          ._build();

  _$GetUserInfluenceStats200ResponseDepartmentsInner._(
      {this.color,
      this.departmentTitle,
      this.divisions,
      this.influence,
      this.lifetimeInfluence})
      : super._();

  @override
  GetUserInfluenceStats200ResponseDepartmentsInner rebuild(
          void Function(GetUserInfluenceStats200ResponseDepartmentsInnerBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetUserInfluenceStats200ResponseDepartmentsInnerBuilder toBuilder() =>
      new GetUserInfluenceStats200ResponseDepartmentsInnerBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetUserInfluenceStats200ResponseDepartmentsInner &&
        color == other.color &&
        departmentTitle == other.departmentTitle &&
        divisions == other.divisions &&
        influence == other.influence &&
        lifetimeInfluence == other.lifetimeInfluence;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, departmentTitle.hashCode);
    _$hash = $jc(_$hash, divisions.hashCode);
    _$hash = $jc(_$hash, influence.hashCode);
    _$hash = $jc(_$hash, lifetimeInfluence.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GetUserInfluenceStats200ResponseDepartmentsInner')
          ..add('color', color)
          ..add('departmentTitle', departmentTitle)
          ..add('divisions', divisions)
          ..add('influence', influence)
          ..add('lifetimeInfluence', lifetimeInfluence))
        .toString();
  }
}

class GetUserInfluenceStats200ResponseDepartmentsInnerBuilder
    implements
        Builder<GetUserInfluenceStats200ResponseDepartmentsInner,
            GetUserInfluenceStats200ResponseDepartmentsInnerBuilder> {
  _$GetUserInfluenceStats200ResponseDepartmentsInner? _$v;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  String? _departmentTitle;
  String? get departmentTitle => _$this._departmentTitle;
  set departmentTitle(String? departmentTitle) =>
      _$this._departmentTitle = departmentTitle;

  ListBuilder<GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner>?
      _divisions;
  ListBuilder<GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner>
      get divisions => _$this._divisions ??= new ListBuilder<
          GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner>();
  set divisions(
          ListBuilder<
                  GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner>?
              divisions) =>
      _$this._divisions = divisions;

  int? _influence;
  int? get influence => _$this._influence;
  set influence(int? influence) => _$this._influence = influence;

  int? _lifetimeInfluence;
  int? get lifetimeInfluence => _$this._lifetimeInfluence;
  set lifetimeInfluence(int? lifetimeInfluence) =>
      _$this._lifetimeInfluence = lifetimeInfluence;

  GetUserInfluenceStats200ResponseDepartmentsInnerBuilder() {
    GetUserInfluenceStats200ResponseDepartmentsInner._defaults(this);
  }

  GetUserInfluenceStats200ResponseDepartmentsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _color = $v.color;
      _departmentTitle = $v.departmentTitle;
      _divisions = $v.divisions?.toBuilder();
      _influence = $v.influence;
      _lifetimeInfluence = $v.lifetimeInfluence;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetUserInfluenceStats200ResponseDepartmentsInner other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetUserInfluenceStats200ResponseDepartmentsInner;
  }

  @override
  void update(
      void Function(GetUserInfluenceStats200ResponseDepartmentsInnerBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GetUserInfluenceStats200ResponseDepartmentsInner build() => _build();

  _$GetUserInfluenceStats200ResponseDepartmentsInner _build() {
    _$GetUserInfluenceStats200ResponseDepartmentsInner _$result;
    try {
      _$result = _$v ??
          new _$GetUserInfluenceStats200ResponseDepartmentsInner._(
              color: color,
              departmentTitle: departmentTitle,
              divisions: _divisions?.build(),
              influence: influence,
              lifetimeInfluence: lifetimeInfluence);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'divisions';
        _divisions?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GetUserInfluenceStats200ResponseDepartmentsInner',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
