//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_department200_response.g.dart';

/// DeleteDepartment200Response
///
/// Properties:
/// * [msg] 
@BuiltValue()
abstract class DeleteDepartment200Response implements Built<DeleteDepartment200Response, DeleteDepartment200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  DeleteDepartment200Response._();

  factory DeleteDepartment200Response([void updates(DeleteDepartment200ResponseBuilder b)]) = _$DeleteDepartment200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteDepartment200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteDepartment200Response> get serializer => _$DeleteDepartment200ResponseSerializer();
}

class _$DeleteDepartment200ResponseSerializer implements PrimitiveSerializer<DeleteDepartment200Response> {
  @override
  final Iterable<Type> types = const [DeleteDepartment200Response, _$DeleteDepartment200Response];

  @override
  final String wireName = r'DeleteDepartment200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteDepartment200Response object, {
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
    DeleteDepartment200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeleteDepartment200ResponseBuilder result,
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
  DeleteDepartment200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteDepartment200ResponseBuilder();
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

