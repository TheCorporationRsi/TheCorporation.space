//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_user_profile200_response.g.dart';

/// GetUserProfile200Response
///
/// Properties:
/// * [moniker] 
/// * [picture] 
/// * [rSIHandle] 
@BuiltValue()
abstract class GetUserProfile200Response implements Built<GetUserProfile200Response, GetUserProfile200ResponseBuilder> {
  @BuiltValueField(wireName: r'Moniker')
  String? get moniker;

  @BuiltValueField(wireName: r'Picture')
  String? get picture;

  @BuiltValueField(wireName: r'RSI_handle')
  String? get rSIHandle;

  GetUserProfile200Response._();

  factory GetUserProfile200Response([void updates(GetUserProfile200ResponseBuilder b)]) = _$GetUserProfile200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetUserProfile200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetUserProfile200Response> get serializer => _$GetUserProfile200ResponseSerializer();
}

class _$GetUserProfile200ResponseSerializer implements PrimitiveSerializer<GetUserProfile200Response> {
  @override
  final Iterable<Type> types = const [GetUserProfile200Response, _$GetUserProfile200Response];

  @override
  final String wireName = r'GetUserProfile200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetUserProfile200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.moniker != null) {
      yield r'Moniker';
      yield serializers.serialize(
        object.moniker,
        specifiedType: const FullType(String),
      );
    }
    if (object.picture != null) {
      yield r'Picture';
      yield serializers.serialize(
        object.picture,
        specifiedType: const FullType(String),
      );
    }
    if (object.rSIHandle != null) {
      yield r'RSI_handle';
      yield serializers.serialize(
        object.rSIHandle,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetUserProfile200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetUserProfile200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'Moniker':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.moniker = valueDes;
          break;
        case r'Picture':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.picture = valueDes;
          break;
        case r'RSI_handle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rSIHandle = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetUserProfile200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetUserProfile200ResponseBuilder();
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

