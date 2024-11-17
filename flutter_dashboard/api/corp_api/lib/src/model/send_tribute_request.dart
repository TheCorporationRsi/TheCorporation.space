//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_tribute_request.g.dart';

/// SendTributeRequest
///
/// Properties:
/// * [amount] - Amout of tribute that you wish to send
/// * [message]
/// * [receiverHandle]
@BuiltValue()
abstract class SendTributeRequest
    implements Built<SendTributeRequest, SendTributeRequestBuilder> {
  /// Amout of tribute that you wish to send
  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'receiver_handle')
  String? get receiverHandle;

  SendTributeRequest._();

  factory SendTributeRequest([void updates(SendTributeRequestBuilder b)]) =
      _$SendTributeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendTributeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendTributeRequest> get serializer =>
      _$SendTributeRequestSerializer();
}

class _$SendTributeRequestSerializer
    implements PrimitiveSerializer<SendTributeRequest> {
  @override
  final Iterable<Type> types = const [SendTributeRequest, _$SendTributeRequest];

  @override
  final String wireName = r'SendTributeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendTributeRequest object, {
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
    if (object.receiverHandle != null) {
      yield r'receiver_handle';
      yield serializers.serialize(
        object.receiverHandle,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SendTributeRequest object, {
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
    required SendTributeRequestBuilder result,
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
        case r'receiver_handle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.receiverHandle = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SendTributeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendTributeRequestBuilder();
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
