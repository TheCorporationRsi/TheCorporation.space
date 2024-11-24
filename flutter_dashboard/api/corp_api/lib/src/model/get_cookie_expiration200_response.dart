//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_cookie_expiration200_response.g.dart';

/// GetCookieExpiration200Response
///
/// Properties:
/// * [corpAccessPassExpiration]
/// * [corpRefreshPassExpiration]
@BuiltValue()
abstract class GetCookieExpiration200Response
    implements
        Built<GetCookieExpiration200Response,
            GetCookieExpiration200ResponseBuilder> {
  @BuiltValueField(wireName: r'corp_access_pass_expiration')
  String? get corpAccessPassExpiration;

  @BuiltValueField(wireName: r'corp_refresh_pass_expiration')
  String? get corpRefreshPassExpiration;

  GetCookieExpiration200Response._();

  factory GetCookieExpiration200Response(
          [void updates(GetCookieExpiration200ResponseBuilder b)]) =
      _$GetCookieExpiration200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetCookieExpiration200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetCookieExpiration200Response> get serializer =>
      _$GetCookieExpiration200ResponseSerializer();
}

class _$GetCookieExpiration200ResponseSerializer
    implements PrimitiveSerializer<GetCookieExpiration200Response> {
  @override
  final Iterable<Type> types = const [
    GetCookieExpiration200Response,
    _$GetCookieExpiration200Response
  ];

  @override
  final String wireName = r'GetCookieExpiration200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetCookieExpiration200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.corpAccessPassExpiration != null) {
      yield r'corp_access_pass_expiration';
      yield serializers.serialize(
        object.corpAccessPassExpiration,
        specifiedType: const FullType(String),
      );
    }
    if (object.corpRefreshPassExpiration != null) {
      yield r'corp_refresh_pass_expiration';
      yield serializers.serialize(
        object.corpRefreshPassExpiration,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetCookieExpiration200Response object, {
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
    required GetCookieExpiration200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'corp_access_pass_expiration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.corpAccessPassExpiration = valueDes;
          break;
        case r'corp_refresh_pass_expiration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.corpRefreshPassExpiration = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetCookieExpiration200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetCookieExpiration200ResponseBuilder();
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
