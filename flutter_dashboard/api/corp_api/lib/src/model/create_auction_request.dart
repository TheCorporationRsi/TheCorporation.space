//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_auction_request.g.dart';

/// CreateAuctionRequest
///
/// Properties:
/// * [department]
/// * [description]
/// * [division]
/// * [endTime]
/// * [startingBid]
/// * [title]
@BuiltValue()
abstract class CreateAuctionRequest
    implements Built<CreateAuctionRequest, CreateAuctionRequestBuilder> {
  @BuiltValueField(wireName: r'department')
  String get department;

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'division')
  String get division;

  @BuiltValueField(wireName: r'end_time')
  DateTime get endTime;

  @BuiltValueField(wireName: r'starting_bid')
  num get startingBid;

  @BuiltValueField(wireName: r'title')
  String get title;

  CreateAuctionRequest._();

  factory CreateAuctionRequest([void updates(CreateAuctionRequestBuilder b)]) =
      _$CreateAuctionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateAuctionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateAuctionRequest> get serializer =>
      _$CreateAuctionRequestSerializer();
}

class _$CreateAuctionRequestSerializer
    implements PrimitiveSerializer<CreateAuctionRequest> {
  @override
  final Iterable<Type> types = const [
    CreateAuctionRequest,
    _$CreateAuctionRequest
  ];

  @override
  final String wireName = r'CreateAuctionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateAuctionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'department';
    yield serializers.serialize(
      object.department,
      specifiedType: const FullType(String),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
    yield r'division';
    yield serializers.serialize(
      object.division,
      specifiedType: const FullType(String),
    );
    yield r'end_time';
    yield serializers.serialize(
      object.endTime,
      specifiedType: const FullType(DateTime),
    );
    yield r'starting_bid';
    yield serializers.serialize(
      object.startingBid,
      specifiedType: const FullType(num),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateAuctionRequest object, {
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
    required CreateAuctionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'department':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.department = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'division':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.division = valueDes;
          break;
        case r'end_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.endTime = valueDes;
          break;
        case r'starting_bid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.startingBid = valueDes;
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
  CreateAuctionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateAuctionRequestBuilder();
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
