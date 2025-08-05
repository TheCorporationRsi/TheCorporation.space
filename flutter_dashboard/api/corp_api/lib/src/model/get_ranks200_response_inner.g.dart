// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ranks200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetRanks200ResponseInner extends GetRanks200ResponseInner {
  @override
  final int? requiredLifetimeInfluence;
  @override
  final String? title;
  @override
  final int? weeklyAmount;

  factory _$GetRanks200ResponseInner(
          [void Function(GetRanks200ResponseInnerBuilder)? updates]) =>
      (GetRanks200ResponseInnerBuilder()..update(updates))._build();

  _$GetRanks200ResponseInner._(
      {this.requiredLifetimeInfluence, this.title, this.weeklyAmount})
      : super._();
  @override
  GetRanks200ResponseInner rebuild(
          void Function(GetRanks200ResponseInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetRanks200ResponseInnerBuilder toBuilder() =>
      GetRanks200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetRanks200ResponseInner &&
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
    return (newBuiltValueToStringHelper(r'GetRanks200ResponseInner')
          ..add('requiredLifetimeInfluence', requiredLifetimeInfluence)
          ..add('title', title)
          ..add('weeklyAmount', weeklyAmount))
        .toString();
  }
}

class GetRanks200ResponseInnerBuilder
    implements
        Builder<GetRanks200ResponseInner, GetRanks200ResponseInnerBuilder> {
  _$GetRanks200ResponseInner? _$v;

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

  GetRanks200ResponseInnerBuilder() {
    GetRanks200ResponseInner._defaults(this);
  }

  GetRanks200ResponseInnerBuilder get _$this {
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
  void replace(GetRanks200ResponseInner other) {
    _$v = other as _$GetRanks200ResponseInner;
  }

  @override
  void update(void Function(GetRanks200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetRanks200ResponseInner build() => _build();

  _$GetRanks200ResponseInner _build() {
    final _$result = _$v ??
        _$GetRanks200ResponseInner._(
          requiredLifetimeInfluence: requiredLifetimeInfluence,
          title: title,
          weeklyAmount: weeklyAmount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
