//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_tribute_history200_response_inner.g.dart';

/// GetTributeHistory200ResponseInner
///
/// Properties:
/// * [amount] 
/// * [message] 
/// * [method] 
/// * [receiver] 
@BuiltValue()
abstract class GetTributeHistory200ResponseInner implements Built<GetTributeHistory200ResponseInner, GetTributeHistory200ResponseInnerBuilder> {
  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'method')
  String? get method;

  @BuiltValueField(wireName: r'receiver')
  String? get receiver;

  GetTributeHistory200ResponseInner._();

  factory GetTributeHistory200ResponseInner([void updates(GetTributeHistory200ResponseInnerBuilder b)]) = _$GetTributeHistory200ResponseInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetTributeHistory200ResponseInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetTributeHistory200ResponseInner> get serializer => _$GetTributeHistory200ResponseInnerSerializer();
}

class _$GetTributeHistory200ResponseInnerSerializer implements PrimitiveSerializer<GetTributeHistory200ResponseInner> {
  @override
  final Iterable<Type> types = const [GetTributeHistory200ResponseInner, _$GetTributeHistory200ResponseInner];

  @override
  final String wireName = r'GetTributeHistory200ResponseInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetTributeHistory200ResponseInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(int),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
    if (object.method != null) {
      yield r'method';
      yield serializers.serialize(
        object.method,
        specifiedType: const FullType(String),
      );
    }
    if (object.receiver != null) {
      yield r'receiver';
      yield serializers.serialize(
        object.receiver,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetTributeHistory200ResponseInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetTributeHistory200ResponseInnerBuilder result,
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
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.method = valueDes;
          break;
        case r'receiver':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.receiver = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetTributeHistory200ResponseInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetTributeHistory200ResponseInnerBuilder();
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

