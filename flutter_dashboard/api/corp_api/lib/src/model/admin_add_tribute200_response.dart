//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_add_tribute200_response.g.dart';

/// AdminAddTribute200Response
///
/// Properties:
/// * [msg]
@BuiltValue()
abstract class AdminAddTribute200Response
    implements
        Built<AdminAddTribute200Response, AdminAddTribute200ResponseBuilder> {
  @BuiltValueField(wireName: r'msg')
  String? get msg;

  AdminAddTribute200Response._();

  factory AdminAddTribute200Response(
          [void updates(AdminAddTribute200ResponseBuilder b)]) =
      _$AdminAddTribute200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminAddTribute200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminAddTribute200Response> get serializer =>
      _$AdminAddTribute200ResponseSerializer();
}

class _$AdminAddTribute200ResponseSerializer
    implements PrimitiveSerializer<AdminAddTribute200Response> {
  @override
  final Iterable<Type> types = const [
    AdminAddTribute200Response,
    _$AdminAddTribute200Response
  ];

  @override
  final String wireName = r'AdminAddTribute200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminAddTribute200Response object, {
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
    AdminAddTribute200Response object, {
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
    required AdminAddTribute200ResponseBuilder result,
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
  AdminAddTribute200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminAddTribute200ResponseBuilder();
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
