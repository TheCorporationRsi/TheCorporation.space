//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_role201_response.g.dart';

/// CreateRole201Response
///
/// Properties:
/// * [msg] 
@BuiltValue()
abstract class CreateRole201Response implements Built<CreateRole201Response, CreateRole201ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  CreateRole201Response._();

  factory CreateRole201Response([void updates(CreateRole201ResponseBuilder b)]) = _$CreateRole201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateRole201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateRole201Response> get serializer => _$CreateRole201ResponseSerializer();
}

class _$CreateRole201ResponseSerializer implements PrimitiveSerializer<CreateRole201Response> {
  @override
  final Iterable<Type> types = const [CreateRole201Response, _$CreateRole201Response];

  @override
  final String wireName = r'CreateRole201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateRole201Response object, {
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
    CreateRole201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateRole201ResponseBuilder result,
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
  CreateRole201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateRole201ResponseBuilder();
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

