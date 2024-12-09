import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:built_collection/built_collection.dart';



BuiltList<GetCorporateers200ResponseInner> corporateers =
    BuiltList<GetCorporateers200ResponseInner>();


final corpInformationClient = corpApi.getInformationApi();

Future<void> update() async {
  await updateCorporateers();
}

Future<void> updateCorporateers() async {
  try {
    final response = await corpInformationClient.getCorporateers();
    if (response.data != null) {
      corporateers = response.data ?? corporateers;
    }
  } catch (error) {
    print(error);
  }
}
