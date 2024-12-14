//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_department200_response.g.dart';

/// CreateDepartment200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class CreateDepartment200Response
    implements
        Built<CreateDepartment200Response, CreateDepartment200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  CreateDepartment200Response._();

  factory CreateDepartment200Response(
          [void updates(CreateDepartment200ResponseBuilder b)]) =
      _$CreateDepartment200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateDepartment200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateDepartment200Response> get serializer =>
      _$CreateDepartment200ResponseSerializer();
}

class _$CreateDepartment200ResponseSerializer
    implements PrimitiveSerializer<CreateDepartment200Response> {
  @override
  final Iterable<Type> types = const [
    CreateDepartment200Response,
    _$CreateDepartment200Response
  ];

  @override
  final String wireName = r'CreateDepartment200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateDepartment200Response object, {
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
    CreateDepartment200Response object, {
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
    required CreateDepartment200ResponseBuilder result,
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
  CreateDepartment200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateDepartment200ResponseBuilder();
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
