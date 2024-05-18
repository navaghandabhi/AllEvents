// To parse this JSON data, do
//
//     final categoryData = categoryDataFromJson(jsonString);

import 'dart:convert';

List<CategoryData> categoryDataFromJson(String str) => List<CategoryData>.from(json.decode(str).map((x) => CategoryData.fromJson(x)));

String categoryDataToJson(List<CategoryData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryData {
  final String? category;
  final String? data;

  CategoryData({
    this.category,
    this.data,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        category: json["category"] ?? "",
        data: json["data"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "data": data,
      };
}
