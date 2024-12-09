//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'manualy_verify_user200_response.g.dart';

/// ManualyVerifyUser200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class ManualyVerifyUser200Response
    implements
        Built<ManualyVerifyUser200Response,
            ManualyVerifyUser200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  ManualyVerifyUser200Response._();

  factory ManualyVerifyUser200Response(
          [void updates(ManualyVerifyUser200ResponseBuilder b)]) =
      _$ManualyVerifyUser200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ManualyVerifyUser200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ManualyVerifyUser200Response> get serializer =>
      _$ManualyVerifyUser200ResponseSerializer();
}

class _$ManualyVerifyUser200ResponseSerializer
    implements PrimitiveSerializer<ManualyVerifyUser200Response> {
  @override
  final Iterable<Type> types = const [
    ManualyVerifyUser200Response,
    _$ManualyVerifyUser200Response
  ];

  @override
  final String wireName = r'ManualyVerifyUser200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ManualyVerifyUser200Response object, {
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
    ManualyVerifyUser200Response object, {
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
    required ManualyVerifyUser200ResponseBuilder result,
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
  ManualyVerifyUser200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ManualyVerifyUser200ResponseBuilder();
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
