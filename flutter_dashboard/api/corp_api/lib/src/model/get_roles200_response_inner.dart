//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_roles200_response_inner.g.dart';

/// GetRoles200ResponseInner
///
/// Properties:
/// * [color]
/// * [department]
/// * [discordId]
/// * [division]
/// * [title]
@BuiltValue()
abstract class GetRoles200ResponseInner
    implements
        Built<GetRoles200ResponseInner, GetRoles200ResponseInnerBuilder> {
  @BuiltValueField(wireName: r'color')
  String? get color;

  @BuiltValueField(wireName: r'department')
  String? get department;

  @BuiltValueField(wireName: r'discord_id')
  String? get discordId;

  @BuiltValueField(wireName: r'division')
  String? get division;

  @BuiltValueField(wireName: r'title')
  String? get title;

  GetRoles200ResponseInner._();

  factory GetRoles200ResponseInner(
          [void updates(GetRoles200ResponseInnerBuilder b)]) =
      _$GetRoles200ResponseInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetRoles200ResponseInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetRoles200ResponseInner> get serializer =>
      _$GetRoles200ResponseInnerSerializer();
}

class _$GetRoles200ResponseInnerSerializer
    implements PrimitiveSerializer<GetRoles200ResponseInner> {
  @override
  final Iterable<Type> types = const [
    GetRoles200ResponseInner,
    _$GetRoles200ResponseInner
  ];

  @override
  final String wireName = r'GetRoles200ResponseInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetRoles200ResponseInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.color != null) {
      yield r'color';
      yield serializers.serialize(
        object.color,
        specifiedType: const FullType(String),
      );
    }
    if (object.department != null) {
      yield r'department';
      yield serializers.serialize(
        object.department,
        specifiedType: const FullType(String),
      );
    }
    if (object.discordId != null) {
      yield r'discord_id';
      yield serializers.serialize(
        object.discordId,
        specifiedType: const FullType(String),
      );
    }
    if (object.division != null) {
      yield r'division';
      yield serializers.serialize(
        object.division,
        specifiedType: const FullType(String),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetRoles200ResponseInner object, {
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
    required GetRoles200ResponseInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.color = valueDes;
          break;
        case r'department':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.department = valueDes;
          break;
        case r'discord_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.discordId = valueDes;
          break;
        case r'division':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.division = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetRoles200ResponseInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetRoles200ResponseInnerBuilder();
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
