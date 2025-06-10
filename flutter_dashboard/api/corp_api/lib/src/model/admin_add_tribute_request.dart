//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_add_tribute_request.g.dart';

/// AdminAddTributeRequest
///
/// Properties:
/// * [amount]
/// * [rsiHandle]
@BuiltValue()
abstract class AdminAddTributeRequest
    implements Built<AdminAddTributeRequest, AdminAddTributeRequestBuilder> {
  @BuiltValueField(wireName: r'amount')
  int? get amount;

  @BuiltValueField(wireName: r'rsi_handle')
  String? get rsiHandle;

  AdminAddTributeRequest._();

  factory AdminAddTributeRequest(
          [void updates(AdminAddTributeRequestBuilder b)]) =
      _$AdminAddTributeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminAddTributeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminAddTributeRequest> get serializer =>
      _$AdminAddTributeRequestSerializer();
}

class _$AdminAddTributeRequestSerializer
    implements PrimitiveSerializer<AdminAddTributeRequest> {
  @override
  final Iterable<Type> types = const [
    AdminAddTributeRequest,
    _$AdminAddTributeRequest
  ];

  @override
  final String wireName = r'AdminAddTributeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminAddTributeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(int),
      );
    }
    if (object.rsiHandle != null) {
      yield r'rsi_handle';
      yield serializers.serialize(
        object.rsiHandle,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminAddTributeRequest object, {
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
    required AdminAddTributeRequestBuilder result,
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
        case r'rsi_handle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rsiHandle = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminAddTributeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminAddTributeRequestBuilder();
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
