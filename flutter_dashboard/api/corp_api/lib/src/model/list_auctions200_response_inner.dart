//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_auctions200_response_inner.g.dart';

/// ListAuctions200ResponseInner
///
/// Properties:
/// * [currentPrice]
/// * [description]
/// * [endTime]
/// * [highestBidder]
/// * [id]
/// * [title]
@BuiltValue()
abstract class ListAuctions200ResponseInner
    implements
        Built<ListAuctions200ResponseInner,
            ListAuctions200ResponseInnerBuilder> {
  @BuiltValueField(wireName: r'current_price')
  num? get currentPrice;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'end_time')
  DateTime? get endTime;

  @BuiltValueField(wireName: r'highest_bidder')
  String? get highestBidder;

  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'title')
  String? get title;

  ListAuctions200ResponseInner._();

  factory ListAuctions200ResponseInner(
          [void updates(ListAuctions200ResponseInnerBuilder b)]) =
      _$ListAuctions200ResponseInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ListAuctions200ResponseInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ListAuctions200ResponseInner> get serializer =>
      _$ListAuctions200ResponseInnerSerializer();
}

class _$ListAuctions200ResponseInnerSerializer
    implements PrimitiveSerializer<ListAuctions200ResponseInner> {
  @override
  final Iterable<Type> types = const [
    ListAuctions200ResponseInner,
    _$ListAuctions200ResponseInner
  ];

  @override
  final String wireName = r'ListAuctions200ResponseInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ListAuctions200ResponseInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.currentPrice != null) {
      yield r'current_price';
      yield serializers.serialize(
        object.currentPrice,
        specifiedType: const FullType(num),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.endTime != null) {
      yield r'end_time';
      yield serializers.serialize(
        object.endTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.highestBidder != null) {
      yield r'highest_bidder';
      yield serializers.serialize(
        object.highestBidder,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
    ListAuctions200ResponseInner object, {
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
    required ListAuctions200ResponseInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'current_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.currentPrice = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'end_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.endTime = valueDes;
          break;
        case r'highest_bidder':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.highestBidder = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
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
  ListAuctions200ResponseInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListAuctions200ResponseInnerBuilder();
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
