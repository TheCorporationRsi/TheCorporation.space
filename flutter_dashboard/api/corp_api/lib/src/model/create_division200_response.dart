//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_division200_response.g.dart';

/// CreateDivision200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class CreateDivision200Response
    implements
        Built<CreateDivision200Response, CreateDivision200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  CreateDivision200Response._();

  factory CreateDivision200Response(
          [void updates(CreateDivision200ResponseBuilder b)]) =
      _$CreateDivision200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateDivision200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateDivision200Response> get serializer =>
      _$CreateDivision200ResponseSerializer();
}

class _$CreateDivision200ResponseSerializer
    implements PrimitiveSerializer<CreateDivision200Response> {
  @override
  final Iterable<Type> types = const [
    CreateDivision200Response,
    _$CreateDivision200Response
  ];

  @override
  final String wireName = r'CreateDivision200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateDivision200Response object, {
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
    CreateDivision200Response object, {
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
    required CreateDivision200ResponseBuilder result,
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
  CreateDivision200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateDivision200ResponseBuilder();
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
