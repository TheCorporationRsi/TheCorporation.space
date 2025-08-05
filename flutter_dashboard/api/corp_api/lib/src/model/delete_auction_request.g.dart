// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_auction_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeleteAuctionRequest extends DeleteAuctionRequest {
  @override
  final String auctionId;

  factory _$DeleteAuctionRequest(
          [void Function(DeleteAuctionRequestBuilder)? updates]) =>
      (DeleteAuctionRequestBuilder()..update(updates))._build();

  _$DeleteAuctionRequest._({required this.auctionId}) : super._();
  @override
  DeleteAuctionRequest rebuild(
          void Function(DeleteAuctionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteAuctionRequestBuilder toBuilder() =>
      DeleteAuctionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteAuctionRequest && auctionId == other.auctionId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, auctionId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeleteAuctionRequest')
          ..add('auctionId', auctionId))
        .toString();
  }
}

class DeleteAuctionRequestBuilder
    implements Builder<DeleteAuctionRequest, DeleteAuctionRequestBuilder> {
  _$DeleteAuctionRequest? _$v;

  String? _auctionId;
  String? get auctionId => _$this._auctionId;
  set auctionId(String? auctionId) => _$this._auctionId = auctionId;

  DeleteAuctionRequestBuilder() {
    DeleteAuctionRequest._defaults(this);
  }

  DeleteAuctionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _auctionId = $v.auctionId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteAuctionRequest other) {
    _$v = other as _$DeleteAuctionRequest;
  }

  @override
  void update(void Function(DeleteAuctionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteAuctionRequest build() => _build();

  _$DeleteAuctionRequest _build() {
    final _$result = _$v ??
        _$DeleteAuctionRequest._(
          auctionId: BuiltValueNullFieldError.checkNotNull(
              auctionId, r'DeleteAuctionRequest', 'auctionId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
