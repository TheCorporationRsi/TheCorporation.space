//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'add_user_role200_response.g.dart';

/// AddUserRole200Response
///
/// Properties:
/// * [msg] 
@BuiltValue()
abstract class AddUserRole200Response implements Built<AddUserRole200Response, AddUserRole200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  AddUserRole200Response._();

  factory AddUserRole200Response([void updates(AddUserRole200ResponseBuilder b)]) = _$AddUserRole200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddUserRole200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddUserRole200Response> get serializer => _$AddUserRole200ResponseSerializer();
}

class _$AddUserRole200ResponseSerializer implements PrimitiveSerializer<AddUserRole200Response> {
  @override
  final Iterable<Type> types = const [AddUserRole200Response, _$AddUserRole200Response];

  @override
  final String wireName = r'AddUserRole200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddUserRole200Response object, {
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
    AddUserRole200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AddUserRole200ResponseBuilder result,
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
  AddUserRole200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddUserRole200ResponseBuilder();
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

