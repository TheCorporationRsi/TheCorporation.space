import 'package:test/test.dart';
import 'package:corp_api/corp_api.dart';

/// tests for InformationApi
void main() {
  final instance = CorpApi().getInformationApi();

  group(InformationApi, () {
    // List of all corporateer
    //
    // <br/>Returns a list of all the corporateers registered on the website.<br/>
    //
    //Future<BuiltList<GetCorporateers200ResponseInner>> getCorporateers() async
    test('test getCorporateers', () async {
      // TODO
    });
  });
}
