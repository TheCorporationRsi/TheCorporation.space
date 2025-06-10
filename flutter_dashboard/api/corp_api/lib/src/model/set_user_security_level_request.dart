//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_user_security_level_request.g.dart';

/// SetUserSecurityLevelRequest
///
/// Properties:
/// * [securityLevel]
/// * [username]
@BuiltValue()
abstract class SetUserSecurityLevelRequest
    implements
        Built<SetUserSecurityLevelRequest, SetUserSecurityLevelRequestBuilder> {
  @BuiltValueField(wireName: r'security_level')
  int? get securityLevel;

  @BuiltValueField(wireName: r'username')
  String? get username;

  SetUserSecurityLevelRequest._();

  factory SetUserSecurityLevelRequest(
          [void updates(SetUserSecurityLevelRequestBuilder b)]) =
      _$SetUserSecurityLevelRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetUserSecurityLevelRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetUserSecurityLevelRequest> get serializer =>
      _$SetUserSecurityLevelRequestSerializer();
}

class _$SetUserSecurityLevelRequestSerializer
    implements PrimitiveSerializer<SetUserSecurityLevelRequest> {
  @override
  final Iterable<Type> types = const [
    SetUserSecurityLevelRequest,
    _$SetUserSecurityLevelRequest
  ];

  @override
  final String wireName = r'SetUserSecurityLevelRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetUserSecurityLevelRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.securityLevel != null) {
      yield r'security_level';
      yield serializers.serialize(
        object.securityLevel,
        specifiedType: const FullType(int),
      );
    }
    if (object.username != null) {
      yield r'username';
      yield serializers.serialize(
        object.username,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SetUserSecurityLevelRequest object, {
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
    required SetUserSecurityLevelRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'security_level':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.securityLevel = valueDes;
          break;
        case r'username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.username = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SetUserSecurityLevelRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetUserSecurityLevelRequestBuilder();
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
