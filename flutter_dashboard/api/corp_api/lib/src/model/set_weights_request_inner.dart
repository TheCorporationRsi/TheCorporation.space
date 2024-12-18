//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_weights_request_inner.g.dart';

/// SetWeightsRequestInner
///
/// Properties:
/// * [amount]
/// * [title]
@BuiltValue()
abstract class SetWeightsRequestInner
    implements Built<SetWeightsRequestInner, SetWeightsRequestInnerBuilder> {
  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'title')
  String? get title;

  SetWeightsRequestInner._();

  factory SetWeightsRequestInner(
          [void updates(SetWeightsRequestInnerBuilder b)]) =
      _$SetWeightsRequestInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetWeightsRequestInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetWeightsRequestInner> get serializer =>
      _$SetWeightsRequestInnerSerializer();
}

class _$SetWeightsRequestInnerSerializer
    implements PrimitiveSerializer<SetWeightsRequestInner> {
  @override
  final Iterable<Type> types = const [
    SetWeightsRequestInner,
    _$SetWeightsRequestInner
  ];

  @override
  final String wireName = r'SetWeightsRequestInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetWeightsRequestInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    SetWeightsRequestInner object, {
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
    required SetWeightsRequestInnerBuilder result,
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
  SetWeightsRequestInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetWeightsRequestInnerBuilder();
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
