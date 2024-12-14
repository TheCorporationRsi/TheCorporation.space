//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_user200_response_roles_inner.g.dart';

/// GetUser200ResponseRolesInner
///
/// Properties:
/// * [color] 
/// * [title] 
@BuiltValue()
abstract class GetUser200ResponseRolesInner implements Built<GetUser200ResponseRolesInner, GetUser200ResponseRolesInnerBuilder> {
  @BuiltValueField(wireName: r'color')
  String? get color;

  @BuiltValueField(wireName: r'title')
  String? get title;

  GetUser200ResponseRolesInner._();

  factory GetUser200ResponseRolesInner([void updates(GetUser200ResponseRolesInnerBuilder b)]) = _$GetUser200ResponseRolesInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetUser200ResponseRolesInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetUser200ResponseRolesInner> get serializer => _$GetUser200ResponseRolesInnerSerializer();
}

class _$GetUser200ResponseRolesInnerSerializer implements PrimitiveSerializer<GetUser200ResponseRolesInner> {
  @override
  final Iterable<Type> types = const [GetUser200ResponseRolesInner, _$GetUser200ResponseRolesInner];

  @override
  final String wireName = r'GetUser200ResponseRolesInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetUser200ResponseRolesInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.color != null) {
      yield r'color';
      yield serializers.serialize(
        object.color,
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
    GetUser200ResponseRolesInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetUser200ResponseRolesInnerBuilder result,
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
  GetUser200ResponseRolesInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetUser200ResponseRolesInnerBuilder();
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

