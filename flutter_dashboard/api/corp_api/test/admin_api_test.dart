import 'package:test/test.dart';
import 'package:corp_api/corp_api.dart';

/// tests for AdminApi
void main() {
  final instance = CorpApi().getAdminApi();

  group(AdminApi, () {
    // Department creation endpoint
    //
    // <br/>This endpoint allow the creation of a new department<br/>
    //
    //Future<CreateDepartment200Response> createDepartment({ CreateDepartmentRequest createDepartmentRequest }) async
    test('test createDepartment', () async {
      // TODO
    });

    // Division creation endpoint
    //
    // <br/>This is the admin endpoint to create new divisions<br/>
    //
    //Future<CreateDivision200Response> createDivision({ CreateDivisionRequest createDivisionRequest }) async
    test('test createDivision', () async {
      // TODO
    });
  });
}
