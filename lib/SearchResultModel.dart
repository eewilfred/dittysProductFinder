
import 'dart:convert';

// To parse this JSON data, do
//
//     final searchResult = searchResultFromJson(jsonString);



SearchResult searchResultFromJson(String str) => SearchResult.fromJson(json.decode(str));

String searchResultToJson(SearchResult data) => json.encode(data.toJson());

class SearchResult {
  SearchResult({
    required this.didUMean,
    required this.totalCount,
    required this.value,
  });

  final String didUMean;
  final int totalCount;
  final List<Value> value;

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
    didUMean: json["didUMean"] == null && !(json["didUMean"] is String) ? "null" : json["didUMean"],
    totalCount: json["totalCount"] == null && !(json["totalCount"] is int) ? 0 : json["totalCount"],
    value: json["value"] == null ? [] : List<Value>.from(json["value"].map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "didUMean": didUMean == null ? "null" : didUMean,
    "totalCount": totalCount == null ? "null" : totalCount,
    "value": value == null ? [] : List<dynamic>.from(value.map((x) => x.toJson())),
  };
}

class Value {
  Value({
    required this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.body,
  });

  final String id;
  final String title;
  final String url;
  final String description;
  final String body;


  factory Value.fromJson(Map<String, dynamic> json) => Value(
    id: json["id"] == null && !(json["id"] is String)  ? "" : json["id"],
    title: json["title"] == null && !(json["title"] is String) ? "null" : json["title"],
    url: json["url"] == null && !(json["url"] is String) ? null : json["url"],
    description: json["description"] == null && !(json["description"] is String) ? 'null' : json["description"],
    body: json["body"] == null && !(json["body"] is String) ? "null" : json["body"]
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "url": url == null ? null : url,
    "description": description == null ? null : description,
    "body": body == null ? null : body
  };
}