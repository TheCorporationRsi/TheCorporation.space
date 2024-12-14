//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_department_request.g.dart';

/// CreateDepartmentRequest
///
/// Properties:
/// * [title] 
@BuiltValue()
abstract class CreateDepartmentRequest implements Built<CreateDepartmentRequest, CreateDepartmentRequestBuilder> {
  @BuiltValueField(wireName: r'title')
  String get title;

  CreateDepartmentRequest._();

  factory CreateDepartmentRequest([void updates(CreateDepartmentRequestBuilder b)]) = _$CreateDepartmentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateDepartmentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateDepartmentRequest> get serializer => _$CreateDepartmentRequestSerializer();
}

class _$CreateDepartmentRequestSerializer implements PrimitiveSerializer<CreateDepartmentRequest> {
  @override
  final Iterable<Type> types = const [CreateDepartmentRequest, _$CreateDepartmentRequest];

  @override
  final String wireName = r'CreateDepartmentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateDepartmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateDepartmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateDepartmentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  CreateDepartmentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateDepartmentRequestBuilder();
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

