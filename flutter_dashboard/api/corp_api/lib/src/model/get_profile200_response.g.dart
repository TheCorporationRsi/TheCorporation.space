// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetProfile200Response extends GetProfile200Response {
  @override
  final int? influence;
  @override
  final String? lastTributeTime;
  @override
  final int? lifetimeInfluence;
  @override
  final String? rank;
  @override
  final int? tribute;

  factory _$GetProfile200Response(
          [void Function(GetProfile200ResponseBuilder)? updates]) =>
      (GetProfile200ResponseBuilder()..update(updates))._build();

  _$GetProfile200Response._(
      {this.influence,
      this.lastTributeTime,
      this.lifetimeInfluence,
      this.rank,
      this.tribute})
      : super._();
  @override
  GetProfile200Response rebuild(
          void Function(GetProfile200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetProfile200ResponseBuilder toBuilder() =>
      GetProfile200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetProfile200Response &&
        influence == other.influence &&
        lastTributeTime == other.lastTributeTime &&
        lifetimeInfluence == other.lifetimeInfluence &&
        rank == other.rank &&
        tribute == other.tribute;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, influence.hashCode);
    _$hash = $jc(_$hash, lastTributeTime.hashCode);
    _$hash = $jc(_$hash, lifetimeInfluence.hashCode);
    _$hash = $jc(_$hash, rank.hashCode);
    _$hash = $jc(_$hash, tribute.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetProfile200Response')
          ..add('influence', influence)
          ..add('lastTributeTime', lastTributeTime)
          ..add('lifetimeInfluence', lifetimeInfluence)
          ..add('rank', rank)
          ..add('tribute', tribute))
        .toString();
  }
}

class GetProfile200ResponseBuilder
    implements Builder<GetProfile200Response, GetProfile200ResponseBuilder> {
  _$GetProfile200Response? _$v;

  int? _influence;
  int? get influence => _$this._influence;
  set influence(int? influence) => _$this._influence = influence;

  String? _lastTributeTime;
  String? get lastTributeTime => _$this._lastTributeTime;
  set lastTributeTime(String? lastTributeTime) =>
      _$this._lastTributeTime = lastTributeTime;

  int? _lifetimeInfluence;
  int? get lifetimeInfluence => _$this._lifetimeInfluence;
  set lifetimeInfluence(int? lifetimeInfluence) =>
      _$this._lifetimeInfluence = lifetimeInfluence;

  String? _rank;
  String? get rank => _$this._rank;
  set rank(String? rank) => _$this._rank = rank;

  int? _tribute;
  int? get tribute => _$this._tribute;
  set tribute(int? tribute) => _$this._tribute = tribute;

  GetProfile200ResponseBuilder() {
    GetProfile200Response._defaults(this);
  }

  GetProfile200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _influence = $v.influence;
      _lastTributeTime = $v.lastTributeTime;
      _lifetimeInfluence = $v.lifetimeInfluence;
      _rank = $v.rank;
      _tribute = $v.tribute;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetProfile200Response other) {
    _$v = other as _$GetProfile200Response;
  }

  @override
  void update(void Function(GetProfile200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetProfile200Response build() => _build();

  _$GetProfile200Response _build() {
    final _$result = _$v ??
        _$GetProfile200Response._(
          influence: influence,
          lastTributeTime: lastTributeTime,
          lifetimeInfluence: lifetimeInfluence,
          rank: rank,
          tribute: tribute,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
