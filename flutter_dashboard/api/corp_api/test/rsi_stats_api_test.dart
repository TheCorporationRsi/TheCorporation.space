import 'package:test/test.dart';
import 'package:corp_api/corp_api.dart';

/// tests for RSIStatsApi
void main() {
  final instance = CorpApi().getRSIStatsApi();

  group(RSIStatsApi, () {
    // List of all influence system ranks
    //
    // <br/>This is using docstrings for specifications.<br/>
    //
    //Future<GetCurrentFunding200Response> getCurrentFunding() async
    test('test getCurrentFunding', () async {
      // TODO
    });
  });
}
