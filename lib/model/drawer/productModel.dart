

import 'dart:convert';

ProductModelClass productModelClassFromJson(String str) => ProductModelClass.fromJson(json.decode(str));

String productModelClassToJson(ProductModelClass data) => json.encode(data.toJson());

class ProductModelClass {
    String name;
    String img;
    String category;

    ProductModelClass({
        required this.name,
        required this.img,
        required this.category,
    });

    factory ProductModelClass.fromJson(Map<String, dynamic> json) => ProductModelClass(
        name: json["name"],
        img: json["img"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "img": img,
        "category": category,
    };
}
