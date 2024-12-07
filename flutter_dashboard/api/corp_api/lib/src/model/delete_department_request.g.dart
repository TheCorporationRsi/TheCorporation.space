// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_department_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeleteDepartmentRequest extends DeleteDepartmentRequest {
  @override
  final String departmentTitle;

  factory _$DeleteDepartmentRequest(
          [void Function(DeleteDepartmentRequestBuilder)? updates]) =>
      (new DeleteDepartmentRequestBuilder()..update(updates))._build();

  _$DeleteDepartmentRequest._({required this.departmentTitle}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        departmentTitle, r'DeleteDepartmentRequest', 'departmentTitle');
  }

  @override
  DeleteDepartmentRequest rebuild(
          void Function(DeleteDepartmentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteDepartmentRequestBuilder toBuilder() =>
      new DeleteDepartmentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteDepartmentRequest &&
        departmentTitle == other.departmentTitle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, departmentTitle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeleteDepartmentRequest')
          ..add('departmentTitle', departmentTitle))
        .toString();
  }
}

class DeleteDepartmentRequestBuilder
    implements
        Builder<DeleteDepartmentRequest, DeleteDepartmentRequestBuilder> {
  _$DeleteDepartmentRequest? _$v;

  String? _departmentTitle;
  String? get departmentTitle => _$this._departmentTitle;
  set departmentTitle(String? departmentTitle) =>
      _$this._departmentTitle = departmentTitle;

  DeleteDepartmentRequestBuilder() {
    DeleteDepartmentRequest._defaults(this);
  }

  DeleteDepartmentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _departmentTitle = $v.departmentTitle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteDepartmentRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DeleteDepartmentRequest;
  }

  @override
  void update(void Function(DeleteDepartmentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteDepartmentRequest build() => _build();

  _$DeleteDepartmentRequest _build() {
    final _$result = _$v ??
        new _$DeleteDepartmentRequest._(
            departmentTitle: BuiltValueNullFieldError.checkNotNull(
                departmentTitle,
                r'DeleteDepartmentRequest',
                'departmentTitle'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
