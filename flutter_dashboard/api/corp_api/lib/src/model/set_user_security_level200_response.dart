//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_user_security_level200_response.g.dart';

/// SetUserSecurityLevel200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class SetUserSecurityLevel200Response
    implements
        Built<SetUserSecurityLevel200Response,
            SetUserSecurityLevel200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  SetUserSecurityLevel200Response._();

  factory SetUserSecurityLevel200Response(
          [void updates(SetUserSecurityLevel200ResponseBuilder b)]) =
      _$SetUserSecurityLevel200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetUserSecurityLevel200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetUserSecurityLevel200Response> get serializer =>
      _$SetUserSecurityLevel200ResponseSerializer();
}

class _$SetUserSecurityLevel200ResponseSerializer
    implements PrimitiveSerializer<SetUserSecurityLevel200Response> {
  @override
  final Iterable<Type> types = const [
    SetUserSecurityLevel200Response,
    _$SetUserSecurityLevel200Response
  ];

  @override
  final String wireName = r'SetUserSecurityLevel200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetUserSecurityLevel200Response object, {
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
    SetUserSecurityLevel200Response object, {
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
    required SetUserSecurityLevel200ResponseBuilder result,
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
  SetUserSecurityLevel200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetUserSecurityLevel200ResponseBuilder();
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
