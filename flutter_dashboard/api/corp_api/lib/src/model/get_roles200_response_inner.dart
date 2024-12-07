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
/// * [title]
@BuiltValue()
abstract class GetRoles200ResponseInner
    implements
        Built<GetRoles200ResponseInner, GetRoles200ResponseInnerBuilder> {
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
