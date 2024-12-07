//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_role200_response.g.dart';

/// DeleteRole200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class DeleteRole200Response
    implements Built<DeleteRole200Response, DeleteRole200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  DeleteRole200Response._();

  factory DeleteRole200Response(
      [void updates(DeleteRole200ResponseBuilder b)]) = _$DeleteRole200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteRole200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteRole200Response> get serializer =>
      _$DeleteRole200ResponseSerializer();
}

class _$DeleteRole200ResponseSerializer
    implements PrimitiveSerializer<DeleteRole200Response> {
  @override
  final Iterable<Type> types = const [
    DeleteRole200Response,
    _$DeleteRole200Response
  ];

  @override
  final String wireName = r'DeleteRole200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteRole200Response object, {
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
    DeleteRole200Response object, {
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
    required DeleteRole200ResponseBuilder result,
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
  DeleteRole200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteRole200ResponseBuilder();
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
