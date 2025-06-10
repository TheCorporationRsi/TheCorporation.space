// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_rank_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeleteRankRequest extends DeleteRankRequest {
  @override
  final String rankTitle;

  factory _$DeleteRankRequest(
          [void Function(DeleteRankRequestBuilder)? updates]) =>
      (DeleteRankRequestBuilder()..update(updates))._build();

  _$DeleteRankRequest._({required this.rankTitle}) : super._();
  @override
  DeleteRankRequest rebuild(void Function(DeleteRankRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteRankRequestBuilder toBuilder() =>
      DeleteRankRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteRankRequest && rankTitle == other.rankTitle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rankTitle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeleteRankRequest')
          ..add('rankTitle', rankTitle))
        .toString();
  }
}

class DeleteRankRequestBuilder
    implements Builder<DeleteRankRequest, DeleteRankRequestBuilder> {
  _$DeleteRankRequest? _$v;

  String? _rankTitle;
  String? get rankTitle => _$this._rankTitle;
  set rankTitle(String? rankTitle) => _$this._rankTitle = rankTitle;

  DeleteRankRequestBuilder() {
    DeleteRankRequest._defaults(this);
  }

  DeleteRankRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rankTitle = $v.rankTitle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteRankRequest other) {
    _$v = other as _$DeleteRankRequest;
  }

  @override
  void update(void Function(DeleteRankRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteRankRequest build() => _build();

  _$DeleteRankRequest _build() {
    final _$result = _$v ??
        _$DeleteRankRequest._(
          rankTitle: BuiltValueNullFieldError.checkNotNull(
              rankTitle, r'DeleteRankRequest', 'rankTitle'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
