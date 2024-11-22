//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_user_divisions200_response.g.dart';

/// GetUserDivisions200Response
///
/// Properties:
/// * [title]
@BuiltValue()
abstract class GetUserDivisions200Response
    implements
        Built<GetUserDivisions200Response, GetUserDivisions200ResponseBuilder> {
  @BuiltValueField(wireName: r'title')
  String? get title;

  GetUserDivisions200Response._();

  factory GetUserDivisions200Response(
          [void updates(GetUserDivisions200ResponseBuilder b)]) =
      _$GetUserDivisions200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetUserDivisions200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetUserDivisions200Response> get serializer =>
      _$GetUserDivisions200ResponseSerializer();
}

class _$GetUserDivisions200ResponseSerializer
    implements PrimitiveSerializer<GetUserDivisions200Response> {
  @override
  final Iterable<Type> types = const [
    GetUserDivisions200Response,
    _$GetUserDivisions200Response
  ];

  @override
  final String wireName = r'GetUserDivisions200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetUserDivisions200Response object, {
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
    GetUserDivisions200Response object, {
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
    required GetUserDivisions200ResponseBuilder result,
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
  GetUserDivisions200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetUserDivisions200ResponseBuilder();
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
