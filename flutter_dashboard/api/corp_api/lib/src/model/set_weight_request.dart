//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_weight_request.g.dart';

/// SetWeightRequest
///
/// Properties:
/// * [amount]
/// * [divisionTitle]
@BuiltValue()
abstract class SetWeightRequest
    implements Built<SetWeightRequest, SetWeightRequestBuilder> {
  @BuiltValueField(wireName: r'amount')
  int get amount;

  @BuiltValueField(wireName: r'division_title')
  String get divisionTitle;

  SetWeightRequest._();

  factory SetWeightRequest([void updates(SetWeightRequestBuilder b)]) =
      _$SetWeightRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetWeightRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetWeightRequest> get serializer =>
      _$SetWeightRequestSerializer();
}

class _$SetWeightRequestSerializer
    implements PrimitiveSerializer<SetWeightRequest> {
  @override
  final Iterable<Type> types = const [SetWeightRequest, _$SetWeightRequest];

  @override
  final String wireName = r'SetWeightRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetWeightRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(int),
    );
    yield r'division_title';
    yield serializers.serialize(
      object.divisionTitle,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SetWeightRequest object, {
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
    required SetWeightRequestBuilder result,
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
  SetWeightRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetWeightRequestBuilder();
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
