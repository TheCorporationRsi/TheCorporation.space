//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_corporateers200_response_inner.g.dart';

/// GetCorporateers200ResponseInner
///
/// Properties:
/// * [rSIHandle]
/// * [rSIMoniker]
/// * [picture]
@BuiltValue()
abstract class GetCorporateers200ResponseInner
    implements
        Built<GetCorporateers200ResponseInner,
            GetCorporateers200ResponseInnerBuilder> {
  @BuiltValueField(wireName: r'RSI_handle')
  String? get rSIHandle;

  @BuiltValueField(wireName: r'RSI_moniker')
  String? get rSIMoniker;

  @BuiltValueField(wireName: r'picture')
  String? get picture;

  GetCorporateers200ResponseInner._();

  factory GetCorporateers200ResponseInner(
          [void updates(GetCorporateers200ResponseInnerBuilder b)]) =
      _$GetCorporateers200ResponseInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetCorporateers200ResponseInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetCorporateers200ResponseInner> get serializer =>
      _$GetCorporateers200ResponseInnerSerializer();
}

class _$GetCorporateers200ResponseInnerSerializer
    implements PrimitiveSerializer<GetCorporateers200ResponseInner> {
  @override
  final Iterable<Type> types = const [
    GetCorporateers200ResponseInner,
    _$GetCorporateers200ResponseInner
  ];

  @override
  final String wireName = r'GetCorporateers200ResponseInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetCorporateers200ResponseInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.rSIHandle != null) {
      yield r'RSI_handle';
      yield serializers.serialize(
        object.rSIHandle,
        specifiedType: const FullType(String),
      );
    }
    if (object.rSIMoniker != null) {
      yield r'RSI_moniker';
      yield serializers.serialize(
        object.rSIMoniker,
        specifiedType: const FullType(String),
      );
    }
    if (object.picture != null) {
      yield r'picture';
      yield serializers.serialize(
        object.picture,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetCorporateers200ResponseInner object, {
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
    required GetCorporateers200ResponseInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'RSI_handle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rSIHandle = valueDes;
          break;
        case r'RSI_moniker':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rSIMoniker = valueDes;
          break;
        case r'picture':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.picture = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetCorporateers200ResponseInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetCorporateers200ResponseInnerBuilder();
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
