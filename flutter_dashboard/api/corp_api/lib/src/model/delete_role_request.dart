//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_role_request.g.dart';

/// DeleteRoleRequest
///
/// Properties:
/// * [roleTitle]
@BuiltValue()
abstract class DeleteRoleRequest
    implements Built<DeleteRoleRequest, DeleteRoleRequestBuilder> {
  @BuiltValueField(wireName: r'role_title')
  String? get roleTitle;

  DeleteRoleRequest._();

  factory DeleteRoleRequest([void updates(DeleteRoleRequestBuilder b)]) =
      _$DeleteRoleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteRoleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteRoleRequest> get serializer =>
      _$DeleteRoleRequestSerializer();
}

class _$DeleteRoleRequestSerializer
    implements PrimitiveSerializer<DeleteRoleRequest> {
  @override
  final Iterable<Type> types = const [DeleteRoleRequest, _$DeleteRoleRequest];

  @override
  final String wireName = r'DeleteRoleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteRoleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.roleTitle != null) {
      yield r'role_title';
      yield serializers.serialize(
        object.roleTitle,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DeleteRoleRequest object, {
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
    required DeleteRoleRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'role_title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.roleTitle = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeleteRoleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteRoleRequestBuilder();
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
