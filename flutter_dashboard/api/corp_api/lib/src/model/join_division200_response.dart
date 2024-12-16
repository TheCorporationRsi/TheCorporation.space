//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'join_division200_response.g.dart';

/// JoinDivision200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class JoinDivision200Response
    implements Built<JoinDivision200Response, JoinDivision200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  JoinDivision200Response._();

  factory JoinDivision200Response(
          [void updates(JoinDivision200ResponseBuilder b)]) =
      _$JoinDivision200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(JoinDivision200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<JoinDivision200Response> get serializer =>
      _$JoinDivision200ResponseSerializer();
}

class _$JoinDivision200ResponseSerializer
    implements PrimitiveSerializer<JoinDivision200Response> {
  @override
  final Iterable<Type> types = const [
    JoinDivision200Response,
    _$JoinDivision200Response
  ];

  @override
  final String wireName = r'JoinDivision200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    JoinDivision200Response object, {
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
    JoinDivision200Response object, {
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
    required JoinDivision200ResponseBuilder result,
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
  JoinDivision200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = JoinDivision200ResponseBuilder();
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
