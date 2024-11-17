//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_division_request.g.dart';

/// CreateDivisionRequest
///
/// Properties:
/// * [title]
@BuiltValue()
abstract class CreateDivisionRequest
    implements Built<CreateDivisionRequest, CreateDivisionRequestBuilder> {
  @BuiltValueField(wireName: r'title')
  String? get title;

  CreateDivisionRequest._();

  factory CreateDivisionRequest(
      [void updates(CreateDivisionRequestBuilder b)]) = _$CreateDivisionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateDivisionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateDivisionRequest> get serializer =>
      _$CreateDivisionRequestSerializer();
}

class _$CreateDivisionRequestSerializer
    implements PrimitiveSerializer<CreateDivisionRequest> {
  @override
  final Iterable<Type> types = const [
    CreateDivisionRequest,
    _$CreateDivisionRequest
  ];

  @override
  final String wireName = r'CreateDivisionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateDivisionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    CreateDivisionRequest object, {
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
    required CreateDivisionRequestBuilder result,
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
  CreateDivisionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateDivisionRequestBuilder();
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
