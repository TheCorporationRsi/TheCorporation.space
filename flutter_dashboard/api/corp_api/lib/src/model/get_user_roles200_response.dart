//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_user_roles200_response.g.dart';

/// GetUserRoles200Response
///
/// Properties:
/// * [title]
@BuiltValue()
abstract class GetUserRoles200Response
    implements Built<GetUserRoles200Response, GetUserRoles200ResponseBuilder> {
  @BuiltValueField(wireName: r'title')
  String? get title;

  GetUserRoles200Response._();

  factory GetUserRoles200Response(
          [void updates(GetUserRoles200ResponseBuilder b)]) =
      _$GetUserRoles200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetUserRoles200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetUserRoles200Response> get serializer =>
      _$GetUserRoles200ResponseSerializer();
}

class _$GetUserRoles200ResponseSerializer
    implements PrimitiveSerializer<GetUserRoles200Response> {
  @override
  final Iterable<Type> types = const [
    GetUserRoles200Response,
    _$GetUserRoles200Response
  ];

  @override
  final String wireName = r'GetUserRoles200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetUserRoles200Response object, {
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
    GetUserRoles200Response object, {
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
    required GetUserRoles200ResponseBuilder result,
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
  GetUserRoles200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetUserRoles200ResponseBuilder();
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
