// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ranks200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetRanks200Response extends GetRanks200Response {
  @override
  final int? requiredLifetimeInfluence;
  @override
  final String? title;
  @override
  final int? weeklyAmount;

  factory _$GetRanks200Response(
          [void Function(GetRanks200ResponseBuilder)? updates]) =>
      (new GetRanks200ResponseBuilder()..update(updates))._build();

  _$GetRanks200Response._(
      {this.requiredLifetimeInfluence, this.title, this.weeklyAmount})
      : super._();

  @override
  GetRanks200Response rebuild(
          void Function(GetRanks200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetRanks200ResponseBuilder toBuilder() =>
      new GetRanks200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetRanks200Response &&
        requiredLifetimeInfluence == other.requiredLifetimeInfluence &&
        title == other.title &&
        weeklyAmount == other.weeklyAmount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, requiredLifetimeInfluence.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, weeklyAmount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetRanks200Response')
          ..add('requiredLifetimeInfluence', requiredLifetimeInfluence)
          ..add('title', title)
          ..add('weeklyAmount', weeklyAmount))
        .toString();
  }
}

class GetRanks200ResponseBuilder
    implements Builder<GetRanks200Response, GetRanks200ResponseBuilder> {
  _$GetRanks200Response? _$v;

  int? _requiredLifetimeInfluence;
  int? get requiredLifetimeInfluence => _$this._requiredLifetimeInfluence;
  set requiredLifetimeInfluence(int? requiredLifetimeInfluence) =>
      _$this._requiredLifetimeInfluence = requiredLifetimeInfluence;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  int? _weeklyAmount;
  int? get weeklyAmount => _$this._weeklyAmount;
  set weeklyAmount(int? weeklyAmount) => _$this._weeklyAmount = weeklyAmount;

  GetRanks200ResponseBuilder() {
    GetRanks200Response._defaults(this);
  }

  GetRanks200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _requiredLifetimeInfluence = $v.requiredLifetimeInfluence;
      _title = $v.title;
      _weeklyAmount = $v.weeklyAmount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetRanks200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetRanks200Response;
  }

  @override
  void update(void Function(GetRanks200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetRanks200Response build() => _build();

  _$GetRanks200Response _build() {
    final _$result = _$v ??
        new _$GetRanks200Response._(
            requiredLifetimeInfluence: requiredLifetimeInfluence,
            title: title,
            weeklyAmount: weeklyAmount);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
