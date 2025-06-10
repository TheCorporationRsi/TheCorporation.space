// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_department_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateDepartmentRequest extends CreateDepartmentRequest {
  @override
  final String title;

  factory _$CreateDepartmentRequest(
          [void Function(CreateDepartmentRequestBuilder)? updates]) =>
      (CreateDepartmentRequestBuilder()..update(updates))._build();

  _$CreateDepartmentRequest._({required this.title}) : super._();
  @override
  CreateDepartmentRequest rebuild(
          void Function(CreateDepartmentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateDepartmentRequestBuilder toBuilder() =>
      CreateDepartmentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateDepartmentRequest && title == other.title;
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
    return (newBuiltValueToStringHelper(r'CreateDepartmentRequest')
          ..add('title', title))
        .toString();
  }
}

class CreateDepartmentRequestBuilder
    implements
        Builder<CreateDepartmentRequest, CreateDepartmentRequestBuilder> {
  _$CreateDepartmentRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  CreateDepartmentRequestBuilder() {
    CreateDepartmentRequest._defaults(this);
  }

  CreateDepartmentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateDepartmentRequest other) {
    _$v = other as _$CreateDepartmentRequest;
  }

  @override
  void update(void Function(CreateDepartmentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateDepartmentRequest build() => _build();

  _$CreateDepartmentRequest _build() {
    final _$result = _$v ??
        _$CreateDepartmentRequest._(
          title: BuiltValueNullFieldError.checkNotNull(
              title, r'CreateDepartmentRequest', 'title'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
