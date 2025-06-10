//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'place_bet_request.g.dart';

/// PlaceBetRequest
///
/// Properties:
/// * [amount]
/// * [auctionId]
@BuiltValue()
abstract class PlaceBetRequest
    implements Built<PlaceBetRequest, PlaceBetRequestBuilder> {
  @BuiltValueField(wireName: r'amount')
  int get amount;

  @BuiltValueField(wireName: r'auction_id')
  String get auctionId;

  PlaceBetRequest._();

  factory PlaceBetRequest([void updates(PlaceBetRequestBuilder b)]) =
      _$PlaceBetRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PlaceBetRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PlaceBetRequest> get serializer =>
      _$PlaceBetRequestSerializer();
}

class _$PlaceBetRequestSerializer
    implements PrimitiveSerializer<PlaceBetRequest> {
  @override
  final Iterable<Type> types = const [PlaceBetRequest, _$PlaceBetRequest];

  @override
  final String wireName = r'PlaceBetRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PlaceBetRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(int),
    );
    yield r'auction_id';
    yield serializers.serialize(
      object.auctionId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PlaceBetRequest object, {
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
    required PlaceBetRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.amount = valueDes;
          break;
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
  PlaceBetRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PlaceBetRequestBuilder();
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
