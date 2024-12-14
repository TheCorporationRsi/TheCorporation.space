//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_role_request.g.dart';

/// CreateRoleRequest
///
/// Properties:
/// * [departmentTitle] 
/// * [divisionTitle] 
/// * [title] 
@BuiltValue()
abstract class CreateRoleRequest implements Built<CreateRoleRequest, CreateRoleRequestBuilder> {
  @BuiltValueField(wireName: r'department_title')
  String? get departmentTitle;

  @BuiltValueField(wireName: r'division_title')
  String? get divisionTitle;

  @BuiltValueField(wireName: r'title')
  String? get title;

  CreateRoleRequest._();

  factory CreateRoleRequest([void updates(CreateRoleRequestBuilder b)]) = _$CreateRoleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateRoleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateRoleRequest> get serializer => _$CreateRoleRequestSerializer();
}

class _$CreateRoleRequestSerializer implements PrimitiveSerializer<CreateRoleRequest> {
  @override
  final Iterable<Type> types = const [CreateRoleRequest, _$CreateRoleRequest];

  @override
  final String wireName = r'CreateRoleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateRoleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.departmentTitle != null) {
      yield r'department_title';
      yield serializers.serialize(
        object.departmentTitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.divisionTitle != null) {
      yield r'division_title';
      yield serializers.serialize(
        object.divisionTitle,
        specifiedType: const FullType(String),
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
    CreateRoleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateRoleRequestBuilder result,
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
        case r'division_title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.divisionTitle = valueDes;
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
  CreateRoleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateRoleRequestBuilder();
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

