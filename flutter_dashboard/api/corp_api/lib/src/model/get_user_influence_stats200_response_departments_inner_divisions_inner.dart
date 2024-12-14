//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_user_influence_stats200_response_departments_inner_divisions_inner.g.dart';

/// GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner
///
/// Properties:
/// * [divisionTitle] 
/// * [influence] 
/// * [lifetimeInfluence] 
@BuiltValue()
abstract class GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner implements Built<GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner, GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerBuilder> {
  @BuiltValueField(wireName: r'division_title')
  String? get divisionTitle;

  @BuiltValueField(wireName: r'influence')
  int? get influence;

  @BuiltValueField(wireName: r'lifetime_influence')
  int? get lifetimeInfluence;

  GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner._();

  factory GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner([void updates(GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerBuilder b)]) = _$GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner> get serializer => _$GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerSerializer();
}

class _$GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerSerializer implements PrimitiveSerializer<GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner> {
  @override
  final Iterable<Type> types = const [GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner, _$GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner];

  @override
  final String wireName = r'GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.divisionTitle != null) {
      yield r'division_title';
      yield serializers.serialize(
        object.divisionTitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.influence != null) {
      yield r'influence';
      yield serializers.serialize(
        object.influence,
        specifiedType: const FullType(int),
      );
    }
    if (object.lifetimeInfluence != null) {
      yield r'lifetime_influence';
      yield serializers.serialize(
        object.lifetimeInfluence,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'division_title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.divisionTitle = valueDes;
          break;
        case r'influence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.influence = valueDes;
          break;
        case r'lifetime_influence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lifetimeInfluence = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInnerBuilder();
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

