//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_role200_response.g.dart';

/// UpdateRole200Response
///
/// Properties:
/// * [msg] 
@BuiltValue()
abstract class UpdateRole200Response implements Built<UpdateRole200Response, UpdateRole200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  UpdateRole200Response._();

  factory UpdateRole200Response([void updates(UpdateRole200ResponseBuilder b)]) = _$UpdateRole200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateRole200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateRole200Response> get serializer => _$UpdateRole200ResponseSerializer();
}

class _$UpdateRole200ResponseSerializer implements PrimitiveSerializer<UpdateRole200Response> {
  @override
  final Iterable<Type> types = const [UpdateRole200Response, _$UpdateRole200Response];

  @override
  final String wireName = r'UpdateRole200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateRole200Response object, {
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
    UpdateRole200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateRole200ResponseBuilder result,
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
  UpdateRole200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateRole200ResponseBuilder();
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

