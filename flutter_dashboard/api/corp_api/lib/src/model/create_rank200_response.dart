//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_rank200_response.g.dart';

/// CreateRank200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class CreateRank200Response
    implements Built<CreateRank200Response, CreateRank200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  CreateRank200Response._();

  factory CreateRank200Response(
      [void updates(CreateRank200ResponseBuilder b)]) = _$CreateRank200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateRank200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateRank200Response> get serializer =>
      _$CreateRank200ResponseSerializer();
}

class _$CreateRank200ResponseSerializer
    implements PrimitiveSerializer<CreateRank200Response> {
  @override
  final Iterable<Type> types = const [
    CreateRank200Response,
    _$CreateRank200Response
  ];

  @override
  final String wireName = r'CreateRank200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateRank200Response object, {
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
    CreateRank200Response object, {
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
    required CreateRank200ResponseBuilder result,
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
  CreateRank200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateRank200ResponseBuilder();
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
