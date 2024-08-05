import 'package:ecommerce/models/product_model.dart';

class whislistModel {
  String? sId;
  ProductModel? productId;
  String? userId;
  String? status;
  int? quantity;
  int? iV;

  whislistModel(
      {this.sId,
        this.productId,
        this.userId,
        this.status,
        this.quantity,
        this.iV});

  whislistModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['productId'] != null
        ? new ProductModel.fromJson(json['productId'])
        : null;
    userId = json['userId'];
    status = json['status'];
    quantity = json['quantity'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.productId != null) {
      data['productId'] = this.productId!.toJson();
    }
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['quantity'] = this.quantity;
    data['__v'] = this.iV;
    return data;
  }
}

class ProductId {
  String? sId;
  String? title;
  String? description;
  String? review;
  String? image;
  String? seller;
  int? price;
  String? category;
  double? rate;
  int? quantity;
  int? iV;}