//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_department200_response.g.dart';

/// UpdateDepartment200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class UpdateDepartment200Response
    implements
        Built<UpdateDepartment200Response, UpdateDepartment200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  UpdateDepartment200Response._();

  factory UpdateDepartment200Response(
          [void updates(UpdateDepartment200ResponseBuilder b)]) =
      _$UpdateDepartment200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateDepartment200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateDepartment200Response> get serializer =>
      _$UpdateDepartment200ResponseSerializer();
}

class _$UpdateDepartment200ResponseSerializer
    implements PrimitiveSerializer<UpdateDepartment200Response> {
  @override
  final Iterable<Type> types = const [
    UpdateDepartment200Response,
    _$UpdateDepartment200Response
  ];

  @override
  final String wireName = r'UpdateDepartment200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateDepartment200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.msg != null) {
      yield r'msg';
      yield serializers.serialize(
        object.msg,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateDepartment200Response object, {
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
    required UpdateDepartment200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'msg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.msg = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateDepartment200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateDepartment200ResponseBuilder();
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
