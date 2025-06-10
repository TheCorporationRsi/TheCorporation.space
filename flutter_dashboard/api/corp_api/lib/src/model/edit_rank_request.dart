//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'edit_rank_request.g.dart';

/// EditRankRequest
///
/// Properties:
/// * [rankTitle] - The current title of the rank to edit
/// * [requiredLifetimeInfluence] - New required lifetime influence (optional)
/// * [title] - New title for the rank (optional)
/// * [weeklyAmount] - New weekly amount (optional)
@BuiltValue()
abstract class EditRankRequest
    implements Built<EditRankRequest, EditRankRequestBuilder> {
  /// The current title of the rank to edit
  @BuiltValueField(wireName: r'rank_title')
  String get rankTitle;

  /// New required lifetime influence (optional)
  @BuiltValueField(wireName: r'required_lifetime_influence')
  int? get requiredLifetimeInfluence;

  /// New title for the rank (optional)
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// New weekly amount (optional)
  @BuiltValueField(wireName: r'weekly_amount')
  int? get weeklyAmount;

  EditRankRequest._();

  factory EditRankRequest([void updates(EditRankRequestBuilder b)]) =
      _$EditRankRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EditRankRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EditRankRequest> get serializer =>
      _$EditRankRequestSerializer();
}

class _$EditRankRequestSerializer
    implements PrimitiveSerializer<EditRankRequest> {
  @override
  final Iterable<Type> types = const [EditRankRequest, _$EditRankRequest];

  @override
  final String wireName = r'EditRankRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EditRankRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rank_title';
    yield serializers.serialize(
      object.rankTitle,
      specifiedType: const FullType(String),
    );
    if (object.requiredLifetimeInfluence != null) {
      yield r'required_lifetime_influence';
      yield serializers.serialize(
        object.requiredLifetimeInfluence,
        specifiedType: const FullType(int),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.weeklyAmount != null) {
      yield r'weekly_amount';
      yield serializers.serialize(
        object.weeklyAmount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    EditRankRequest object, {
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
    required EditRankRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rank_title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rankTitle = valueDes;
          break;
        case r'required_lifetime_influence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.requiredLifetimeInfluence = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'weekly_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.weeklyAmount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EditRankRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EditRankRequestBuilder();
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
