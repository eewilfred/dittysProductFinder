import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:untitled/SearchResultModel.dart';

class SearchRequest {

  Future<List<Value>?> getResults(String sku, String details) async {

    final queryParameters = {
      'q': sku + " " + details,
      'pageNumber': '1',
      "pageSize": "5",
    };
    final uri = Uri.https('contextualwebsearch-websearch-v1.p.rapidapi.com', '/api/Search/WebSearchAPI', queryParameters);

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      "x-rapidapi-host": "contextualwebsearch-websearch-v1.p.rapidapi.com",
      "x-rapidapi-key": "76f1051069mshaa066765f3aa2c5p10c2a5jsnfae5f970daf4"
    };
    final response = await http.get(uri, headers: headers);
    SearchResult? searchResult = searchResultFromJson(response.body);
    if (searchResult == null) {
        return null;
    }
    searchResult.value.sort((Value a, Value b) => a.description.compareTo(b.description));
    // searchResult.value.removeRange(4, searchResult.value.length);
    print("count" + searchResult.value.toString());
    return searchResult.value;
  }
}
