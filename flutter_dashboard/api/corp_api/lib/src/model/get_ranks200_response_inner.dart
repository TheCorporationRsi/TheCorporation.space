//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_ranks200_response_inner.g.dart';

/// GetRanks200ResponseInner
///
/// Properties:
/// * [requiredLifetimeInfluence]
/// * [title]
/// * [weeklyAmount]
@BuiltValue()
abstract class GetRanks200ResponseInner
    implements
        Built<GetRanks200ResponseInner, GetRanks200ResponseInnerBuilder> {
  @BuiltValueField(wireName: r'required_lifetime_influence')
  int? get requiredLifetimeInfluence;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'weekly_amount')
  int? get weeklyAmount;

  GetRanks200ResponseInner._();

  factory GetRanks200ResponseInner(
          [void updates(GetRanks200ResponseInnerBuilder b)]) =
      _$GetRanks200ResponseInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetRanks200ResponseInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetRanks200ResponseInner> get serializer =>
      _$GetRanks200ResponseInnerSerializer();
}

class _$GetRanks200ResponseInnerSerializer
    implements PrimitiveSerializer<GetRanks200ResponseInner> {
  @override
  final Iterable<Type> types = const [
    GetRanks200ResponseInner,
    _$GetRanks200ResponseInner
  ];

  @override
  final String wireName = r'GetRanks200ResponseInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetRanks200ResponseInner object, {
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
    GetRanks200ResponseInner object, {
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
    required GetRanks200ResponseInnerBuilder result,
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
  GetRanks200ResponseInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetRanks200ResponseInnerBuilder();
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
