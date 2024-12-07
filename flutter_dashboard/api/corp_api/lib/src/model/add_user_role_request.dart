//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'add_user_role_request.g.dart';

/// AddUserRoleRequest
///
/// Properties:
/// * [roleTitle]
/// * [rsiHandle]
@BuiltValue()
abstract class AddUserRoleRequest
    implements Built<AddUserRoleRequest, AddUserRoleRequestBuilder> {
  @BuiltValueField(wireName: r'role_title')
  String? get roleTitle;

  @BuiltValueField(wireName: r'rsi_handle')
  String? get rsiHandle;

  AddUserRoleRequest._();

  factory AddUserRoleRequest([void updates(AddUserRoleRequestBuilder b)]) =
      _$AddUserRoleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddUserRoleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddUserRoleRequest> get serializer =>
      _$AddUserRoleRequestSerializer();
}

class _$AddUserRoleRequestSerializer
    implements PrimitiveSerializer<AddUserRoleRequest> {
  @override
  final Iterable<Type> types = const [AddUserRoleRequest, _$AddUserRoleRequest];

  @override
  final String wireName = r'AddUserRoleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddUserRoleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.roleTitle != null) {
      yield r'role_title';
      yield serializers.serialize(
        object.roleTitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.rsiHandle != null) {
      yield r'rsi_handle';
      yield serializers.serialize(
        object.rsiHandle,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AddUserRoleRequest object, {
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
    required AddUserRoleRequestBuilder result,
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
        case r'rsi_handle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rsiHandle = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AddUserRoleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddUserRoleRequestBuilder();
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
