// To parse this JSON data, do
//
//     final itData = itDataFromJson(jsonString);

import 'dart:convert';

ItData itDataFromJson(String str) => ItData.fromJson(json.decode(str));

String itDataToJson(ItData data) => json.encode(data.toJson());

class ItData {
  List<Item> items;

  ItData({
    required this.items,
  });

  factory ItData.fromJson(Map<String, dynamic> json) => ItData(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  int id;
  String itemNo;
  String barcodes;
  String description;
  String uom;
  int uomWeight;
  String packageUom;

  Item({
    required this.id,
    required this.itemNo,
    required this.barcodes,
    required this.description,
    required this.uom,
    required this.uomWeight,
    required this.packageUom,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        itemNo: json["item_no"],
        barcodes: json["barcodes"],
        description: json["description"],
        uom: json["uom"],
        uomWeight: json["uom_weight"],
        packageUom: json["package_uom"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_no": itemNo,
        "barcodes": barcodes,
        "description": description,
        "uom": uom,
        "uom_weight": uomWeight,
        "package_uom": packageUom,
      };
}
