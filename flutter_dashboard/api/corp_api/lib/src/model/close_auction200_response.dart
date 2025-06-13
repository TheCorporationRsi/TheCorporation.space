//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'close_auction200_response.g.dart';

/// CloseAuction200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class CloseAuction200Response
    implements Built<CloseAuction200Response, CloseAuction200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  CloseAuction200Response._();

  factory CloseAuction200Response(
          [void updates(CloseAuction200ResponseBuilder b)]) =
      _$CloseAuction200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CloseAuction200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CloseAuction200Response> get serializer =>
      _$CloseAuction200ResponseSerializer();
}

class _$CloseAuction200ResponseSerializer
    implements PrimitiveSerializer<CloseAuction200Response> {
  @override
  final Iterable<Type> types = const [
    CloseAuction200Response,
    _$CloseAuction200Response
  ];

  @override
  final String wireName = r'CloseAuction200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CloseAuction200Response object, {
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
    CloseAuction200Response object, {
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
    required CloseAuction200ResponseBuilder result,
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
  CloseAuction200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CloseAuction200ResponseBuilder();
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
