//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'register200_response.g.dart';

/// Register200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class Register200Response
    implements Built<Register200Response, Register200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  Register200Response._();

  factory Register200Response([void updates(Register200ResponseBuilder b)]) =
      _$Register200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Register200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Register200Response> get serializer =>
      _$Register200ResponseSerializer();
}

class _$Register200ResponseSerializer
    implements PrimitiveSerializer<Register200Response> {
  @override
  final Iterable<Type> types = const [
    Register200Response,
    _$Register200Response
  ];

  @override
  final String wireName = r'Register200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Register200Response object, {
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
    Register200Response object, {
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
    required Register200ResponseBuilder result,
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
  Register200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Register200ResponseBuilder();
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
