//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'register400_response.g.dart';

/// Register400Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class Register400Response
    implements Built<Register400Response, Register400ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  Register400Response._();

  factory Register400Response([void updates(Register400ResponseBuilder b)]) =
      _$Register400Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Register400ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Register400Response> get serializer =>
      _$Register400ResponseSerializer();
}

class _$Register400ResponseSerializer
    implements PrimitiveSerializer<Register400Response> {
  @override
  final Iterable<Type> types = const [
    Register400Response,
    _$Register400Response
  ];

  @override
  final String wireName = r'Register400Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Register400Response object, {
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
    Register400Response object, {
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
    required Register400ResponseBuilder result,
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
  Register400Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Register400ResponseBuilder();
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
