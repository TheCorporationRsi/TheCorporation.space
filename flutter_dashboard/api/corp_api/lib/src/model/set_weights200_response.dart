//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_weights200_response.g.dart';

/// SetWeights200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class SetWeights200Response
    implements Built<SetWeights200Response, SetWeights200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  SetWeights200Response._();

  factory SetWeights200Response(
      [void updates(SetWeights200ResponseBuilder b)]) = _$SetWeights200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetWeights200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetWeights200Response> get serializer =>
      _$SetWeights200ResponseSerializer();
}

class _$SetWeights200ResponseSerializer
    implements PrimitiveSerializer<SetWeights200Response> {
  @override
  final Iterable<Type> types = const [
    SetWeights200Response,
    _$SetWeights200Response
  ];

  @override
  final String wireName = r'SetWeights200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetWeights200Response object, {
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
    SetWeights200Response object, {
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
    required SetWeights200ResponseBuilder result,
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
  SetWeights200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetWeights200ResponseBuilder();
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
