//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:corp_api/src/date_serializer.dart';
import 'package:corp_api/src/model/date.dart';

import 'package:corp_api/src/model/add_user_role200_response.dart';
import 'package:corp_api/src/model/add_user_role_request.dart';
import 'package:corp_api/src/model/change_password_request.dart';
import 'package:corp_api/src/model/create_department200_response.dart';
import 'package:corp_api/src/model/create_department_request.dart';
import 'package:corp_api/src/model/create_division200_response.dart';
import 'package:corp_api/src/model/create_division_request.dart';
import 'package:corp_api/src/model/create_role201_response.dart';
import 'package:corp_api/src/model/create_role_request.dart';
import 'package:corp_api/src/model/delete_department200_response.dart';
import 'package:corp_api/src/model/delete_department_request.dart';
import 'package:corp_api/src/model/delete_division200_response.dart';
import 'package:corp_api/src/model/delete_division_request.dart';
import 'package:corp_api/src/model/delete_role200_response.dart';
import 'package:corp_api/src/model/edit_role200_response.dart';
import 'package:corp_api/src/model/edit_role_request.dart';
import 'package:corp_api/src/model/get_corporateers200_response_inner.dart';
import 'package:corp_api/src/model/get_current_funding200_response.dart';
import 'package:corp_api/src/model/get_departments200_response_inner.dart';
import 'package:corp_api/src/model/get_divisions200_response_inner.dart';
import 'package:corp_api/src/model/get_profile200_response.dart';
import 'package:corp_api/src/model/get_rsi_token200_response.dart';
import 'package:corp_api/src/model/get_rsi_token401_response.dart';
import 'package:corp_api/src/model/get_ranks200_response_inner.dart';
import 'package:corp_api/src/model/get_roles200_response_inner.dart';
import 'package:corp_api/src/model/get_status200_response.dart';
import 'package:corp_api/src/model/get_tribute_history200_response_inner.dart';
import 'package:corp_api/src/model/get_user200_response.dart';
import 'package:corp_api/src/model/get_user200_response_roles_inner.dart';
import 'package:corp_api/src/model/get_user_departments200_response_inner.dart';
import 'package:corp_api/src/model/get_user_divisions200_response_inner.dart';
import 'package:corp_api/src/model/get_user_profile200_response.dart';
import 'package:corp_api/src/model/get_user_roles200_response_inner.dart';
import 'package:corp_api/src/model/get_users200_response_inner.dart';
import 'package:corp_api/src/model/login200_response.dart';
import 'package:corp_api/src/model/login_request.dart';
import 'package:corp_api/src/model/refresh_token200_response.dart';
import 'package:corp_api/src/model/register200_response.dart';
import 'package:corp_api/src/model/register_request.dart';
import 'package:corp_api/src/model/remove_user_role200_response.dart';
import 'package:corp_api/src/model/send_tribute_request.dart';
import 'package:corp_api/src/model/set_weight_request.dart';
import 'package:corp_api/src/model/update_department200_response.dart';
import 'package:corp_api/src/model/update_department_request.dart';
import 'package:corp_api/src/model/update_division200_response.dart';
import 'package:corp_api/src/model/update_division_request.dart';
import 'package:corp_api/src/model/verify_rsi_token200_response.dart';

part 'serializers.g.dart';

@SerializersFor([
  AddUserRole200Response,
  AddUserRoleRequest,
  ChangePasswordRequest,
  CreateDepartment200Response,
  CreateDepartmentRequest,
  CreateDivision200Response,
  CreateDivisionRequest,
  CreateRole201Response,
  CreateRoleRequest,
  DeleteDepartment200Response,
  DeleteDepartmentRequest,
  DeleteDivision200Response,
  DeleteDivisionRequest,
  DeleteRole200Response,
  EditRole200Response,
  EditRoleRequest,
  GetCorporateers200ResponseInner,
  GetCurrentFunding200Response,
  GetDepartments200ResponseInner,
  GetDivisions200ResponseInner,
  GetProfile200Response,
  GetRSIToken200Response,
  GetRSIToken401Response,
  GetRanks200ResponseInner,
  GetRoles200ResponseInner,
  GetStatus200Response,
  GetTributeHistory200ResponseInner,
  GetUser200Response,
  GetUser200ResponseRolesInner,
  GetUserDepartments200ResponseInner,
  GetUserDivisions200ResponseInner,
  GetUserProfile200Response,
  GetUserRoles200ResponseInner,
  GetUsers200ResponseInner,
  Login200Response,
  LoginRequest,
  RefreshToken200Response,
  Register200Response,
  RegisterRequest,
  RemoveUserRole200Response,
  SendTributeRequest,
  SetWeightRequest,
  UpdateDepartment200Response,
  UpdateDepartmentRequest,
  UpdateDivision200Response,
  UpdateDivisionRequest,
  VerifyRSIToken200Response,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(GetUsers200ResponseInner)]),
        () => ListBuilder<GetUsers200ResponseInner>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(GetDivisions200ResponseInner)]),
        () => ListBuilder<GetDivisions200ResponseInner>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(GetDepartments200ResponseInner)]),
        () => ListBuilder<GetDepartments200ResponseInner>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(GetUserDivisions200ResponseInner)]),
        () => ListBuilder<GetUserDivisions200ResponseInner>(),
      )
      ..addBuilderFactory(
        const FullType(
            BuiltList, [FullType(GetTributeHistory200ResponseInner)]),
        () => ListBuilder<GetTributeHistory200ResponseInner>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(GetUserRoles200ResponseInner)]),
        () => ListBuilder<GetUserRoles200ResponseInner>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(GetCorporateers200ResponseInner)]),
        () => ListBuilder<GetCorporateers200ResponseInner>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(GetRanks200ResponseInner)]),
        () => ListBuilder<GetRanks200ResponseInner>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(GetRoles200ResponseInner)]),
        () => ListBuilder<GetRoles200ResponseInner>(),
      )
      ..addBuilderFactory(
        const FullType(
            BuiltList, [FullType(GetUserDepartments200ResponseInner)]),
        () => ListBuilder<GetUserDepartments200ResponseInner>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
