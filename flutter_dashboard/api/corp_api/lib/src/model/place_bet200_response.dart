//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'place_bet200_response.g.dart';

/// PlaceBet200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class PlaceBet200Response
    implements Built<PlaceBet200Response, PlaceBet200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  PlaceBet200Response._();

  factory PlaceBet200Response([void updates(PlaceBet200ResponseBuilder b)]) =
      _$PlaceBet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PlaceBet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PlaceBet200Response> get serializer =>
      _$PlaceBet200ResponseSerializer();
}

class _$PlaceBet200ResponseSerializer
    implements PrimitiveSerializer<PlaceBet200Response> {
  @override
  final Iterable<Type> types = const [
    PlaceBet200Response,
    _$PlaceBet200Response
  ];

  @override
  final String wireName = r'PlaceBet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PlaceBet200Response object, {
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
    PlaceBet200Response object, {
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
    required PlaceBet200ResponseBuilder result,
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
  PlaceBet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PlaceBet200ResponseBuilder();
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
