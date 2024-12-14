//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_division_request.g.dart';

/// DeleteDivisionRequest
///
/// Properties:
/// * [divisionTitle] 
@BuiltValue()
abstract class DeleteDivisionRequest implements Built<DeleteDivisionRequest, DeleteDivisionRequestBuilder> {
  @BuiltValueField(wireName: r'division_title')
  String get divisionTitle;

  DeleteDivisionRequest._();

  factory DeleteDivisionRequest([void updates(DeleteDivisionRequestBuilder b)]) = _$DeleteDivisionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteDivisionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteDivisionRequest> get serializer => _$DeleteDivisionRequestSerializer();
}

class _$DeleteDivisionRequestSerializer implements PrimitiveSerializer<DeleteDivisionRequest> {
  @override
  final Iterable<Type> types = const [DeleteDivisionRequest, _$DeleteDivisionRequest];

  @override
  final String wireName = r'DeleteDivisionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteDivisionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'division_title';
    yield serializers.serialize(
      object.divisionTitle,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DeleteDivisionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeleteDivisionRequestBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeleteDivisionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteDivisionRequestBuilder();
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

