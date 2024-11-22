import 'package:test/test.dart';
import 'package:corp_api/corp_api.dart';

/// tests for InfluenceSystemApi
void main() {
  final instance = CorpApi().getInfluenceSystemApi();

  group(InfluenceSystemApi, () {
    // Get current influence
    //
    // <br/>This endpoint provide the current amount of specified influence<br/>
    //
    //Future<String> getInfluence(String influenceType, String type, String title) async
    test('test getInfluence', () async {
      // TODO
    });

    // Get influence system profile
    //
    // <br/>This endpoint provide profile information about the user that is currently connected<br/>
    //
    //Future<GetProfile200Response> getProfile() async
    test('test getProfile', () async {
      // TODO
    });

    // List of all influence system ranks
    //
    // <br/>Returns a list of all the ranks of the influence system<br/>
    //
    //Future<BuiltList<GetRanks200ResponseInner>> getRanks() async
    test('test getRanks', () async {
      // TODO
    });

    // Get tribute transaction history
    //
    // <br/>This endpoint provide the tribute submission history<br/>
    //
    //Future<BuiltList<GetTributeHistory200ResponseInner>> getTributeHistory(String type, String request, String page) async
    test('test getTributeHistory', () async {
      // TODO
    });

    // Endpoint to send tribute to another corporateer
    //
    // <br/>This is the main endpoint to effectuate tribute transfer to another corporateer<br/>
    //
    //Future<GetRanks200ResponseInner> sendTribute({ SendTributeRequest sendTributeRequest }) async
    test('test sendTribute', () async {
      // TODO
    });

    // Division weight assignment
    //
    // <br/>This endpoint goal is to set the weight of the member's divisions <br/>
    //
    //Future setWeight({ SetWeightRequest setWeightRequest }) async
    test('test setWeight', () async {
      // TODO
    });
  });
}
