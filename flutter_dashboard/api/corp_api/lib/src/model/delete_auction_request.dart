//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_auction_request.g.dart';

/// DeleteAuctionRequest
///
/// Properties:
/// * [auctionId]
@BuiltValue()
abstract class DeleteAuctionRequest
    implements Built<DeleteAuctionRequest, DeleteAuctionRequestBuilder> {
  @BuiltValueField(wireName: r'auction_id')
  String get auctionId;

  DeleteAuctionRequest._();

  factory DeleteAuctionRequest([void updates(DeleteAuctionRequestBuilder b)]) =
      _$DeleteAuctionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteAuctionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteAuctionRequest> get serializer =>
      _$DeleteAuctionRequestSerializer();
}

class _$DeleteAuctionRequestSerializer
    implements PrimitiveSerializer<DeleteAuctionRequest> {
  @override
  final Iterable<Type> types = const [
    DeleteAuctionRequest,
    _$DeleteAuctionRequest
  ];

  @override
  final String wireName = r'DeleteAuctionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteAuctionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'auction_id';
    yield serializers.serialize(
      object.auctionId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DeleteAuctionRequest object, {
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
    required DeleteAuctionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'auction_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.auctionId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeleteAuctionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteAuctionRequestBuilder();
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
