// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_rank_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateRankRequest extends CreateRankRequest {
  @override
  final int? requiredLifetimeInfluence;
  @override
  final String? title;
  @override
  final int? weeklyAmount;

  factory _$CreateRankRequest(
          [void Function(CreateRankRequestBuilder)? updates]) =>
      (CreateRankRequestBuilder()..update(updates))._build();

  _$CreateRankRequest._(
      {this.requiredLifetimeInfluence, this.title, this.weeklyAmount})
      : super._();
  @override
  CreateRankRequest rebuild(void Function(CreateRankRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateRankRequestBuilder toBuilder() =>
      CreateRankRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateRankRequest &&
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
    return (newBuiltValueToStringHelper(r'CreateRankRequest')
          ..add('requiredLifetimeInfluence', requiredLifetimeInfluence)
          ..add('title', title)
          ..add('weeklyAmount', weeklyAmount))
        .toString();
  }
}

class CreateRankRequestBuilder
    implements Builder<CreateRankRequest, CreateRankRequestBuilder> {
  _$CreateRankRequest? _$v;

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

  CreateRankRequestBuilder() {
    CreateRankRequest._defaults(this);
  }

  CreateRankRequestBuilder get _$this {
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
  void replace(CreateRankRequest other) {
    _$v = other as _$CreateRankRequest;
  }

  @override
  void update(void Function(CreateRankRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateRankRequest build() => _build();

  _$CreateRankRequest _build() {
    final _$result = _$v ??
        _$CreateRankRequest._(
          requiredLifetimeInfluence: requiredLifetimeInfluence,
          title: title,
          weeklyAmount: weeklyAmount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
