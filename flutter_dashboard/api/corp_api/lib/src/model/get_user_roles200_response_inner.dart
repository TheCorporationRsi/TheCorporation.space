//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_user_roles200_response_inner.g.dart';

/// GetUserRoles200ResponseInner
///
/// Properties:
/// * [color]
/// * [department]
/// * [division]
/// * [logo]
/// * [title]
/// * [type]
@BuiltValue()
abstract class GetUserRoles200ResponseInner
    implements
        Built<GetUserRoles200ResponseInner,
            GetUserRoles200ResponseInnerBuilder> {
  @BuiltValueField(wireName: r'color')
  String? get color;

  @BuiltValueField(wireName: r'department')
  String? get department;

  @BuiltValueField(wireName: r'division')
  String? get division;

  @BuiltValueField(wireName: r'logo')
  String? get logo;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'type')
  String? get type;

  GetUserRoles200ResponseInner._();

  factory GetUserRoles200ResponseInner(
          [void updates(GetUserRoles200ResponseInnerBuilder b)]) =
      _$GetUserRoles200ResponseInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetUserRoles200ResponseInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetUserRoles200ResponseInner> get serializer =>
      _$GetUserRoles200ResponseInnerSerializer();
}

class _$GetUserRoles200ResponseInnerSerializer
    implements PrimitiveSerializer<GetUserRoles200ResponseInner> {
  @override
  final Iterable<Type> types = const [
    GetUserRoles200ResponseInner,
    _$GetUserRoles200ResponseInner
  ];

  @override
  final String wireName = r'GetUserRoles200ResponseInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetUserRoles200ResponseInner object, {
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
    if (object.division != null) {
      yield r'division';
      yield serializers.serialize(
        object.division,
        specifiedType: const FullType(String),
      );
    }
    if (object.logo != null) {
      yield r'logo';
      yield serializers.serialize(
        object.logo,
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
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetUserRoles200ResponseInner object, {
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
    required GetUserRoles200ResponseInnerBuilder result,
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
        case r'division':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.division = valueDes;
          break;
        case r'logo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.logo = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetUserRoles200ResponseInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetUserRoles200ResponseInnerBuilder();
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
