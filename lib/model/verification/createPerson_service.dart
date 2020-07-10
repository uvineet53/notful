import 'package:http/http.dart' as http;
import 'package:notful/model/verification/addFacetoPerson.dart';
import 'package:notful/model/verification/createPerson_model.dart';
import 'dart:convert';

import 'package:notful/model/verification/identification.dart';

Future<CreatePerson> createPerson(String url, {dynamic body}) async {
  return http
      .post(url,
          headers: {
            "x-rapidapi-host": "luxand-cloud-face-recognition.p.rapidapi.com",
            "x-rapidapi-key":
                "39087e078fmshc7c370449d8cf9cp17967djsn12c460010a52",
            "content-type": "application/x-www-form-urlencoded"
          },
          body: body)
      .then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 && statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    print((json.decode(response.body)["id"]));
    return CreatePerson.fromJson(json.decode(response.body));
  });
}

Future<AddFacetoPerson> addFace(int id, {dynamic body}) async {
  return http
      .post("https://luxand-cloud-face-recognition.p.rapidapi.com/subject/$id",
          headers: {
            "x-rapidapi-host": "luxand-cloud-face-recognition.p.rapidapi.com",
            "x-rapidapi-key":
                "39087e078fmshc7c370449d8cf9cp17967djsn12c460010a52",
            "content-type": "application/x-www-form-urlencoded"
          },
          body: body)
      .then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 && statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    print(response.body);
    print((json.decode(response.body)["message"]));
    return AddFacetoPerson.fromJson(json.decode(response.body));
  });
}

Future<List<Identification>> verify({dynamic body}) async {
  return http
      .post("https://luxand-cloud-face-recognition.p.rapidapi.com/photo/search",
          headers: {
            "x-rapidapi-host": "luxand-cloud-face-recognition.p.rapidapi.com",
            "x-rapidapi-key":
                "39087e078fmshc7c370449d8cf9cp17967djsn12c460010a52",
            "content-type": "application/x-www-form-urlencoded"
          },
          body: body)
      .then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 && statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    print(response.body);
    print((json.decode(response.body)));
    List<Identification> identificationFromJson(String str) =>
        List<Identification>.from(
            json.decode(str).map((x) => Identification.fromJson(x)));
    return identificationFromJson(response.body);
  });
}
