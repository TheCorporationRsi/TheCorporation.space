//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_rank_request.g.dart';

/// DeleteRankRequest
///
/// Properties:
/// * [rankTitle] - The title of the rank to delete
@BuiltValue()
abstract class DeleteRankRequest
    implements Built<DeleteRankRequest, DeleteRankRequestBuilder> {
  /// The title of the rank to delete
  @BuiltValueField(wireName: r'rank_title')
  String get rankTitle;

  DeleteRankRequest._();

  factory DeleteRankRequest([void updates(DeleteRankRequestBuilder b)]) =
      _$DeleteRankRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteRankRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteRankRequest> get serializer =>
      _$DeleteRankRequestSerializer();
}

class _$DeleteRankRequestSerializer
    implements PrimitiveSerializer<DeleteRankRequest> {
  @override
  final Iterable<Type> types = const [DeleteRankRequest, _$DeleteRankRequest];

  @override
  final String wireName = r'DeleteRankRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteRankRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rank_title';
    yield serializers.serialize(
      object.rankTitle,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DeleteRankRequest object, {
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
    required DeleteRankRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rank_title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rankTitle = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeleteRankRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteRankRequestBuilder();
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
