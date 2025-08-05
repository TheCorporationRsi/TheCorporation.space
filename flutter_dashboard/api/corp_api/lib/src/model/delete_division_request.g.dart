// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_division_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeleteDivisionRequest extends DeleteDivisionRequest {
  @override
  final String divisionTitle;

  factory _$DeleteDivisionRequest(
          [void Function(DeleteDivisionRequestBuilder)? updates]) =>
      (DeleteDivisionRequestBuilder()..update(updates))._build();

  _$DeleteDivisionRequest._({required this.divisionTitle}) : super._();
  @override
  DeleteDivisionRequest rebuild(
          void Function(DeleteDivisionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteDivisionRequestBuilder toBuilder() =>
      DeleteDivisionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteDivisionRequest &&
        divisionTitle == other.divisionTitle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, divisionTitle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeleteDivisionRequest')
          ..add('divisionTitle', divisionTitle))
        .toString();
  }
}

class DeleteDivisionRequestBuilder
    implements Builder<DeleteDivisionRequest, DeleteDivisionRequestBuilder> {
  _$DeleteDivisionRequest? _$v;

  String? _divisionTitle;
  String? get divisionTitle => _$this._divisionTitle;
  set divisionTitle(String? divisionTitle) =>
      _$this._divisionTitle = divisionTitle;

  DeleteDivisionRequestBuilder() {
    DeleteDivisionRequest._defaults(this);
  }

  DeleteDivisionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _divisionTitle = $v.divisionTitle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteDivisionRequest other) {
    _$v = other as _$DeleteDivisionRequest;
  }

  @override
  void update(void Function(DeleteDivisionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteDivisionRequest build() => _build();

  _$DeleteDivisionRequest _build() {
    final _$result = _$v ??
        _$DeleteDivisionRequest._(
          divisionTitle: BuiltValueNullFieldError.checkNotNull(
              divisionTitle, r'DeleteDivisionRequest', 'divisionTitle'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
