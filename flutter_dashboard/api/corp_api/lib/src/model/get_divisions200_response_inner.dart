//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_divisions200_response_inner.g.dart';

/// GetDivisions200ResponseInner
///
/// Properties:
/// * [color]
/// * [departmentTitle]
/// * [description]
/// * [leaders]
/// * [logo]
/// * [memberCount]
/// * [motto]
/// * [proxys]
/// * [restricted]
/// * [title]
@BuiltValue()
abstract class GetDivisions200ResponseInner
    implements
        Built<GetDivisions200ResponseInner,
            GetDivisions200ResponseInnerBuilder> {
  @BuiltValueField(wireName: r'color')
  String? get color;

  @BuiltValueField(wireName: r'department_title')
  String? get departmentTitle;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'leaders')
  BuiltList<String>? get leaders;

  @BuiltValueField(wireName: r'logo')
  String? get logo;

  @BuiltValueField(wireName: r'member_count')
  int? get memberCount;

  @BuiltValueField(wireName: r'motto')
  String? get motto;

  @BuiltValueField(wireName: r'proxys')
  BuiltList<String>? get proxys;

  @BuiltValueField(wireName: r'restricted')
  bool? get restricted;

  @BuiltValueField(wireName: r'title')
  String? get title;

  GetDivisions200ResponseInner._();

  factory GetDivisions200ResponseInner(
          [void updates(GetDivisions200ResponseInnerBuilder b)]) =
      _$GetDivisions200ResponseInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetDivisions200ResponseInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetDivisions200ResponseInner> get serializer =>
      _$GetDivisions200ResponseInnerSerializer();
}

class _$GetDivisions200ResponseInnerSerializer
    implements PrimitiveSerializer<GetDivisions200ResponseInner> {
  @override
  final Iterable<Type> types = const [
    GetDivisions200ResponseInner,
    _$GetDivisions200ResponseInner
  ];

  @override
  final String wireName = r'GetDivisions200ResponseInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetDivisions200ResponseInner object, {
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
    if (object.memberCount != null) {
      yield r'member_count';
      yield serializers.serialize(
        object.memberCount,
        specifiedType: const FullType(int),
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
    if (object.restricted != null) {
      yield r'restricted';
      yield serializers.serialize(
        object.restricted,
        specifiedType: const FullType(bool),
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
    GetDivisions200ResponseInner object, {
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
    required GetDivisions200ResponseInnerBuilder result,
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
        case r'member_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.memberCount = valueDes;
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
        case r'restricted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.restricted = valueDes;
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
  GetDivisions200ResponseInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetDivisions200ResponseInnerBuilder();
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
