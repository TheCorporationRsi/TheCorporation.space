//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:corp_api/src/model/get_user_influence_stats200_response_departments_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_user_influence_stats200_response.g.dart';

/// GetUserInfluenceStats200Response
///
/// Properties:
/// * [departments] 
/// * [generalInfluence] 
/// * [lifetimeGeneralInfluence] 
/// * [totalInfluence] 
/// * [totalLifetimeInfluence] 
@BuiltValue()
abstract class GetUserInfluenceStats200Response implements Built<GetUserInfluenceStats200Response, GetUserInfluenceStats200ResponseBuilder> {
  @BuiltValueField(wireName: r'departments')
  BuiltList<GetUserInfluenceStats200ResponseDepartmentsInner>? get departments;

  @BuiltValueField(wireName: r'general_influence')
  int? get generalInfluence;

  @BuiltValueField(wireName: r'lifetime_general_influence')
  int? get lifetimeGeneralInfluence;

  @BuiltValueField(wireName: r'total_influence')
  int? get totalInfluence;

  @BuiltValueField(wireName: r'total_lifetime_influence')
  int? get totalLifetimeInfluence;

  GetUserInfluenceStats200Response._();

  factory GetUserInfluenceStats200Response([void updates(GetUserInfluenceStats200ResponseBuilder b)]) = _$GetUserInfluenceStats200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetUserInfluenceStats200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetUserInfluenceStats200Response> get serializer => _$GetUserInfluenceStats200ResponseSerializer();
}

class _$GetUserInfluenceStats200ResponseSerializer implements PrimitiveSerializer<GetUserInfluenceStats200Response> {
  @override
  final Iterable<Type> types = const [GetUserInfluenceStats200Response, _$GetUserInfluenceStats200Response];

  @override
  final String wireName = r'GetUserInfluenceStats200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetUserInfluenceStats200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.departments != null) {
      yield r'departments';
      yield serializers.serialize(
        object.departments,
        specifiedType: const FullType(BuiltList, [FullType(GetUserInfluenceStats200ResponseDepartmentsInner)]),
      );
    }
    if (object.generalInfluence != null) {
      yield r'general_influence';
      yield serializers.serialize(
        object.generalInfluence,
        specifiedType: const FullType(int),
      );
    }
    if (object.lifetimeGeneralInfluence != null) {
      yield r'lifetime_general_influence';
      yield serializers.serialize(
        object.lifetimeGeneralInfluence,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalInfluence != null) {
      yield r'total_influence';
      yield serializers.serialize(
        object.totalInfluence,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalLifetimeInfluence != null) {
      yield r'total_lifetime_influence';
      yield serializers.serialize(
        object.totalLifetimeInfluence,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetUserInfluenceStats200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetUserInfluenceStats200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'departments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(GetUserInfluenceStats200ResponseDepartmentsInner)]),
          ) as BuiltList<GetUserInfluenceStats200ResponseDepartmentsInner>;
          result.departments.replace(valueDes);
          break;
        case r'general_influence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.generalInfluence = valueDes;
          break;
        case r'lifetime_general_influence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lifetimeGeneralInfluence = valueDes;
          break;
        case r'total_influence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalInfluence = valueDes;
          break;
        case r'total_lifetime_influence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalLifetimeInfluence = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetUserInfluenceStats200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetUserInfluenceStats200ResponseBuilder();
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

