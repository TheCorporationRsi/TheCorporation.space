//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'edit_role200_response.g.dart';

/// EditRole200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class EditRole200Response
    implements Built<EditRole200Response, EditRole200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  EditRole200Response._();

  factory EditRole200Response([void updates(EditRole200ResponseBuilder b)]) =
      _$EditRole200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EditRole200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EditRole200Response> get serializer =>
      _$EditRole200ResponseSerializer();
}

class _$EditRole200ResponseSerializer
    implements PrimitiveSerializer<EditRole200Response> {
  @override
  final Iterable<Type> types = const [
    EditRole200Response,
    _$EditRole200Response
  ];

  @override
  final String wireName = r'EditRole200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EditRole200Response object, {
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
    EditRole200Response object, {
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
    required EditRole200ResponseBuilder result,
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
  EditRole200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EditRole200ResponseBuilder();
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
