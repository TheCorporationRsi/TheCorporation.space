//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_auction200_response.g.dart';

/// DeleteAuction200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class DeleteAuction200Response
    implements
        Built<DeleteAuction200Response, DeleteAuction200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  DeleteAuction200Response._();

  factory DeleteAuction200Response(
          [void updates(DeleteAuction200ResponseBuilder b)]) =
      _$DeleteAuction200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteAuction200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteAuction200Response> get serializer =>
      _$DeleteAuction200ResponseSerializer();
}

class _$DeleteAuction200ResponseSerializer
    implements PrimitiveSerializer<DeleteAuction200Response> {
  @override
  final Iterable<Type> types = const [
    DeleteAuction200Response,
    _$DeleteAuction200Response
  ];

  @override
  final String wireName = r'DeleteAuction200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteAuction200Response object, {
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
    DeleteAuction200Response object, {
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
    required DeleteAuction200ResponseBuilder result,
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
  DeleteAuction200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteAuction200ResponseBuilder();
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
