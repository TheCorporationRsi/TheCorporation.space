//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_user200_response.g.dart';

/// DeleteUser200Response
///
/// Properties:
/// * [msg] 
@BuiltValue()
abstract class DeleteUser200Response implements Built<DeleteUser200Response, DeleteUser200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  DeleteUser200Response._();

  factory DeleteUser200Response([void updates(DeleteUser200ResponseBuilder b)]) = _$DeleteUser200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteUser200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteUser200Response> get serializer => _$DeleteUser200ResponseSerializer();
}

class _$DeleteUser200ResponseSerializer implements PrimitiveSerializer<DeleteUser200Response> {
  @override
  final Iterable<Type> types = const [DeleteUser200Response, _$DeleteUser200Response];

  @override
  final String wireName = r'DeleteUser200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteUser200Response object, {
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
    DeleteUser200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeleteUser200ResponseBuilder result,
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
  DeleteUser200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteUser200ResponseBuilder();
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

