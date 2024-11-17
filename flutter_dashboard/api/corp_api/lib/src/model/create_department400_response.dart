//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_department400_response.g.dart';

/// CreateDepartment400Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class CreateDepartment400Response
    implements
        Built<CreateDepartment400Response, CreateDepartment400ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  CreateDepartment400Response._();

  factory CreateDepartment400Response(
          [void updates(CreateDepartment400ResponseBuilder b)]) =
      _$CreateDepartment400Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateDepartment400ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateDepartment400Response> get serializer =>
      _$CreateDepartment400ResponseSerializer();
}

class _$CreateDepartment400ResponseSerializer
    implements PrimitiveSerializer<CreateDepartment400Response> {
  @override
  final Iterable<Type> types = const [
    CreateDepartment400Response,
    _$CreateDepartment400Response
  ];

  @override
  final String wireName = r'CreateDepartment400Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateDepartment400Response object, {
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
    CreateDepartment400Response object, {
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
    required CreateDepartment400ResponseBuilder result,
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
  CreateDepartment400Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateDepartment400ResponseBuilder();
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
