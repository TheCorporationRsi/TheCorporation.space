//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login400_response.g.dart';

/// Login400Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class Login400Response
    implements Built<Login400Response, Login400ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  Login400Response._();

  factory Login400Response([void updates(Login400ResponseBuilder b)]) =
      _$Login400Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Login400ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Login400Response> get serializer =>
      _$Login400ResponseSerializer();
}

class _$Login400ResponseSerializer
    implements PrimitiveSerializer<Login400Response> {
  @override
  final Iterable<Type> types = const [Login400Response, _$Login400Response];

  @override
  final String wireName = r'Login400Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Login400Response object, {
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
    Login400Response object, {
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
    required Login400ResponseBuilder result,
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
  Login400Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Login400ResponseBuilder();
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
