import 'package:test/test.dart';
import 'package:corp_api/corp_api.dart';

/// tests for InfluenceSystemApi
void main() {
  final instance = CorpApi().getInfluenceSystemApi();

  group(InfluenceSystemApi, () {
    // Get current influence
    //
    // <br/>This is using docstrings for specifications.<br/>
    //
    //Future getInfluence(String influenceType, String type, String title) async
    test('test getInfluence', () async {
      // TODO
    });

    // Get influence system profile
    //
    // <br/>This is using docstrings for specifications.<br/>
    //
    //Future getProfile() async
    test('test getProfile', () async {
      // TODO
    });

    // List of all influence system ranks
    //
    // <br/>This is using docstrings for specifications.<br/>
    //
    //Future<GetRanks200Response> getRanks() async
    test('test getRanks', () async {
      // TODO
    });

    // Get tribute sent history
    //
    // <br/>This is using docstrings for specifications.<br/>
    //
    //Future getTributeHistory(String type, String request, int page) async
    test('test getTributeHistory', () async {
      // TODO
    });

    // Endpoint to send tribute to another corporateer
    //
    // <br/>This is using docstrings for specifications.<br/>
    //
    //Future<GetRanks200Response> sendTribute({ SendTributeRequest sendTributeRequest }) async
    test('test sendTribute', () async {
      // TODO
    });
  });
}
