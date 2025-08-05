//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_rank_request.g.dart';

/// CreateRankRequest
///
/// Properties:
/// * [requiredLifetimeInfluence]
/// * [title]
/// * [weeklyAmount]
@BuiltValue()
abstract class CreateRankRequest
    implements Built<CreateRankRequest, CreateRankRequestBuilder> {
  @BuiltValueField(wireName: r'required_lifetime_influence')
  int? get requiredLifetimeInfluence;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'weekly_amount')
  int? get weeklyAmount;

  CreateRankRequest._();

  factory CreateRankRequest([void updates(CreateRankRequestBuilder b)]) =
      _$CreateRankRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateRankRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateRankRequest> get serializer =>
      _$CreateRankRequestSerializer();
}

class _$CreateRankRequestSerializer
    implements PrimitiveSerializer<CreateRankRequest> {
  @override
  final Iterable<Type> types = const [CreateRankRequest, _$CreateRankRequest];

  @override
  final String wireName = r'CreateRankRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateRankRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.requiredLifetimeInfluence != null) {
      yield r'required_lifetime_influence';
      yield serializers.serialize(
        object.requiredLifetimeInfluence,
        specifiedType: const FullType(int),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.weeklyAmount != null) {
      yield r'weekly_amount';
      yield serializers.serialize(
        object.weeklyAmount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateRankRequest object, {
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
    required CreateRankRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'required_lifetime_influence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.requiredLifetimeInfluence = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'weekly_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.weeklyAmount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateRankRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateRankRequestBuilder();
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
