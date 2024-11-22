//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_v0_structure_profile_roles_get200_response.g.dart';

/// ApiV0StructureProfileRolesGet200Response
///
/// Properties:
/// * [title]
@BuiltValue()
abstract class ApiV0StructureProfileRolesGet200Response
    implements
        Built<ApiV0StructureProfileRolesGet200Response,
            ApiV0StructureProfileRolesGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'title')
  String? get title;

  ApiV0StructureProfileRolesGet200Response._();

  factory ApiV0StructureProfileRolesGet200Response(
          [void updates(ApiV0StructureProfileRolesGet200ResponseBuilder b)]) =
      _$ApiV0StructureProfileRolesGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiV0StructureProfileRolesGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiV0StructureProfileRolesGet200Response> get serializer =>
      _$ApiV0StructureProfileRolesGet200ResponseSerializer();
}

class _$ApiV0StructureProfileRolesGet200ResponseSerializer
    implements PrimitiveSerializer<ApiV0StructureProfileRolesGet200Response> {
  @override
  final Iterable<Type> types = const [
    ApiV0StructureProfileRolesGet200Response,
    _$ApiV0StructureProfileRolesGet200Response
  ];

  @override
  final String wireName = r'ApiV0StructureProfileRolesGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiV0StructureProfileRolesGet200Response object, {
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
    ApiV0StructureProfileRolesGet200Response object, {
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
    required ApiV0StructureProfileRolesGet200ResponseBuilder result,
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
  ApiV0StructureProfileRolesGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiV0StructureProfileRolesGet200ResponseBuilder();
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
