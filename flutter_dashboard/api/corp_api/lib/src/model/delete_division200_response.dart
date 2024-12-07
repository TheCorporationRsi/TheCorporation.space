//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_division200_response.g.dart';

/// DeleteDivision200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class DeleteDivision200Response
    implements
        Built<DeleteDivision200Response, DeleteDivision200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  DeleteDivision200Response._();

  factory DeleteDivision200Response(
          [void updates(DeleteDivision200ResponseBuilder b)]) =
      _$DeleteDivision200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteDivision200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteDivision200Response> get serializer =>
      _$DeleteDivision200ResponseSerializer();
}

class _$DeleteDivision200ResponseSerializer
    implements PrimitiveSerializer<DeleteDivision200Response> {
  @override
  final Iterable<Type> types = const [
    DeleteDivision200Response,
    _$DeleteDivision200Response
  ];

  @override
  final String wireName = r'DeleteDivision200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteDivision200Response object, {
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
    DeleteDivision200Response object, {
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
    required DeleteDivision200ResponseBuilder result,
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
  DeleteDivision200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteDivision200ResponseBuilder();
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
