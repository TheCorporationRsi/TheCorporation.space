//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_departments200_response.g.dart';

/// GetDepartments200Response
///
/// Properties:
/// * [color]
/// * [division]
/// * [heads]
/// * [logo]
/// * [memberCount]
/// * [motto]
/// * [proxys]
/// * [title]
@BuiltValue()
abstract class GetDepartments200Response
    implements
        Built<GetDepartments200Response, GetDepartments200ResponseBuilder> {
  @BuiltValueField(wireName: r'color')
  String? get color;

  @BuiltValueField(wireName: r'division')
  BuiltList<String>? get division;

  @BuiltValueField(wireName: r'heads')
  BuiltList<String>? get heads;

  @BuiltValueField(wireName: r'logo')
  String? get logo;

  @BuiltValueField(wireName: r'member_count')
  int? get memberCount;

  @BuiltValueField(wireName: r'motto')
  String? get motto;

  @BuiltValueField(wireName: r'proxys')
  BuiltList<String>? get proxys;

  @BuiltValueField(wireName: r'title')
  String? get title;

  GetDepartments200Response._();

  factory GetDepartments200Response(
          [void updates(GetDepartments200ResponseBuilder b)]) =
      _$GetDepartments200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetDepartments200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetDepartments200Response> get serializer =>
      _$GetDepartments200ResponseSerializer();
}

class _$GetDepartments200ResponseSerializer
    implements PrimitiveSerializer<GetDepartments200Response> {
  @override
  final Iterable<Type> types = const [
    GetDepartments200Response,
    _$GetDepartments200Response
  ];

  @override
  final String wireName = r'GetDepartments200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetDepartments200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.color != null) {
      yield r'color';
      yield serializers.serialize(
        object.color,
        specifiedType: const FullType(String),
      );
    }
    if (object.division != null) {
      yield r'division';
      yield serializers.serialize(
        object.division,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.heads != null) {
      yield r'heads';
      yield serializers.serialize(
        object.heads,
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
    GetDepartments200Response object, {
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
    required GetDepartments200ResponseBuilder result,
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
        case r'division':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.division.replace(valueDes);
          break;
        case r'heads':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.heads.replace(valueDes);
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
  GetDepartments200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetDepartments200ResponseBuilder();
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
