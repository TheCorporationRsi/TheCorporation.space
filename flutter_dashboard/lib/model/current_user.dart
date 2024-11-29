import 'package:flutter_dashboard/main.dart';

String rsiHandle = "loading";
String rsiMoniker = "loading";
String profilePicture = "https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250";

final corpStructureClient = corpApi.getStructureApi();

Future<void> update() async {
  final headers = await getAuthHeader();
  try {
    final response = await corpStructureClient.getUserProfile(headers: headers);
    
    if (response.data != null) {
      rsiHandle = response.data!.rSIHandle ?? rsiHandle;
      rsiMoniker = response.data!.moniker ?? rsiMoniker;
      profilePicture = response.data!.picture ?? profilePicture;
    }

  } catch (error) {
    print(error);
  }
}