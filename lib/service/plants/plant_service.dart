import 'dart:convert';
import 'package:thence/constant/constants.dart';
import 'package:thence/helper/http_helper.dart';
import 'package:thence/models/plants/plant.dart';
import 'package:thence/models/response/response.dart';

class PlantService {
  static Future<Response<List<Plant>?>?> getAllPlants() async {
    try {
      var res = await HttpHelper.instance.get(Uri.parse(Constants.allPlants));
      if (res.statusCode == 200) {
        var jsonResponse = json.decode(res.body) as Map<String, dynamic>;

        return Response.fromJson(jsonResponse,
            (data) => List.from(data.map((each) => Plant.fromJson(each))));
      } else {
        return Response<List<Plant>?>(
            error: 'Failed to load plants: ${res.statusCode}');
      }
    } catch (e) {
      return Response<List<Plant>?>(error: 'Failed to load plants');
    }
  }
}
