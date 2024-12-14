//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:corp_api/src/model/get_user_influence_stats200_response_departments_inner_divisions_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_user_influence_stats200_response_departments_inner.g.dart';

/// GetUserInfluenceStats200ResponseDepartmentsInner
///
/// Properties:
/// * [color] 
/// * [departmentTitle] 
/// * [divisions] 
/// * [influence] 
/// * [lifetimeInfluence] 
@BuiltValue()
abstract class GetUserInfluenceStats200ResponseDepartmentsInner implements Built<GetUserInfluenceStats200ResponseDepartmentsInner, GetUserInfluenceStats200ResponseDepartmentsInnerBuilder> {
  @BuiltValueField(wireName: r'color')
  String? get color;

  @BuiltValueField(wireName: r'department_title')
  String? get departmentTitle;

  @BuiltValueField(wireName: r'divisions')
  BuiltList<GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner>? get divisions;

  @BuiltValueField(wireName: r'influence')
  int? get influence;

  @BuiltValueField(wireName: r'lifetime_influence')
  int? get lifetimeInfluence;

  GetUserInfluenceStats200ResponseDepartmentsInner._();

  factory GetUserInfluenceStats200ResponseDepartmentsInner([void updates(GetUserInfluenceStats200ResponseDepartmentsInnerBuilder b)]) = _$GetUserInfluenceStats200ResponseDepartmentsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetUserInfluenceStats200ResponseDepartmentsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetUserInfluenceStats200ResponseDepartmentsInner> get serializer => _$GetUserInfluenceStats200ResponseDepartmentsInnerSerializer();
}

class _$GetUserInfluenceStats200ResponseDepartmentsInnerSerializer implements PrimitiveSerializer<GetUserInfluenceStats200ResponseDepartmentsInner> {
  @override
  final Iterable<Type> types = const [GetUserInfluenceStats200ResponseDepartmentsInner, _$GetUserInfluenceStats200ResponseDepartmentsInner];

  @override
  final String wireName = r'GetUserInfluenceStats200ResponseDepartmentsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetUserInfluenceStats200ResponseDepartmentsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.color != null) {
      yield r'color';
      yield serializers.serialize(
        object.color,
        specifiedType: const FullType(String),
      );
    }
    if (object.departmentTitle != null) {
      yield r'department_title';
      yield serializers.serialize(
        object.departmentTitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.divisions != null) {
      yield r'divisions';
      yield serializers.serialize(
        object.divisions,
        specifiedType: const FullType(BuiltList, [FullType(GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner)]),
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
    GetUserInfluenceStats200ResponseDepartmentsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetUserInfluenceStats200ResponseDepartmentsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.color = valueDes;
          break;
        case r'department_title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.departmentTitle = valueDes;
          break;
        case r'divisions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner)]),
          ) as BuiltList<GetUserInfluenceStats200ResponseDepartmentsInnerDivisionsInner>;
          result.divisions.replace(valueDes);
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
  GetUserInfluenceStats200ResponseDepartmentsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetUserInfluenceStats200ResponseDepartmentsInnerBuilder();
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

