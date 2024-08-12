import 'package:ecommerce/models/product_model.dart';


class WishModel {
  String? sId;
  ProductModel? productId;
  String? userId;
  int? iV;

  WishModel({this.sId,  this.productId,  this.userId, this.iV});

  WishModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['productId'] != null
        ? new ProductModel.fromJson(json['productId'])
        : null;
    userId = json['userId'];

    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.productId != null) {
      data['productId'] = this.productId!.toJson();
    }
    data['userId'] = this.userId;

    data['__v'] = this.iV;
    return data;
  }
}

