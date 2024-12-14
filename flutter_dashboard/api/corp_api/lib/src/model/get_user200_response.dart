//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:corp_api/src/model/get_user200_response_roles_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_user200_response.g.dart';

/// GetUser200Response
///
/// Properties:
/// * [cORPConfirmed] 
/// * [rSIConfirmed] 
/// * [rSIHandle] 
/// * [rSIVerificationToken] 
/// * [disabled] 
/// * [enabled2fa] 
/// * [picture] 
/// * [roles] 
/// * [securityLevel] 
@BuiltValue()
abstract class GetUser200Response implements Built<GetUser200Response, GetUser200ResponseBuilder> {
  @BuiltValueField(wireName: r'CORP_confirmed')
  bool? get cORPConfirmed;

  @BuiltValueField(wireName: r'RSI_confirmed')
  bool? get rSIConfirmed;

  @BuiltValueField(wireName: r'RSI_handle')
  String? get rSIHandle;

  @BuiltValueField(wireName: r'RSI_verification_token')
  String? get rSIVerificationToken;

  @BuiltValueField(wireName: r'disabled')
  bool? get disabled;

  @BuiltValueField(wireName: r'enabled_2fa')
  bool? get enabled2fa;

  @BuiltValueField(wireName: r'picture')
  String? get picture;

  @BuiltValueField(wireName: r'roles')
  BuiltList<GetUser200ResponseRolesInner>? get roles;

  @BuiltValueField(wireName: r'security_level')
  int? get securityLevel;

  GetUser200Response._();

  factory GetUser200Response([void updates(GetUser200ResponseBuilder b)]) = _$GetUser200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetUser200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetUser200Response> get serializer => _$GetUser200ResponseSerializer();
}

class _$GetUser200ResponseSerializer implements PrimitiveSerializer<GetUser200Response> {
  @override
  final Iterable<Type> types = const [GetUser200Response, _$GetUser200Response];

  @override
  final String wireName = r'GetUser200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetUser200Response object, {
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
    if (object.rSIVerificationToken != null) {
      yield r'RSI_verification_token';
      yield serializers.serialize(
        object.rSIVerificationToken,
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
    if (object.enabled2fa != null) {
      yield r'enabled_2fa';
      yield serializers.serialize(
        object.enabled2fa,
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
    if (object.roles != null) {
      yield r'roles';
      yield serializers.serialize(
        object.roles,
        specifiedType: const FullType(BuiltList, [FullType(GetUser200ResponseRolesInner)]),
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
    GetUser200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetUser200ResponseBuilder result,
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
        case r'RSI_verification_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rSIVerificationToken = valueDes;
          break;
        case r'disabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.disabled = valueDes;
          break;
        case r'enabled_2fa':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enabled2fa = valueDes;
          break;
        case r'picture':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.picture = valueDes;
          break;
        case r'roles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(GetUser200ResponseRolesInner)]),
          ) as BuiltList<GetUser200ResponseRolesInner>;
          result.roles.replace(valueDes);
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
  GetUser200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetUser200ResponseBuilder();
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

