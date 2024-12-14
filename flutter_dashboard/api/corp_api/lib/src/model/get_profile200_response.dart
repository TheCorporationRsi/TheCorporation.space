//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_profile200_response.g.dart';

/// GetProfile200Response
///
/// Properties:
/// * [influence] 
/// * [lastTributeTime] 
/// * [lifetimeInfluence] 
/// * [rank] 
/// * [tribute] 
@BuiltValue()
abstract class GetProfile200Response implements Built<GetProfile200Response, GetProfile200ResponseBuilder> {
  @BuiltValueField(wireName: r'influence')
  int? get influence;

  @BuiltValueField(wireName: r'last_tribute_time')
  String? get lastTributeTime;

  @BuiltValueField(wireName: r'lifetime_influence')
  int? get lifetimeInfluence;

  @BuiltValueField(wireName: r'rank')
  String? get rank;

  @BuiltValueField(wireName: r'tribute')
  int? get tribute;

  GetProfile200Response._();

  factory GetProfile200Response([void updates(GetProfile200ResponseBuilder b)]) = _$GetProfile200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetProfile200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetProfile200Response> get serializer => _$GetProfile200ResponseSerializer();
}

class _$GetProfile200ResponseSerializer implements PrimitiveSerializer<GetProfile200Response> {
  @override
  final Iterable<Type> types = const [GetProfile200Response, _$GetProfile200Response];

  @override
  final String wireName = r'GetProfile200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetProfile200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.influence != null) {
      yield r'influence';
      yield serializers.serialize(
        object.influence,
        specifiedType: const FullType(int),
      );
    }
    if (object.lastTributeTime != null) {
      yield r'last_tribute_time';
      yield serializers.serialize(
        object.lastTributeTime,
        specifiedType: const FullType(String),
      );
    }
    if (object.lifetimeInfluence != null) {
      yield r'lifetime_influence';
      yield serializers.serialize(
        object.lifetimeInfluence,
        specifiedType: const FullType(int),
      );
    }
    if (object.rank != null) {
      yield r'rank';
      yield serializers.serialize(
        object.rank,
        specifiedType: const FullType(String),
      );
    }
    if (object.tribute != null) {
      yield r'tribute';
      yield serializers.serialize(
        object.tribute,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetProfile200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetProfile200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'influence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.influence = valueDes;
          break;
        case r'last_tribute_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.lastTributeTime = valueDes;
          break;
        case r'lifetime_influence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lifetimeInfluence = valueDes;
          break;
        case r'rank':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rank = valueDes;
          break;
        case r'tribute':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.tribute = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetProfile200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetProfile200ResponseBuilder();
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

