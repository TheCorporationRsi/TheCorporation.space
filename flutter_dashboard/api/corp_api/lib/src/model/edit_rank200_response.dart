//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'edit_rank200_response.g.dart';

/// EditRank200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class EditRank200Response
    implements Built<EditRank200Response, EditRank200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  EditRank200Response._();

  factory EditRank200Response([void updates(EditRank200ResponseBuilder b)]) =
      _$EditRank200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EditRank200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EditRank200Response> get serializer =>
      _$EditRank200ResponseSerializer();
}

class _$EditRank200ResponseSerializer
    implements PrimitiveSerializer<EditRank200Response> {
  @override
  final Iterable<Type> types = const [
    EditRank200Response,
    _$EditRank200Response
  ];

  @override
  final String wireName = r'EditRank200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EditRank200Response object, {
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
    EditRank200Response object, {
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
    required EditRank200ResponseBuilder result,
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
  EditRank200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EditRank200ResponseBuilder();
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
