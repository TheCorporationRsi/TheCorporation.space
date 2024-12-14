//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'remove_user_role200_response.g.dart';

/// RemoveUserRole200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class RemoveUserRole200Response
    implements
        Built<RemoveUserRole200Response, RemoveUserRole200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  RemoveUserRole200Response._();

  factory RemoveUserRole200Response(
          [void updates(RemoveUserRole200ResponseBuilder b)]) =
      _$RemoveUserRole200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RemoveUserRole200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RemoveUserRole200Response> get serializer =>
      _$RemoveUserRole200ResponseSerializer();
}

class _$RemoveUserRole200ResponseSerializer
    implements PrimitiveSerializer<RemoveUserRole200Response> {
  @override
  final Iterable<Type> types = const [
    RemoveUserRole200Response,
    _$RemoveUserRole200Response
  ];

  @override
  final String wireName = r'RemoveUserRole200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RemoveUserRole200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.msg != null) {
      yield r'msg';
      yield serializers.serialize(
        object.msg,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RemoveUserRole200Response object, {
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
    required RemoveUserRole200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'msg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.msg = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RemoveUserRole200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RemoveUserRole200ResponseBuilder();
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
