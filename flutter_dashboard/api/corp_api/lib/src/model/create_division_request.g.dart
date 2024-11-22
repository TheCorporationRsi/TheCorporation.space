// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_division_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateDivisionRequest extends CreateDivisionRequest {
  @override
  final String title;

  factory _$CreateDivisionRequest(
          [void Function(CreateDivisionRequestBuilder)? updates]) =>
      (new CreateDivisionRequestBuilder()..update(updates))._build();

  _$CreateDivisionRequest._({required this.title}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        title, r'CreateDivisionRequest', 'title');
  }

  @override
  CreateDivisionRequest rebuild(
          void Function(CreateDivisionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateDivisionRequestBuilder toBuilder() =>
      new CreateDivisionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateDivisionRequest && title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateDivisionRequest')
          ..add('title', title))
        .toString();
  }
}

class CreateDivisionRequestBuilder
    implements Builder<CreateDivisionRequest, CreateDivisionRequestBuilder> {
  _$CreateDivisionRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  CreateDivisionRequestBuilder() {
    CreateDivisionRequest._defaults(this);
  }

  CreateDivisionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateDivisionRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreateDivisionRequest;
  }

  @override
  void update(void Function(CreateDivisionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateDivisionRequest build() => _build();

  _$CreateDivisionRequest _build() {
    final _$result = _$v ??
        new _$CreateDivisionRequest._(
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'CreateDivisionRequest', 'title'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
