//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_current_funding200_response.g.dart';

/// GetCurrentFunding200Response
///
/// Properties:
/// * [citizens] 
/// * [fund] 
@BuiltValue()
abstract class GetCurrentFunding200Response implements Built<GetCurrentFunding200Response, GetCurrentFunding200ResponseBuilder> {
  @BuiltValueField(wireName: r'citizens')
  int? get citizens;

  @BuiltValueField(wireName: r'fund')
  int? get fund;

  GetCurrentFunding200Response._();

  factory GetCurrentFunding200Response([void updates(GetCurrentFunding200ResponseBuilder b)]) = _$GetCurrentFunding200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetCurrentFunding200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetCurrentFunding200Response> get serializer => _$GetCurrentFunding200ResponseSerializer();
}

class _$GetCurrentFunding200ResponseSerializer implements PrimitiveSerializer<GetCurrentFunding200Response> {
  @override
  final Iterable<Type> types = const [GetCurrentFunding200Response, _$GetCurrentFunding200Response];

  @override
  final String wireName = r'GetCurrentFunding200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetCurrentFunding200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.citizens != null) {
      yield r'citizens';
      yield serializers.serialize(
        object.citizens,
        specifiedType: const FullType(int),
      );
    }
    if (object.fund != null) {
      yield r'fund';
      yield serializers.serialize(
        object.fund,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetCurrentFunding200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetCurrentFunding200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'citizens':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.citizens = valueDes;
          break;
        case r'fund':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.fund = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetCurrentFunding200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetCurrentFunding200ResponseBuilder();
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

