//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_rsi_token200_response.g.dart';

/// GetRSIToken200Response
///
/// Properties:
/// * [rSIToken]
@BuiltValue()
abstract class GetRSIToken200Response
    implements Built<GetRSIToken200Response, GetRSIToken200ResponseBuilder> {
  @BuiltValueField(wireName: r'RSI_token')
  String? get rSIToken;

  GetRSIToken200Response._();

  factory GetRSIToken200Response(
          [void updates(GetRSIToken200ResponseBuilder b)]) =
      _$GetRSIToken200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetRSIToken200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetRSIToken200Response> get serializer =>
      _$GetRSIToken200ResponseSerializer();
}

class _$GetRSIToken200ResponseSerializer
    implements PrimitiveSerializer<GetRSIToken200Response> {
  @override
  final Iterable<Type> types = const [
    GetRSIToken200Response,
    _$GetRSIToken200Response
  ];

  @override
  final String wireName = r'GetRSIToken200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetRSIToken200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.rSIToken != null) {
      yield r'RSI_token';
      yield serializers.serialize(
        object.rSIToken,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetRSIToken200Response object, {
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
    required GetRSIToken200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'RSI_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rSIToken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetRSIToken200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetRSIToken200ResponseBuilder();
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
