//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_department_request.g.dart';

/// UpdateDepartmentRequest
///
/// Properties:
/// * [departmentTitle]
/// * [color]
/// * [description]
/// * [logo]
/// * [motto]
/// * [newTitle]
@BuiltValue()
abstract class UpdateDepartmentRequest
    implements Built<UpdateDepartmentRequest, UpdateDepartmentRequestBuilder> {
  @BuiltValueField(wireName: r'department_title')
  String get departmentTitle;

  @BuiltValueField(wireName: r'color')
  String? get color;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'logo')
  String? get logo;

  @BuiltValueField(wireName: r'motto')
  String? get motto;

  @BuiltValueField(wireName: r'new_title')
  String? get newTitle;

  UpdateDepartmentRequest._();

  factory UpdateDepartmentRequest(
          [void updates(UpdateDepartmentRequestBuilder b)]) =
      _$UpdateDepartmentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateDepartmentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateDepartmentRequest> get serializer =>
      _$UpdateDepartmentRequestSerializer();
}

class _$UpdateDepartmentRequestSerializer
    implements PrimitiveSerializer<UpdateDepartmentRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateDepartmentRequest,
    _$UpdateDepartmentRequest
  ];

  @override
  final String wireName = r'UpdateDepartmentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateDepartmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'department_title';
    yield serializers.serialize(
      object.departmentTitle,
      specifiedType: const FullType(String),
    );
    if (object.color != null) {
      yield r'color';
      yield serializers.serialize(
        object.color,
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
    if (object.newTitle != null) {
      yield r'new_title';
      yield serializers.serialize(
        object.newTitle,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateDepartmentRequest object, {
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
    required UpdateDepartmentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'department_title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.departmentTitle = valueDes;
          break;
        case r'color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.color = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
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
        case r'new_title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newTitle = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateDepartmentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateDepartmentRequestBuilder();
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
