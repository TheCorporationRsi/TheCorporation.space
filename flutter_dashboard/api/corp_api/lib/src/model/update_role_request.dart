//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_role_request.g.dart';

/// UpdateRoleRequest
///
/// Properties:
/// * [newColor] 
/// * [newDiscordId] 
/// * [newLogo] 
/// * [newTitle] 
/// * [roleTitle] 
@BuiltValue()
abstract class UpdateRoleRequest implements Built<UpdateRoleRequest, UpdateRoleRequestBuilder> {
  @BuiltValueField(wireName: r'new_color')
  String? get newColor;

  @BuiltValueField(wireName: r'new_discord_id')
  String? get newDiscordId;

  @BuiltValueField(wireName: r'new_logo')
  String? get newLogo;

  @BuiltValueField(wireName: r'new_title')
  String? get newTitle;

  @BuiltValueField(wireName: r'role_title')
  String? get roleTitle;

  UpdateRoleRequest._();

  factory UpdateRoleRequest([void updates(UpdateRoleRequestBuilder b)]) = _$UpdateRoleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateRoleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateRoleRequest> get serializer => _$UpdateRoleRequestSerializer();
}

class _$UpdateRoleRequestSerializer implements PrimitiveSerializer<UpdateRoleRequest> {
  @override
  final Iterable<Type> types = const [UpdateRoleRequest, _$UpdateRoleRequest];

  @override
  final String wireName = r'UpdateRoleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateRoleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.newColor != null) {
      yield r'new_color';
      yield serializers.serialize(
        object.newColor,
        specifiedType: const FullType(String),
      );
    }
    if (object.newDiscordId != null) {
      yield r'new_discord_id';
      yield serializers.serialize(
        object.newDiscordId,
        specifiedType: const FullType(String),
      );
    }
    if (object.newLogo != null) {
      yield r'new_logo';
      yield serializers.serialize(
        object.newLogo,
        specifiedType: const FullType(String),
      );
    }
    if (object.newTitle != null) {
      yield r'new_title';
      yield serializers.serialize(
        object.newTitle,
        specifiedType: const FullType(String),
      );
    }
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
    UpdateRoleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateRoleRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'new_color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newColor = valueDes;
          break;
        case r'new_discord_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newDiscordId = valueDes;
          break;
        case r'new_logo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newLogo = valueDes;
          break;
        case r'new_title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newTitle = valueDes;
          break;
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
  UpdateRoleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateRoleRequestBuilder();
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

