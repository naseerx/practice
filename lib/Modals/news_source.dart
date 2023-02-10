
import 'dart:convert';

NewsSourceModel newsSourceModelFromJson(String str) => NewsSourceModel.fromJson(json.decode(str));


class NewsSourceModel {
  NewsSourceModel({
    required this.message,
    required this.sources,
  });

  String message;
  List<String> sources;


  factory NewsSourceModel.fromJson(Map<String, dynamic> json) => NewsSourceModel(
    message: json["message"],
    sources: List<String>.from(json["sources"].map((x) => x)),
  );

}

