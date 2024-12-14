//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'verify_rsi_token200_response.g.dart';

/// VerifyRSIToken200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class VerifyRSIToken200Response implements Built<VerifyRSIToken200Response, VerifyRSIToken200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String? get message;

  VerifyRSIToken200Response._();

  factory VerifyRSIToken200Response([void updates(VerifyRSIToken200ResponseBuilder b)]) = _$VerifyRSIToken200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VerifyRSIToken200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<VerifyRSIToken200Response> get serializer => _$VerifyRSIToken200ResponseSerializer();
}

class _$VerifyRSIToken200ResponseSerializer implements PrimitiveSerializer<VerifyRSIToken200Response> {
  @override
  final Iterable<Type> types = const [VerifyRSIToken200Response, _$VerifyRSIToken200Response];

  @override
  final String wireName = r'VerifyRSIToken200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VerifyRSIToken200Response object, {
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
    VerifyRSIToken200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VerifyRSIToken200ResponseBuilder result,
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
  VerifyRSIToken200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VerifyRSIToken200ResponseBuilder();
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

