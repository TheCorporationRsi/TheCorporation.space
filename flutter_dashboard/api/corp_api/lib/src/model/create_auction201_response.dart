//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_auction201_response.g.dart';

/// CreateAuction201Response
///
/// Properties:
/// * [currentPrice]
/// * [description]
/// * [endTime]
/// * [highestBidder]
/// * [id]
/// * [title]
@BuiltValue()
abstract class CreateAuction201Response
    implements
        Built<CreateAuction201Response, CreateAuction201ResponseBuilder> {
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

  CreateAuction201Response._();

  factory CreateAuction201Response(
          [void updates(CreateAuction201ResponseBuilder b)]) =
      _$CreateAuction201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateAuction201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateAuction201Response> get serializer =>
      _$CreateAuction201ResponseSerializer();
}

class _$CreateAuction201ResponseSerializer
    implements PrimitiveSerializer<CreateAuction201Response> {
  @override
  final Iterable<Type> types = const [
    CreateAuction201Response,
    _$CreateAuction201Response
  ];

  @override
  final String wireName = r'CreateAuction201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateAuction201Response object, {
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
    CreateAuction201Response object, {
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
    required CreateAuction201ResponseBuilder result,
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
  CreateAuction201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateAuction201ResponseBuilder();
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
