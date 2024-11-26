//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'refresh_token200_response.g.dart';

/// RefreshToken200Response
///
/// Properties:
/// * [corpAccessPass]
/// * [corpRefreshPass]
/// * [refreshed]
@BuiltValue()
abstract class RefreshToken200Response
    implements Built<RefreshToken200Response, RefreshToken200ResponseBuilder> {
  @BuiltValueField(wireName: r'corp_access_pass')
  String? get corpAccessPass;

  @BuiltValueField(wireName: r'corp_refresh_pass')
  String? get corpRefreshPass;

  @BuiltValueField(wireName: r'refreshed')
  bool? get refreshed;

  RefreshToken200Response._();

  factory RefreshToken200Response(
          [void updates(RefreshToken200ResponseBuilder b)]) =
      _$RefreshToken200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RefreshToken200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RefreshToken200Response> get serializer =>
      _$RefreshToken200ResponseSerializer();
}

class _$RefreshToken200ResponseSerializer
    implements PrimitiveSerializer<RefreshToken200Response> {
  @override
  final Iterable<Type> types = const [
    RefreshToken200Response,
    _$RefreshToken200Response
  ];

  @override
  final String wireName = r'RefreshToken200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RefreshToken200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.corpAccessPass != null) {
      yield r'corp_access_pass';
      yield serializers.serialize(
        object.corpAccessPass,
        specifiedType: const FullType(String),
      );
    }
    if (object.corpRefreshPass != null) {
      yield r'corp_refresh_pass';
      yield serializers.serialize(
        object.corpRefreshPass,
        specifiedType: const FullType(String),
      );
    }
    if (object.refreshed != null) {
      yield r'refreshed';
      yield serializers.serialize(
        object.refreshed,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RefreshToken200Response object, {
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
    required RefreshToken200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'corp_access_pass':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.corpAccessPass = valueDes;
          break;
        case r'corp_refresh_pass':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.corpRefreshPass = valueDes;
          break;
        case r'refreshed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.refreshed = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RefreshToken200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RefreshToken200ResponseBuilder();
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
