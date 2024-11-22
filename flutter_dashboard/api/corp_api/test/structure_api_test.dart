import 'package:test/test.dart';
import 'package:corp_api/corp_api.dart';

/// tests for StructureApi
void main() {
  final instance = CorpApi().getStructureApi();

  group(StructureApi, () {
    // List of all your roles
    //
    // <br/>Returns a list of all the current user's roles<br/>
    //
    //Future<ApiV0StructureProfileRolesGet200Response> apiV0StructureProfileRolesGet() async
    test('test apiV0StructureProfileRolesGet', () async {
      // TODO
    });

    // List of all departments
    //
    // <br/>Returns a list of all the departments in the system<br/>
    //
    //Future<GetDepartments200Response> getDepartments() async
    test('test getDepartments', () async {
      // TODO
    });

    // List of all divisions
    //
    // <br/>Returns a list of all the divisions in the system<br/>
    //
    //Future<BuiltList<GetDivisions200ResponseInner>> getDivisions() async
    test('test getDivisions', () async {
      // TODO
    });

    // List of all your departments
    //
    // <br/>Returns a list of the current user's departments<br/>
    //
    //Future<GetUserDepartments200Response> getUserDepartments() async
    test('test getUserDepartments', () async {
      // TODO
    });

    // List of all your division
    //
    // <br/>Return a list of the current user's division<br/>
    //
    //Future<GetUserDivisions200Response> getUserDivisions() async
    test('test getUserDivisions', () async {
      // TODO
    });
  });
}
