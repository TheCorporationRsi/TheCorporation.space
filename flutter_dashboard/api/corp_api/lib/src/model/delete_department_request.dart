//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_department_request.g.dart';

/// DeleteDepartmentRequest
///
/// Properties:
/// * [departmentTitle]
@BuiltValue()
abstract class DeleteDepartmentRequest
    implements Built<DeleteDepartmentRequest, DeleteDepartmentRequestBuilder> {
  @BuiltValueField(wireName: r'department_title')
  String get departmentTitle;

  DeleteDepartmentRequest._();

  factory DeleteDepartmentRequest(
          [void updates(DeleteDepartmentRequestBuilder b)]) =
      _$DeleteDepartmentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteDepartmentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteDepartmentRequest> get serializer =>
      _$DeleteDepartmentRequestSerializer();
}

class _$DeleteDepartmentRequestSerializer
    implements PrimitiveSerializer<DeleteDepartmentRequest> {
  @override
  final Iterable<Type> types = const [
    DeleteDepartmentRequest,
    _$DeleteDepartmentRequest
  ];

  @override
  final String wireName = r'DeleteDepartmentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteDepartmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'department_title';
    yield serializers.serialize(
      object.departmentTitle,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DeleteDepartmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeleteDepartmentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'department_title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.departmentTitle = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeleteDepartmentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteDepartmentRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
