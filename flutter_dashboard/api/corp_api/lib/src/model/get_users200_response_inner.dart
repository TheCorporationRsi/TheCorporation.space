//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_users200_response_inner.g.dart';

/// GetUsers200ResponseInner
///
/// Properties:
/// * [cORPConfirmed]
/// * [rSIConfirmed]
/// * [rSIHandle]
/// * [disabled]
/// * [picture]
/// * [securityLevel]
@BuiltValue()
abstract class GetUsers200ResponseInner
    implements
        Built<GetUsers200ResponseInner, GetUsers200ResponseInnerBuilder> {
  @BuiltValueField(wireName: r'CORP_confirmed')
  bool? get cORPConfirmed;

  @BuiltValueField(wireName: r'RSI_confirmed')
  bool? get rSIConfirmed;

  @BuiltValueField(wireName: r'RSI_handle')
  String? get rSIHandle;

  @BuiltValueField(wireName: r'disabled')
  bool? get disabled;

  @BuiltValueField(wireName: r'picture')
  String? get picture;

  @BuiltValueField(wireName: r'security_level')
  int? get securityLevel;

  GetUsers200ResponseInner._();

  factory GetUsers200ResponseInner(
          [void updates(GetUsers200ResponseInnerBuilder b)]) =
      _$GetUsers200ResponseInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetUsers200ResponseInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetUsers200ResponseInner> get serializer =>
      _$GetUsers200ResponseInnerSerializer();
}

class _$GetUsers200ResponseInnerSerializer
    implements PrimitiveSerializer<GetUsers200ResponseInner> {
  @override
  final Iterable<Type> types = const [
    GetUsers200ResponseInner,
    _$GetUsers200ResponseInner
  ];

  @override
  final String wireName = r'GetUsers200ResponseInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetUsers200ResponseInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.cORPConfirmed != null) {
      yield r'CORP_confirmed';
      yield serializers.serialize(
        object.cORPConfirmed,
        specifiedType: const FullType(bool),
      );
    }
    if (object.rSIConfirmed != null) {
      yield r'RSI_confirmed';
      yield serializers.serialize(
        object.rSIConfirmed,
        specifiedType: const FullType(bool),
      );
    }
    if (object.rSIHandle != null) {
      yield r'RSI_handle';
      yield serializers.serialize(
        object.rSIHandle,
        specifiedType: const FullType(String),
      );
    }
    if (object.disabled != null) {
      yield r'disabled';
      yield serializers.serialize(
        object.disabled,
        specifiedType: const FullType(bool),
      );
    }
    if (object.picture != null) {
      yield r'picture';
      yield serializers.serialize(
        object.picture,
        specifiedType: const FullType(String),
      );
    }
    if (object.securityLevel != null) {
      yield r'security_level';
      yield serializers.serialize(
        object.securityLevel,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetUsers200ResponseInner object, {
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
    required GetUsers200ResponseInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'CORP_confirmed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.cORPConfirmed = valueDes;
          break;
        case r'RSI_confirmed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.rSIConfirmed = valueDes;
          break;
        case r'RSI_handle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rSIHandle = valueDes;
          break;
        case r'disabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.disabled = valueDes;
          break;
        case r'picture':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.picture = valueDes;
          break;
        case r'security_level':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.securityLevel = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetUsers200ResponseInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetUsers200ResponseInnerBuilder();
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
