//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_departments200_response_inner_divisions_inner.g.dart';

/// GetDepartments200ResponseInnerDivisionsInner
///
/// Properties:
/// * [description]
/// * [leaders]
/// * [logo]
/// * [motto]
/// * [proxys]
/// * [title]
@BuiltValue()
abstract class GetDepartments200ResponseInnerDivisionsInner
    implements
        Built<GetDepartments200ResponseInnerDivisionsInner,
            GetDepartments200ResponseInnerDivisionsInnerBuilder> {
  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'leaders')
  BuiltList<String>? get leaders;

  @BuiltValueField(wireName: r'logo')
  String? get logo;

  @BuiltValueField(wireName: r'motto')
  String? get motto;

  @BuiltValueField(wireName: r'proxys')
  BuiltList<String>? get proxys;

  @BuiltValueField(wireName: r'title')
  String? get title;

  GetDepartments200ResponseInnerDivisionsInner._();

  factory GetDepartments200ResponseInnerDivisionsInner(
          [void updates(
              GetDepartments200ResponseInnerDivisionsInnerBuilder b)]) =
      _$GetDepartments200ResponseInnerDivisionsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(
          GetDepartments200ResponseInnerDivisionsInnerBuilder b) =>
      b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetDepartments200ResponseInnerDivisionsInner>
      get serializer =>
          _$GetDepartments200ResponseInnerDivisionsInnerSerializer();
}

class _$GetDepartments200ResponseInnerDivisionsInnerSerializer
    implements
        PrimitiveSerializer<GetDepartments200ResponseInnerDivisionsInner> {
  @override
  final Iterable<Type> types = const [
    GetDepartments200ResponseInnerDivisionsInner,
    _$GetDepartments200ResponseInnerDivisionsInner
  ];

  @override
  final String wireName = r'GetDepartments200ResponseInnerDivisionsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetDepartments200ResponseInnerDivisionsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.leaders != null) {
      yield r'leaders';
      yield serializers.serialize(
        object.leaders,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.logo != null) {
      yield r'logo';
      yield serializers.serialize(
        object.logo,
        specifiedType: const FullType(String),
      );
    }
    if (object.motto != null) {
      yield r'motto';
      yield serializers.serialize(
        object.motto,
        specifiedType: const FullType(String),
      );
    }
    if (object.proxys != null) {
      yield r'proxys';
      yield serializers.serialize(
        object.proxys,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
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
    GetDepartments200ResponseInnerDivisionsInner object, {
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
    required GetDepartments200ResponseInnerDivisionsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'leaders':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.leaders.replace(valueDes);
          break;
        case r'logo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.logo = valueDes;
          break;
        case r'motto':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.motto = valueDes;
          break;
        case r'proxys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.proxys.replace(valueDes);
          break;
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
  GetDepartments200ResponseInnerDivisionsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetDepartments200ResponseInnerDivisionsInnerBuilder();
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
