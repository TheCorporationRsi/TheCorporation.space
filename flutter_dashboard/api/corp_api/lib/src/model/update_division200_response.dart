//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_division200_response.g.dart';

/// UpdateDivision200Response
///
/// Properties:
/// * [msg] 
@BuiltValue()
abstract class UpdateDivision200Response implements Built<UpdateDivision200Response, UpdateDivision200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  UpdateDivision200Response._();

  factory UpdateDivision200Response([void updates(UpdateDivision200ResponseBuilder b)]) = _$UpdateDivision200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateDivision200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateDivision200Response> get serializer => _$UpdateDivision200ResponseSerializer();
}

class _$UpdateDivision200ResponseSerializer implements PrimitiveSerializer<UpdateDivision200Response> {
  @override
  final Iterable<Type> types = const [UpdateDivision200Response, _$UpdateDivision200Response];

  @override
  final String wireName = r'UpdateDivision200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateDivision200Response object, {
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
    UpdateDivision200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateDivision200ResponseBuilder result,
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
  UpdateDivision200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateDivision200ResponseBuilder();
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

