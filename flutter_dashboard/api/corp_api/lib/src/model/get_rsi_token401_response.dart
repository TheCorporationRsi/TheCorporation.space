//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_rsi_token401_response.g.dart';

/// GetRSIToken401Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class GetRSIToken401Response
    implements Built<GetRSIToken401Response, GetRSIToken401ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  GetRSIToken401Response._();

  factory GetRSIToken401Response(
          [void updates(GetRSIToken401ResponseBuilder b)]) =
      _$GetRSIToken401Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetRSIToken401ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetRSIToken401Response> get serializer =>
      _$GetRSIToken401ResponseSerializer();
}

class _$GetRSIToken401ResponseSerializer
    implements PrimitiveSerializer<GetRSIToken401Response> {
  @override
  final Iterable<Type> types = const [
    GetRSIToken401Response,
    _$GetRSIToken401Response
  ];

  @override
  final String wireName = r'GetRSIToken401Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetRSIToken401Response object, {
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
    GetRSIToken401Response object, {
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
    required GetRSIToken401ResponseBuilder result,
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
  GetRSIToken401Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetRSIToken401ResponseBuilder();
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
