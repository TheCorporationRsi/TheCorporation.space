//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_user_departments200_response.g.dart';

/// GetUserDepartments200Response
///
/// Properties:
/// * [title]
@BuiltValue()
abstract class GetUserDepartments200Response
    implements
        Built<GetUserDepartments200Response,
            GetUserDepartments200ResponseBuilder> {
  @BuiltValueField(wireName: r'title')
  String? get title;

  GetUserDepartments200Response._();

  factory GetUserDepartments200Response(
          [void updates(GetUserDepartments200ResponseBuilder b)]) =
      _$GetUserDepartments200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetUserDepartments200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetUserDepartments200Response> get serializer =>
      _$GetUserDepartments200ResponseSerializer();
}

class _$GetUserDepartments200ResponseSerializer
    implements PrimitiveSerializer<GetUserDepartments200Response> {
  @override
  final Iterable<Type> types = const [
    GetUserDepartments200Response,
    _$GetUserDepartments200Response
  ];

  @override
  final String wireName = r'GetUserDepartments200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetUserDepartments200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetUserDepartments200Response object, {
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
    required GetUserDepartments200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetUserDepartments200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetUserDepartments200ResponseBuilder();
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
