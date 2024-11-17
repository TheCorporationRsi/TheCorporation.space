import 'package:test/test.dart';
import 'package:corp_api/corp_api.dart';

/// tests for StructureApi
void main() {
  final instance = CorpApi().getStructureApi();

  group(StructureApi, () {
    // List of all your roles
    //
    // <br/>This is using docstrings for specifications.<br/>
    //
    //Future<ApiV0StructureProfileRolesGet200Response> apiV0StructureProfileRolesGet() async
    test('test apiV0StructureProfileRolesGet', () async {
      // TODO
    });

    // List of all departments
    //
    // <br/>This is using docstrings for specifications.<br/>
    //
    //Future<GetDepartments200Response> getDepartments() async
    test('test getDepartments', () async {
      // TODO
    });

    // List of all divisions
    //
    // <br/>This is using docstrings for specifications.<br/>
    //
    //Future<BuiltList<GetDivisions200ResponseInner>> getDivisions() async
    test('test getDivisions', () async {
      // TODO
    });

    // List of all your departments
    //
    // <br/>This is using docstrings for specifications.<br/>
    //
    //Future<CreateDepartmentRequest> getUserDepartments() async
    test('test getUserDepartments', () async {
      // TODO
    });

    // List of all your division
    //
    // <br/>This is using docstrings for specifications.<br/>
    //
    //Future<CreateDivisionRequest> getUserDivisions() async
    test('test getUserDivisions', () async {
      // TODO
    });
  });
}
