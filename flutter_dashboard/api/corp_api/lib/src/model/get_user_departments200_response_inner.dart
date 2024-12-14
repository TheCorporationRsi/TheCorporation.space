//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_user_departments200_response_inner.g.dart';

/// GetUserDepartments200ResponseInner
///
/// Properties:
/// * [color] 
/// * [motto] 
/// * [title] 
/// * [weight] 
@BuiltValue()
abstract class GetUserDepartments200ResponseInner implements Built<GetUserDepartments200ResponseInner, GetUserDepartments200ResponseInnerBuilder> {
  @BuiltValueField(wireName: r'color')
  String? get color;

  @BuiltValueField(wireName: r'motto')
  String? get motto;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'weight')
  int? get weight;

  GetUserDepartments200ResponseInner._();

  factory GetUserDepartments200ResponseInner([void updates(GetUserDepartments200ResponseInnerBuilder b)]) = _$GetUserDepartments200ResponseInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetUserDepartments200ResponseInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetUserDepartments200ResponseInner> get serializer => _$GetUserDepartments200ResponseInnerSerializer();
}

class _$GetUserDepartments200ResponseInnerSerializer implements PrimitiveSerializer<GetUserDepartments200ResponseInner> {
  @override
  final Iterable<Type> types = const [GetUserDepartments200ResponseInner, _$GetUserDepartments200ResponseInner];

  @override
  final String wireName = r'GetUserDepartments200ResponseInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetUserDepartments200ResponseInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.color != null) {
      yield r'color';
      yield serializers.serialize(
        object.color,
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
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.weight != null) {
      yield r'weight';
      yield serializers.serialize(
        object.weight,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetUserDepartments200ResponseInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetUserDepartments200ResponseInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.color = valueDes;
          break;
        case r'motto':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.motto = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'weight':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.weight = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetUserDepartments200ResponseInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetUserDepartments200ResponseInnerBuilder();
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

