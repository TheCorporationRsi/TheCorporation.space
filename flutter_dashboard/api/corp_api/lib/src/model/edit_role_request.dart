//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'edit_role_request.g.dart';

/// EditRoleRequest
///
/// Properties:
/// * [newColor]
/// * [newDiscordId]
/// * [newTitle]
/// * [roleTitle]
@BuiltValue()
abstract class EditRoleRequest
    implements Built<EditRoleRequest, EditRoleRequestBuilder> {
  @BuiltValueField(wireName: r'new_color')
  String? get newColor;

  @BuiltValueField(wireName: r'new_discord_id')
  String? get newDiscordId;

  @BuiltValueField(wireName: r'new_title')
  String? get newTitle;

  @BuiltValueField(wireName: r'role_title')
  String? get roleTitle;

  EditRoleRequest._();

  factory EditRoleRequest([void updates(EditRoleRequestBuilder b)]) =
      _$EditRoleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EditRoleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EditRoleRequest> get serializer =>
      _$EditRoleRequestSerializer();
}

class _$EditRoleRequestSerializer
    implements PrimitiveSerializer<EditRoleRequest> {
  @override
  final Iterable<Type> types = const [EditRoleRequest, _$EditRoleRequest];

  @override
  final String wireName = r'EditRoleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EditRoleRequest object, {
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
    EditRoleRequest object, {
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
    required EditRoleRequestBuilder result,
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
  EditRoleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EditRoleRequestBuilder();
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
