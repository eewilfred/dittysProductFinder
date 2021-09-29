
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
    didUMean: json["didUMean"] as String,
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    value: List<Value>.from(json["value"].map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "didUMean": didUMean == null ? null : didUMean,
    "totalCount": totalCount == null ? null : totalCount,
    "value": value == null ? null : List<dynamic>.from(value.map((x) => x.toJson())),
  };
}

class Value {
  Value({
    required this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.body,
    required this.snippet,
    required this.language,
    required this.isSafe,
  });

  final String id;
  final String title;
  final String url;
  final String description;
  final String body;
  final String snippet;
  final String language;
  final bool isSafe;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    url: json["url"] == null ? null : json["url"],
    description: json["description"] == null ? null : json["description"],
    body: json["body"] == null ? null : json["body"],
    snippet: json["snippet"] == null ? null : json["snippet"],
    language: json["language"] == null ? null : json["language"],
    isSafe: json["isSafe"] == null ? null : json["isSafe"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "url": url == null ? null : url,
    "description": description == null ? null : description,
    "body": body == null ? null : body,
    "snippet": snippet == null ? null : snippet,
    "language": language == null ? null : language,
    "isSafe": isSafe == null ? null : isSafe,
  };
}