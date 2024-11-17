//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_tribute400_response.g.dart';

/// SendTribute400Response
///
/// Properties:
/// * [message]
@BuiltValue()
abstract class SendTribute400Response
    implements Built<SendTribute400Response, SendTribute400ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String? get message;

  SendTribute400Response._();

  factory SendTribute400Response(
          [void updates(SendTribute400ResponseBuilder b)]) =
      _$SendTribute400Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendTribute400ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendTribute400Response> get serializer =>
      _$SendTribute400ResponseSerializer();
}

class _$SendTribute400ResponseSerializer
    implements PrimitiveSerializer<SendTribute400Response> {
  @override
  final Iterable<Type> types = const [
    SendTribute400Response,
    _$SendTribute400Response
  ];

  @override
  final String wireName = r'SendTribute400Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendTribute400Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SendTribute400Response object, {
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
    required SendTribute400ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SendTribute400Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendTribute400ResponseBuilder();
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
