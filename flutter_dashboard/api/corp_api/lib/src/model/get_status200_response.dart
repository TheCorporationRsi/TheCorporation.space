//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_status200_response.g.dart';

/// GetStatus200Response
///
/// Properties:
/// * [cORPMember]
/// * [rSIVerified]
/// * [authentificated]
/// * [isAdmin]
/// * [isManager]
@BuiltValue()
abstract class GetStatus200Response
    implements Built<GetStatus200Response, GetStatus200ResponseBuilder> {
  @BuiltValueField(wireName: r'CORP_member')
  bool? get cORPMember;

  @BuiltValueField(wireName: r'RSI_verified')
  bool? get rSIVerified;

  @BuiltValueField(wireName: r'authentificated')
  bool? get authentificated;

  @BuiltValueField(wireName: r'is_admin')
  bool? get isAdmin;

  @BuiltValueField(wireName: r'is_manager')
  bool? get isManager;

  GetStatus200Response._();

  factory GetStatus200Response([void updates(GetStatus200ResponseBuilder b)]) =
      _$GetStatus200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetStatus200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetStatus200Response> get serializer =>
      _$GetStatus200ResponseSerializer();
}

class _$GetStatus200ResponseSerializer
    implements PrimitiveSerializer<GetStatus200Response> {
  @override
  final Iterable<Type> types = const [
    GetStatus200Response,
    _$GetStatus200Response
  ];

  @override
  final String wireName = r'GetStatus200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetStatus200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.cORPMember != null) {
      yield r'CORP_member';
      yield serializers.serialize(
        object.cORPMember,
        specifiedType: const FullType(bool),
      );
    }
    if (object.rSIVerified != null) {
      yield r'RSI_verified';
      yield serializers.serialize(
        object.rSIVerified,
        specifiedType: const FullType(bool),
      );
    }
    if (object.authentificated != null) {
      yield r'authentificated';
      yield serializers.serialize(
        object.authentificated,
        specifiedType: const FullType(bool),
      );
    }
    if (object.isAdmin != null) {
      yield r'is_admin';
      yield serializers.serialize(
        object.isAdmin,
        specifiedType: const FullType(bool),
      );
    }
    if (object.isManager != null) {
      yield r'is_manager';
      yield serializers.serialize(
        object.isManager,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetStatus200Response object, {
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
    required GetStatus200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'CORP_member':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.cORPMember = valueDes;
          break;
        case r'RSI_verified':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.rSIVerified = valueDes;
          break;
        case r'authentificated':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.authentificated = valueDes;
          break;
        case r'is_admin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isAdmin = valueDes;
          break;
        case r'is_manager':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isManager = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetStatus200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetStatus200ResponseBuilder();
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
