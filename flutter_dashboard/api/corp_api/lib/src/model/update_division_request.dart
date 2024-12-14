//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_division_request.g.dart';

/// UpdateDivisionRequest
///
/// Properties:
/// * [divisionTitle]
/// * [logo]
/// * [motto]
/// * [newTitle]
/// * [securityLevel]
@BuiltValue()
abstract class UpdateDivisionRequest
    implements Built<UpdateDivisionRequest, UpdateDivisionRequestBuilder> {
  @BuiltValueField(wireName: r'division_title')
  String get divisionTitle;

  @BuiltValueField(wireName: r'logo')
  String? get logo;

  @BuiltValueField(wireName: r'motto')
  String? get motto;

  @BuiltValueField(wireName: r'new_title')
  String? get newTitle;

  @BuiltValueField(wireName: r'security_level')
  int? get securityLevel;

  UpdateDivisionRequest._();

  factory UpdateDivisionRequest(
      [void updates(UpdateDivisionRequestBuilder b)]) = _$UpdateDivisionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateDivisionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateDivisionRequest> get serializer =>
      _$UpdateDivisionRequestSerializer();
}

class _$UpdateDivisionRequestSerializer
    implements PrimitiveSerializer<UpdateDivisionRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateDivisionRequest,
    _$UpdateDivisionRequest
  ];

  @override
  final String wireName = r'UpdateDivisionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateDivisionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'division_title';
    yield serializers.serialize(
      object.divisionTitle,
      specifiedType: const FullType(String),
    );
    if (object.logo != null) {
      yield r'logo';
      yield serializers.serialize(
        object.logo,
        specifiedType: const FullType(String),
      );
    }
    if (object.motto != null) {
      yield r'motto';
      yield serializers.serialize(
        object.motto,
        specifiedType: const FullType(String),
      );
    }
    if (object.newTitle != null) {
      yield r'new_title';
      yield serializers.serialize(
        object.newTitle,
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
    UpdateDivisionRequest object, {
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
    required UpdateDivisionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'division_title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.divisionTitle = valueDes;
          break;
        case r'logo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.logo = valueDes;
          break;
        case r'motto':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.motto = valueDes;
          break;
        case r'new_title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newTitle = valueDes;
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
  UpdateDivisionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateDivisionRequestBuilder();
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
