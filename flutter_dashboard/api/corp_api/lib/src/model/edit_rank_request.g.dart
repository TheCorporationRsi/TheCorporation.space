// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_rank_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EditRankRequest extends EditRankRequest {
  @override
  final String rankTitle;
  @override
  final int? requiredLifetimeInfluence;
  @override
  final String? title;
  @override
  final int? weeklyAmount;

  factory _$EditRankRequest([void Function(EditRankRequestBuilder)? updates]) =>
      (EditRankRequestBuilder()..update(updates))._build();

  _$EditRankRequest._(
      {required this.rankTitle,
      this.requiredLifetimeInfluence,
      this.title,
      this.weeklyAmount})
      : super._();
  @override
  EditRankRequest rebuild(void Function(EditRankRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EditRankRequestBuilder toBuilder() => EditRankRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EditRankRequest &&
        rankTitle == other.rankTitle &&
        requiredLifetimeInfluence == other.requiredLifetimeInfluence &&
        title == other.title &&
        weeklyAmount == other.weeklyAmount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rankTitle.hashCode);
    _$hash = $jc(_$hash, requiredLifetimeInfluence.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, weeklyAmount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EditRankRequest')
          ..add('rankTitle', rankTitle)
          ..add('requiredLifetimeInfluence', requiredLifetimeInfluence)
          ..add('title', title)
          ..add('weeklyAmount', weeklyAmount))
        .toString();
  }
}

class EditRankRequestBuilder
    implements Builder<EditRankRequest, EditRankRequestBuilder> {
  _$EditRankRequest? _$v;

  String? _rankTitle;
  String? get rankTitle => _$this._rankTitle;
  set rankTitle(String? rankTitle) => _$this._rankTitle = rankTitle;

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

  EditRankRequestBuilder() {
    EditRankRequest._defaults(this);
  }

  EditRankRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rankTitle = $v.rankTitle;
      _requiredLifetimeInfluence = $v.requiredLifetimeInfluence;
      _title = $v.title;
      _weeklyAmount = $v.weeklyAmount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EditRankRequest other) {
    _$v = other as _$EditRankRequest;
  }

  @override
  void update(void Function(EditRankRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EditRankRequest build() => _build();

  _$EditRankRequest _build() {
    final _$result = _$v ??
        _$EditRankRequest._(
          rankTitle: BuiltValueNullFieldError.checkNotNull(
              rankTitle, r'EditRankRequest', 'rankTitle'),
          requiredLifetimeInfluence: requiredLifetimeInfluence,
          title: title,
          weeklyAmount: weeklyAmount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
